import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kpi_app/Engine/measuring.dart';

import 'package:kpi_app/constants.dart';
import 'package:kpi_app/routes/app_router.dart';
import 'package:kpi_app/routes/app_router.gr.dart';
import 'package:rive_splash_screen/rive_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final AppRouter appRouter = AppRouter();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //what is this chrome
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

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
          future: _isOnboarding(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              return SplashScreen.navigate(
                name: "assets/animation/kp_splash.riv",
                backgroundColor: kPrimaryColor,
                next: (context) => MaterialApp.router(
                  routeInformationParser: appRouter.defaultRouteParser(),
                  routerDelegate: AutoRouterDelegate(
                    appRouter,
                    initialRoutes: [
                      if (snapshot.data!) const RouteMange(),
                      if (!snapshot.data!) const OnBoardingRoute(),
                    ],
                  ),
                ),
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

Future<bool> _isOnboarding() async {
  SharedPreferences checked = await SharedPreferences.getInstance();
  await SqfL.oneTime();
  return checked.getBool("checked") ?? false;
}
