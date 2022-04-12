import 'package:flutter/material.dart';
import 'package:kpi_app/Screens/Measure/page_manage.dart';
import 'package:kpi_app/constants.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late bool isFirstOneOpen = false;
  late bool isSecondOneOpen = false;
  late bool isLastOneOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "راهنمای استفاده",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: "Vazir",
                  color: kShadeDarkColor,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "کاربر گرامی شما در این برنامه میتوانید پارامترهای مختلف لوله مورد نظر خود که شامل وزن, اندازه, ضخامت و جنس لوله میباشد را سنجش و مناسب ترین محصول را انتخاب نمایید",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: kShadeDarkColor,
                  fontSize: 14,
                  fontFamily: "Vazir",
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    //Column for gestures
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (!isFirstOneOpen) {
                            setState(() {
                              isFirstOneOpen = true;
                            });
                          } else {
                            setState(() {
                              isFirstOneOpen = false;
                            });
                          }
                        },
                        child: Column(
                          children: [
                            DropDownIntroWidgets(
                              isOpen: isFirstOneOpen,
                              name: "اندازه گیری",
                              //Measure
                              desc: "اندازه مد نظر خود را انتخاب کنید",
                              iconPath: Icons.transform_outlined,
                            ),
                            !isFirstOneOpen
                                ? const SizedBox()
                                : Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    width: double.infinity,
                                    decoration: const BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        color: Color(0x400D6472),
                                        blurRadius: 15,
                                      )
                                    ]),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 30, horizontal: 25),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: const [
                                            Text(
                                              "در صفحه اندازه گیری میتوانید مشخصات لوله مورد نظر خود را وارد نموده و نتیجه آن را ملاحظه نمایید",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: kShadeDarkColor,
                                                fontFamily: "Vazir",
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (!isSecondOneOpen) {
                            setState(() {
                              isSecondOneOpen = true;
                            });
                          } else {
                            setState(() {
                              isSecondOneOpen = false;
                            });
                          }
                        },
                        child: Column(
                          children: [
                            DropDownIntroWidgets(
                              isOpen: isSecondOneOpen,
                              name: "استاندارد",
                              //Standard
                              desc: "استاندارد های  لوله",
                              iconPath: Icons.document_scanner_outlined,
                            ),
                            !isSecondOneOpen
                                ? const SizedBox()
                                : Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    decoration: const BoxDecoration(boxShadow: [
                                      BoxShadow(
                                          color: Color(0x400D6472),
                                          blurRadius: 15)
                                    ]),
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 30),
                                          child: Column(
                                            children: const [
                                              Text(
                                                "از تمام استاندارد های لوله های پلی اتیلن باخبر شوید",
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  color: kShadeDarkColor,
                                                  fontFamily: "Vazir",
                                                  fontSize: 14,
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                  )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (!isLastOneOpen) {
                              isLastOneOpen = true;
                            } else {
                              isLastOneOpen = false;
                            }
                          });
                        },
                        child: Column(
                          children: [
                            DropDownIntroWidgets(
                              isOpen: isLastOneOpen,
                              name: "درباره ما",
                              desc: "در مورد شرکت ما بدانید.",
                              iconPath: Icons.business_center_outlined,
                            ),
                            !isLastOneOpen
                                ? const SizedBox()
                                : Container(
                                    decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x400D6472),
                                          blurRadius: 20,
                                        ),
                                      ],
                                    ),
                                    margin: const EdgeInsets.only(top: 20),
                                    child: Card(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 30),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: const [
                                            Text(
                                              "شرکت پلی اتیلن کرمان",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: kShadeDarkColor,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Vazir",
                                              ),
                                            ),
                                            SizedBox(
                                              height: 25,
                                            ),
                                            RowWidgetOnBoarding(
                                              textHighLight: "شرکت",
                                              desc: "۰۳۴۳۲۷۵۰۱۹۷",
                                              icon: Icons.call_outlined,
                                            ),
                                            SizedBox(
                                              height: 25,
                                            ),
                                            RowWidgetOnBoarding(
                                              textHighLight: "منشی",
                                              desc: "Info@kpico.co",
                                              icon: Icons.email_outlined,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const PageMange(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: kShadeDarkColor, shape: BoxShape.circle),
                        child: const Icon(
                          Icons.arrow_back_outlined,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Text(
                      "ورود به برنامه",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: kShadeDarkColor,
                        fontFamily: "Vazir",
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RowWidgetOnBoarding extends StatelessWidget {
  const RowWidgetOnBoarding({
    Key? key,
    required this.icon,
    required this.textHighLight,
    required this.desc,
  }) : super(key: key);

  final IconData icon;
  final String textHighLight;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          desc,
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: kShadeDarkColor,
            fontFamily: "Vazir",
            fontSize: 16,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            color: kShadeDarkColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 20,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class DropDownIntroWidgets extends StatelessWidget {
  DropDownIntroWidgets({
    Key? key,
    required this.name,
    required this.desc,
    required this.iconPath,
    required this.isOpen,
  }) : super(key: key);
  final String name;
  final String desc;
  final IconData iconPath;
  late bool isOpen;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: !isOpen ? kBackGroundColor : kShadeOnBoarding,
        border: Border.all(color: kShadeLiteColor),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      color: kShadeDarkColor,
                      fontFamily: "Vazir",
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 24,
                        color: kShadeDarkColor,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        desc,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: "Vazir",
                          color: kShadeDarkColor,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin:
                const EdgeInsets.only(left: 18, right: 25, top: 20, bottom: 20),
            decoration: BoxDecoration(
              color: isOpen ? Colors.white : kShadePrimary,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              iconPath,
              color: !isOpen ? kOpacityShade : kShadeDarkColor,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
