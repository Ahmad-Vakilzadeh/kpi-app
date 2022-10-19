import 'package:flutter/material.dart';

import 'package:intl/intl.dart' as intl;

import 'package:kpi_app/Screens/factorCreate/widgets/factor_card.dart';
import 'package:kpi_app/Screens/factorCreate/widgets/factor_create_button.dart';
import 'package:kpi_app/Screens/factorCreate/widgets/factor_create_card.dart';

import 'package:kpi_app/Widgets/input_measure.dart';
import 'package:kpi_app/main.dart';
import '../../constants.dart';

int peNumber = 100;
int exdia = 250;
double? pressure = 4;
var formatter = intl.NumberFormat('###,###,###');

class FactorCreate extends StatefulWidget {
  const FactorCreate({Key? key}) : super(key: key);

  @override
  State<FactorCreate> createState() => _FactorCreateState();
}

class _FactorCreateState extends State<FactorCreate> {
  late TextEditingController nameController;
  late TextEditingController moneyCount;
  late TextEditingController meterControllerMain;
  late List<Map<String, dynamic>> reciptList = [];
  late TextEditingController searchBarController;

  @override
  void initState() {
    super.initState();
    searchBarController = TextEditingController();
    meterControllerMain = TextEditingController();
    nameController = TextEditingController();
    moneyCount = TextEditingController();
  }

  double getNumberFromController(TextEditingController c) {
    if (c.text == "") {
      return 0;
    } else {
      return double.parse(c.text.replaceAll(",", ""));
    }
  }

  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text(
              "پاک شدن داده ها",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: kShadeDarkColor,
                fontSize: 20,
                fontFamily: "Vazir",
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              "با خروج از این صفحه داده های وارد شده پاک میشوند",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: kShadeDarkColor,
                fontSize: 14,
                fontFamily: "Vazir",
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text(
                  "خروج از صفحه",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontFamily: "Vazir",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text(
                  "باشد",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: kShadeDarkColor,
                    fontSize: 14,
                    fontFamily: "Vazir",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: kShadeDarkColor),
          backgroundColor: Colors.white,
          elevation: 5,
          centerTitle: true,
          title: const Text(
            "صدور پیش فاکتور",
            style: TextStyle(
              color: kShadeDarkColor,
              fontFamily: "Vazir",
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 25,
                        color: Color(0x200D6472),
                      )
                    ],
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 25,
                            right: 20,
                            bottom: 25,
                          ),
                          child: const Text(
                            "پارامتر ها",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: kShadeDarkColor,
                              fontSize: 24,
                              fontFamily: "Vazir",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: InputMeasure(
                              numberOnly: false,
                              hintText: "اسم کامل مشتری",
                              icon: Icons.account_circle_outlined,
                              name: "اسم مشتری",
                              customController: nameController,
                              onChange: () {}),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: InputMeasure(
                            numberOnly: true,
                            hintText: "قیمت هر کیلوگرم لوله",
                            icon: Icons.money_outlined,
                            name: "قیمت هر کیلوگرم لوله",
                            customController: moneyCount,
                            onChange: () {
                              setState(() {});
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                FactorCreateCard(
                  exdiaTextOne: exdia.toString(),
                  peNumberTextOne: peNumber.toString(),
                  pressureTextOne: pressure.toString(),
                  meterControllerMain: meterControllerMain,
                  addingFunction: () async {
                    bool checker = true;
                    for (var element in reciptList) {
                      if (element["peNumber"] == peNumber &&
                          element["pressure"] == pressure &&
                          element["exdia"] == exdia) {
                        checker = false;
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  "لوله ای که اضافه کرده اید \nتکراری است",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: kShadeDarkColor,
                                    fontSize: 18,
                                    fontFamily: "Vazir",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (reciptList.length < 7) {
                                          setState(() {
                                            if (meterControllerMain
                                                        .value.text !=
                                                    "متراژ" &&
                                                meterControllerMain
                                                        .value.text !=
                                                    "") {
                                              reciptList.add({
                                                "meter": meterControllerMain
                                                    .value.text
                                                    .replaceAll(",", "")
                                                    .toString(),
                                                "peNumber": peNumber,
                                                "pressure": pressure,
                                                "exdia": exdia,
                                              });
                                            }
                                          });
                                        }
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "اضافه کردن لوله",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontFamily: "Vazir",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "باشد",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: kShadeDarkColor,
                                          fontSize: 14,
                                          fontFamily: "Vazir",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      }
                    }
                    if (reciptList.length < 7 && checker) {
                      setState(() {
                        if (meterControllerMain.value.text != "متراژ" &&
                            meterControllerMain.value.text != "") {
                          reciptList.add({
                            "meter": meterControllerMain.value.text
                                .replaceAll(",", "")
                                .toString(),
                            "peNumber": peNumber,
                            "pressure": pressure,
                            "exdia": exdia,
                          });
                        }
                      });
                    }
                  },
                  sBarController: searchBarController,
                ),
                const SizedBox(
                  height: 10,
                ),
                FactorCard(reciptList: reciptList),
                const SizedBox(
                  height: 20,
                ),
                CompleteFactorButton(
                  moneyCount: getNumberFromController(moneyCount),
                  name: nameController.value.text,
                  reciptListBottom: reciptList,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
