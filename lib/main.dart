import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kpi_app/Engine/measuring.dart';
import 'package:app_links/app_links.dart';

import 'package:kpi_app/Screens/OnBoardingScreens/on_boarding.dart';
import 'package:kpi_app/constants.dart';
import 'package:kpi_app/routes/app_router.dart';
import 'package:rive_splash_screen/rive_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

int CheckInitial = 0;
bool isLink = false;
String UrlPath = '';
void main() {
  final _appLinks = AppLinks();

// Subscribe to all events when app is started.
// (Use allStringLinkStream to get it as [String])
  _appLinks.allUriLinkStream.listen((uri) {
    // Do something (navigation, ...)
    isLink = true;
    UrlPath = uri.path.replaceFirst('/', '');
    print(UrlPath);
  });

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}
final AppRouter appRouter = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KPI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
          future: _isShownChecker(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              return SplashScreen.navigate(
                name: "assets/animation/kp_splash.riv",
                backgroundColor: kPrimaryColor,
                next: (context) => snapshot.data!
                    ? MaterialApp.router(
                  routerConfig: appRouter.config(),
                )
                    : const OnBoardingScreen(),
                until: () => Future.delayed(const Duration(milliseconds: 1500)),
                startAnimation: 'icon animation',
              );
            } else {
              return Container(
                color: Colors.blue,
              );
            }
          }),
    );
  }
}

Future<bool> _isShownChecker() async {
  SharedPreferences checked = await SharedPreferences.getInstance();
  await SqfL.oneTime();
  bool checker = checked.getBool("checked") ?? false;
  if (isLink) {
    CheckInitial = 3;
    return true;
  }
  if (checker) {
    CheckInitial = 1;
    return true;

  } else {
    await checked.setBool('checked', true);
    CheckInitial = 2;
    return false;
  }
}
