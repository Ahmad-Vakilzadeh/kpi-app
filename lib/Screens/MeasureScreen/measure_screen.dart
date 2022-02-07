import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kpi_app/Engine/measuring.dart';
import 'package:kpi_app/Widgets/input_measure.dart';
import 'package:kpi_app/Widgets/input_selector.dart';
import 'package:kpi_app/Widgets/pipe_type.dart';
import 'package:kpi_app/constants.dart';

late int peNumber = 100;
late int exdia = 250;
late double? pressure = 4;

class MeasureScreen extends StatefulWidget {
  const MeasureScreen({Key? key}) : super(key: key);

  @override
  _MeasureScreenState createState() => _MeasureScreenState();
}

class _MeasureScreenState extends State<MeasureScreen>
    with SingleTickerProviderStateMixin {
  //for tab controller
  late int currentPage;
  late TabController tabController;
  late ScrollController _controller;
  //for tab controller
  late List<Map<String, dynamic>> calculatedAnswer;
  // errors for not existing
  late bool errorStatepressure = false;
  late bool errorStateExdia = false;
  late bool errorStatePe = false;
  // errors for not existing
  // controllers for exida and preesure
  late TextEditingController moneyCount;
  late TextEditingController lengthCount;
  // controllers for exida and preesure

  @override
  void initState() {
    super.initState();
    //controllers
    moneyCount = TextEditingController();
    lengthCount = TextEditingController();
    //controllers
    // tab controller
    _controller = ScrollController()
      ..addListener(() {
        setState(() {});
      });
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
    // tab controller
  }

  @override
  void dispose() {
    tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

  // Loading data for future
  Future<List<Map<String, Object?>>> loadingDataAtStart() async {
    var data = await SqfL.open();
    calculatedAnswer = await data.rawQuery(
        "SELECT DISTINCT * FROM pe WHERE PE = $peNumber AND exdia= $exdia AND pressure = $pressure");
    if (data.rawQuery(
            "SELECT DISTINCT * FROM pe WHERE PE = $peNumber AND exdia= $exdia AND pressure = $pressure") ==
        null) {
      return [];
    } else {
      return calculatedAnswer;
    }
  }
  // Loading data for future

// for general function
  // for tabController
  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }
  //for tabController

  // returner for TXTFROM
  getNumberFromController(TextEditingController c) {
    if (c.text == "") {
      return 0;
    } else {
      return int.parse(c.text);
    }
  }
  // returner for TXTFROM

  //bottom sheet exdia
  widgetReturnerExdia(
      List<Map<String, dynamic>> allData, List<String> notAvalible) {
    List<Widget> mainResult = [];
    allData.forEach((element) {
      if (notAvalible.contains(element["exdia"].toString())) {
        mainResult.add(ListTile(
          leading: const Icon(Icons.circle_outlined),
          title: Text(
            "${element["exdia"]}",
            style: const TextStyle(color: Colors.grey),
          ),
          onTap: () {
            setState(() {
              errorStateExdia = true;
              exdia = element["exdia"];
              Navigator.pop(context);
            });
          },
        ));
      } else {
        mainResult.add(ListTile(
          leading: const Icon(Icons.circle_outlined),
          title: Text(
            "${element["exdia"]}",
            style: const TextStyle(color: Colors.black),
          ),
          onTap: () {
            setState(() {
              errorStateExdia = false;
              exdia = element["exdia"];
              Navigator.pop(context);
            });
          },
        ));
      }
    });
    return mainResult;
  }

  notAvalibleResultExdia(List<Map<String, dynamic>> selectedListOne,
      List<Map<String, dynamic>> selectedListTwo) {
    List<String> khers = [];
    selectedListOne.forEach((element1) {
      bool isSame = false;
      selectedListTwo.forEach((element2) {
        if (element1["exdia"] == element2["exdia"]) {
          isSame = true;
        }
      });
      if (!isSame) {
        khers.add(element1["exdia"].toString());
      }
    });

    return khers;
  }

  widgetRetunerPressure(
      List<Map<String, dynamic>> allData, List<String> notAvalible) {
    List<Widget> mainResult = [];
    allData.forEach((element) {
      if (notAvalible.contains(element["pressure"].toString())) {
        mainResult.add(ListTile(
          leading: const Icon(Icons.circle_outlined),
          title: Text(
            "${element["pressure"]}",
            style: const TextStyle(color: Colors.grey),
          ),
          onTap: () {
            setState(() {
              errorStatepressure = true;
              pressure = double.tryParse(element["pressure"].toString());
              Navigator.pop(context);
            });
          },
        ));
      } else {
        mainResult.add(ListTile(
          leading: const Icon(Icons.circle_outlined),
          title: Text(
            "${element["pressure"]}",
            style: const TextStyle(color: Colors.black),
          ),
          onTap: () {
            setState(() {
              errorStatepressure = false;
              pressure = double.tryParse(element["pressure"].toString());
              Navigator.pop(context);
            });
          },
        ));
      }
    });
    return mainResult;
  }

  notAvalibleResult(List<Map<String, dynamic>> selectedListOne,
      List<Map<String, dynamic>> selectedListTwo) {
    List<String> khers = [];
    selectedListOne.forEach((element1) {
      bool isSame = false;
      selectedListTwo.forEach((element2) {
        if (element1["pressure"] == element2["pressure"]) {
          isSame = true;
        }
      });
      if (!isSame) {
        khers.add(element1["pressure"].toString());
      }
    });

    return khers;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadingDataAtStart(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
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
                              // TITLE
                              Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      "نوع لوله",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: kShadeDarkColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Vazir",
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.select_all_outlined,
                                      color: kPrimaryColor,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: PipeTypeWidget(
                                  onTapOne: () {
                                    setState(() {
                                      peNumber = 80;
                                    });
                                  },
                                  onTapTwo: () {
                                    setState(() {
                                      peNumber = 100;
                                    });
                                  },
                                  onTapThree: () {
                                    setState(() {
                                      peNumber = 80;
                                    });
                                  },
                                  onTapFour: () {
                                    setState(() {
                                      peNumber = 100;
                                    });
                                  },
                                  peNumber: peNumber,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              //PE NUMBER CHANGER
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        var data = await SqfL.open();
                                        List<Map<String, dynamic>> exdiaData =
                                            await data.rawQuery(
                                                "SELECT DISTINCT exdia FROM pe WHERE pressure = $pressure AND PE =$peNumber");
                                        List<Map<String, dynamic>> allData =
                                            await data.rawQuery(
                                                "SELECT DISTINCT exdia FROM pe");
                                        showModalBottomSheet(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            context: context,
                                            builder: (context) {
                                              return SingleChildScrollView(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .all(15),
                                                        child: const Text(
                                                          "قطر لوله را انتخاب کنید",
                                                          style: TextStyle(
                                                              fontSize: 24,
                                                              color:
                                                                  kShadeDarkColor,
                                                              fontFamily:
                                                                  "Vazir"),
                                                        ),
                                                      ),
                                                      const Divider(
                                                          height: 10,
                                                          color:
                                                              kShadeLiteColor),
                                                      Column(
                                                        children:
                                                            widgetReturnerExdia(
                                                          allData,
                                                          notAvalibleResultExdia(
                                                              allData,
                                                              exdiaData),
                                                        ),
                                                      )
                                                    ]),
                                              );
                                            });
                                      },
                                      child: InputSelector(
                                        icon: Icons.playlist_add_check_outlined,
                                        text: exdia.toString(),
                                        name: "قطر لوله",
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        var data = await SqfL.open();
                                        List<Map<String, dynamic>> allData =
                                            await data.rawQuery(
                                                "SELECT DISTINCT pressure FROM pe");
                                        List<Map<String, dynamic>>
                                            pressureData = await data.rawQuery(
                                                "SELECT DISTINCT pressure FROM pe WHERE PE = $peNumber AND exdia= $exdia");
                                        showModalBottomSheet(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            context: context,
                                            builder: (context) {
                                              return SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              15),
                                                      child: const Text(
                                                        "فشار نامی را انتخاب کنید",
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            color:
                                                                kShadeDarkColor,
                                                            fontFamily:
                                                                "Vazir"),
                                                      ),
                                                    ),
                                                    const Divider(
                                                      height: 10,
                                                      color: kShadeDarkColor,
                                                    ),
                                                    Column(
                                                      children:
                                                          widgetRetunerPressure(
                                                              allData,
                                                              notAvalibleResult(
                                                                  allData,
                                                                  pressureData)),
                                                    )
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      child: InputSelector(
                                        icon: Icons.playlist_add_check_outlined,
                                        text: pressure.toString(),
                                        name: "فشار نامی",
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: InputMeasure(
                                  hintText: "متراز لوله به متر",
                                  icon: Icons.select_all_outlined,
                                  name: "متراژ لوله",
                                  customController: lengthCount,
                                  onChange: () {
                                    setState(() {});
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: InputMeasure(
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
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  "مقادیر محاسبه شده",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: kShadeDarkColor,
                                    fontFamily: "Vazir",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      errorStateExdia
                                          ? "ضخامت را عوض کنید"
                                          : errorStatepressure
                                              ? "فشار را عوص کنید"
                                              : snapshot.data[0]["thicknessmm"]
                                                  .toString(),
                                      style: const TextStyle(
                                        color: kShadeDarkColor,
                                        fontFamily: "Vazir",
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "ضخامت لوله",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: kShadeDarkColor,
                                        fontFamily: "Vazir",
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      errorStateExdia
                                          ? "ضخامت را عوض کنید"
                                          : errorStatepressure
                                              ? "فشار را عوص کنید"
                                              : snapshot.data[0]["weight"]
                                                  .toStringAsFixed(4),
                                      style: const TextStyle(
                                        color: kShadeDarkColor,
                                        fontFamily: "Vazir",
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "وزن هر متر لوله",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: kShadeDarkColor,
                                        fontFamily: "Vazir",
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      errorStateExdia
                                          ? "ضخامت را عوض کنید"
                                          : errorStatepressure
                                              ? "فشار را عوص کنید"
                                              : (snapshot.data[0]["weight"] *
                                                      getNumberFromController(
                                                          lengthCount))
                                                  .toStringAsFixed(4),
                                      style: const TextStyle(
                                        color: kShadeDarkColor,
                                        fontFamily: "Vazir",
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "وزن مجموع تراز",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: kShadeDarkColor,
                                        fontFamily: "Vazir",
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      errorStateExdia
                                          ? "ضخامت را عوض کنید"
                                          : errorStatepressure
                                              ? "فشار را عوص کنید"
                                              : (snapshot.data[0]["exdia"] /
                                                          snapshot.data[0]
                                                              ["thicknessmm"]
                                                      as double)
                                                  .toStringAsFixed(2),
                                      style: const TextStyle(
                                        color: kShadeDarkColor,
                                        fontFamily: "Vazir",
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "نسبت قطر به ضخامت",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: kShadeDarkColor,
                                        fontFamily: "Vazir",
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  height: 3,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      errorStateExdia
                                          ? "ضخامت را عوض کنید"
                                          : errorStatepressure
                                              ? "فشار را عوص کنید"
                                              : (snapshot.data[0]["weight"] *
                                                      getNumberFromController(
                                                          moneyCount))
                                                  .toStringAsFixed(2),
                                      style: const TextStyle(
                                        color: kShadeDarkColor,
                                        fontFamily: "Vazir",
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "قیمت هر متر لوله",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: kShadeDarkColor,
                                        fontFamily: "Vazir",
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      errorStateExdia
                                          ? "ضخامت را عوض کنید"
                                          : errorStatepressure
                                              ? "فشار را عوص کنید"
                                              : (getNumberFromController(
                                                          lengthCount) *
                                                      snapshot.data[0]
                                                          ["weight"] *
                                                      getNumberFromController(
                                                          moneyCount))
                                                  .toStringAsFixed(4),
                                      style: const TextStyle(
                                        color: kShadeDarkColor,
                                        fontFamily: "Vazir",
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "قیمت مجموع متراژ",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: kShadeDarkColor,
                                        fontFamily: "Vazir",
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 200,
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator(
              color: kShadeDarkColor,
              backgroundColor: Colors.white,
              strokeWidth: 2,
            );
          }
        });
  }
}
