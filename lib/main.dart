import 'package:flutter/material.dart';
import 'package:kpi_app/Engine/measuring.dart';
import 'package:kpi_app/Screens/Measure/page_manage.dart';

import 'package:kpi_app/Screens/OnBoardingScreens/on_boarding.dart';
import 'package:kpi_app/constants.dart';
import 'package:rive_splash_screen/rive_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
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
          future: _isShownChecker(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              print("hello this is working ******");
              return SplashScreen.navigate(
                name: "assets/animation/kp_splash.riv",
                backgroundColor: kPrimaryColor,
                next: (context) => snapshot.data!
                    ? const PageMange()
                    : const OnBoardingScreen(),
                until: () => Future.delayed(const Duration(seconds: 1)),
                startAnimation: 'Animation 1',
              );
            } else {
              print("hello this is not working");
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

  if (checker) {
    return true;
  } else {
    await checked.setBool('checked', true);
    return false;
  }
}
