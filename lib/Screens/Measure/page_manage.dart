import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kpi_app/Screens/AboutUs/about_us.dart';
import 'package:kpi_app/Screens/MeasureScreen/measure_screen.dart';
import 'package:kpi_app/Screens/OnBoardingScreens/on_boarding.dart';
import 'package:kpi_app/Screens/Standards/standards_screen.dart';
import 'package:kpi_app/Screens/factorCreate/factor_create.dart';
import 'package:kpi_app/Widgets/BottomNavigation/bottom_navigation.dart';
import 'package:kpi_app/constants.dart';

class PageMange extends StatefulWidget {
  const PageMange({Key? key}) : super(key: key);

  @override
  _PageMangeState createState() => _PageMangeState();
}

class _PageMangeState extends State<PageMange>
    with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;
  final List<Color> colors = [
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.pink
  ];

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 2, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(color: kShadeDarkColor),
          title: const Text(
            "صنایع پلی اتیلن کرمان",
            style: TextStyle(
              color: kShadeDarkColor,
              fontFamily: "Vazir",
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 5,
        ),
        endDrawer: Drawer(
          backgroundColor: Colors.white,
          elevation: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 15, top: 15, right: 15),
                  child: const Text(
                    "صفحه های دیگر",
                    style: TextStyle(
                      color: kShadeDarkColor,
                      fontSize: 24,
                      fontFamily: "Vazir",
                    ),
                  )),
              const Divider(
                color: kShadeDarkColor,
                height: 6,
              ),
              ListTile(
                leading: const Icon(
                  Icons.receipt_long_rounded,
                  color: kShadeDarkColor,
                ),
                title: const Text(
                  "پیشنهاد قیمت",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: kShadeDarkColor,
                    fontSize: 18,
                    fontFamily: "Vazir",
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FactorCreate()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.help_outline,
                  color: kShadeDarkColor,
                ),
                title: const Text(
                  "طرز استفاده از برنامه",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: kShadeDarkColor,
                    fontSize: 18,
                    fontFamily: "Vazir",
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OnBoardingScreen()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.phone_outlined,
                  color: kShadeDarkColor,
                ),
                title: const Text(
                  "درباره ما",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: kShadeDarkColor,
                    fontSize: 18,
                    fontFamily: "Vazir",
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const AboutUs()));
                },
              )
            ],
          ),
        ),
        body: BottomBar(
          currentPage: currentPage,
          tabController: tabController,
          unSelectedColor: kPrimaryColor,
          barColor: Colors.white,
          start: 20,
          end: 2,
          child: TabBarView(
            controller: tabController,
            dragStartBehavior: DragStartBehavior.down,
            physics: const BouncingScrollPhysics(),
            children: const [
              MeasureScreen(),
              StandardsScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
