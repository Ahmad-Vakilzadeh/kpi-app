import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:kpi_app/Engine/measuring.dart';
import 'package:kpi_app/Widgets/input_measure.dart';
import 'package:kpi_app/Widgets/input_selector.dart';
import 'package:kpi_app/Widgets/pipe_type.dart';
import 'package:kpi_app/constants.dart';

int peNumber = 100;
int exdia = 250;
double? pressure = 4;
var formatter = intl.NumberFormat('###,###,###');

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
    if (calculatedAnswer.isEmpty) {
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
      return double.parse(c.text);
    }
  }
  // returner for TXTFROM

  widgetReturnerAllPipes(List<Map<String, dynamic>> allData) {
    List<Widget> mainResult = [];
    for (var element in allData) {
      mainResult.add(GestureDetector(
        onTap: () {
          setState(() {
            peNumber = element["PE"];
            pressure = double.tryParse(element["pressure"].toString());
            exdia = element["exdia"];
            Navigator.of(context).pop();
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            // border: Border.all(color: kShadeDarkColor),
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xffC6E0E8),
          ),
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Center(
                    child: Text(
                      "${element["PE"]}",
                      style: const TextStyle(
                        color: kShadeDarkColor,
                        fontFamily: "Vazir",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Center(
                    child: Text(
                      "${element["pressure"]}",
                      style: const TextStyle(
                        color: kShadeDarkColor,
                        fontFamily: "Vazir",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Center(
                    child: Text(
                      "${element["exdia"]}",
                      style: const TextStyle(
                        color: kShadeDarkColor,
                        fontFamily: "Vazir",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ));
    }
    return mainResult;
  }

  //bottom sheet exdia
  widgetReturnerExdia(List<Map<String, dynamic>> allData) {
    List<Widget> mainResult = [];
    for (var element in allData) {
      {
        mainResult.add(ListTile(
          leading: const Icon(Icons.circle_outlined),
          title: Text(
            "${element["exdia"]}",
            style: const TextStyle(color: Colors.black),
          ),
          onTap: () {
            setState(() {
              exdia = element["exdia"];
              Navigator.pop(context);
            });
          },
        ));
      }
    }
    return mainResult;
  }

  notAvalibleResultExdia(List<Map<String, dynamic>> selectedListOne,
      List<Map<String, dynamic>> selectedListTwo) {
    List<String> khers = [];
    for (var element1 in selectedListOne) {
      bool isSame = false;
      for (var element2 in selectedListTwo) {
        if (element1["exdia"] == element2["exdia"]) {
          isSame = true;
        }
      }
      if (!isSame) {
        khers.add(element1["exdia"].toString());
      }
    }

    return khers;
  }

  widgetRetunerPressure(List<Map<String, dynamic>> allData) {
    List<Widget> mainResult = [];
    for (var element in allData) {
      {
        mainResult.add(ListTile(
          leading: const Icon(Icons.circle_outlined),
          title: Text(
            "${element["pressure"]}",
            style: const TextStyle(color: Colors.black),
          ),
          onTap: () {
            setState(() {
              pressure = double.tryParse(element["pressure"].toString());
              Navigator.pop(context);
            });
          },
        ));
      }
    }
    return mainResult;
  }

  notAvalibleResult(List<Map<String, dynamic>> selectedListOne,
      List<Map<String, dynamic>> selectedListTwo) {
    List<String> khers = [];
    for (var element1 in selectedListOne) {
      bool isSame = false;
      for (var element2 in selectedListTwo) {
        if (element1["pressure"] == element2["pressure"]) {
          isSame = true;
        }
      }
      if (!isSame) {
        khers.add(element1["pressure"].toString());
      }
    }

    return khers;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadingDataAtStart(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final noSuchPipeExists =
                !snapshot.hasData || (snapshot.data as List).isEmpty;
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
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () async {
                                          var data = await SqfL.open();
                                          // List<Map<String, dynamic>> exdiaData =
                                          // await data.rawQuery(
                                          // "SELECT DISTINCT exdia FROM pe WHERE pressure = $pressure AND PE =$peNumber order by exdia");
                                          List<Map<String, dynamic>> allData =
                                              await data.rawQuery(
                                                  "SELECT DISTINCT exdia FROM pe order by exdia");
                                          showModalBottomSheet(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              context: context,
                                              builder: (context) {
                                                return SingleChildScrollView(
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
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
                                                          ),
                                                        ),
                                                      ]),
                                                );
                                              });
                                        },
                                        child: InputSelector(
                                          icon:
                                              Icons.playlist_add_check_outlined,
                                          text: exdia.toString(),
                                          name: "قطر لوله",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () async {
                                          var data = await SqfL.open();
                                          List<Map<String, dynamic>> allData =
                                              await data.rawQuery(
                                                  "SELECT DISTINCT pressure FROM pe order by pressure");
                                          // List<Map<String, dynamic>>
                                          // pressureData =
                                          // await data.rawQuery(
                                          // "SELECT DISTINCT pressure FROM pe WHERE PE =$peNumber AND exdia=$exdia order by pressure");
                                          showModalBottomSheet(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              context: context,
                                              builder: (context) {
                                                return SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .all(15),
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
                                                                allData),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        child: InputSelector(
                                          icon:
                                              Icons.playlist_add_check_outlined,
                                          text: pressure.toString(),
                                          name: "فشار نامی",
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              if (noSuchPipeExists) ...[
                                Center(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      "لوله‌ای از نوع PE$peNumber با فشارنامی $pressure و قطر ${exdia}mm موجود نیست، لطفا لوله دیگری انتخاب بفرمایید. لطفا فهرست همه لوله ها را ملاحظه بفرمایید.",
                                      softWrap: true,
                                      textDirection: TextDirection.rtl,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontFamily: "Vazir",
                                        fontWeight: FontWeight.w900,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                              ],
                              GestureDetector(
                                onTap: () async {
                                  var data = await SqfL.open();
                                  List<
                                      Map<String,
                                          dynamic>> allData = await data.rawQuery(
                                      "SELECT DISTINCT PE,exdia,pressure FROM pe ORDER BY exdia,pressure,exdia");
                                  showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      context: context,
                                      builder: (context) {
                                        return SingleChildScrollView(
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                              vertical: 16,
                                              horizontal: 16,
                                            ),
                                            child: Column(
                                              children: [
                                                const Text(
                                                  "فهرست لوله های قابل سفارش در شرکت صنایع",
                                                  textAlign: TextAlign.center,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    color: kShadeDarkColor,
                                                    fontFamily: "Vazir",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                const Text(
                                                  "پلی اتیلن کرمان",
                                                  textAlign: TextAlign.center,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    color: kShadeDarkColor,
                                                    fontFamily: "Vazir",
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                const Text(
                                                  "برای انتخاب هر یک  از لوله ها روی ردیف مورد نظر بزنید",
                                                  textAlign: TextAlign.center,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Vazir",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                        child: const Center(
                                                          child: Text(
                                                            "PE",
                                                            textAlign: TextAlign
                                                                .center,
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            style: TextStyle(
                                                              color:
                                                                  kShadeDarkColor,
                                                              fontFamily:
                                                                  "Vazir",
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        )),
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                        child: const Center(
                                                          child: Text(
                                                            "فشار نامی",
                                                            textAlign: TextAlign
                                                                .center,
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            style: TextStyle(
                                                              color:
                                                                  kShadeDarkColor,
                                                              fontFamily:
                                                                  "Vazir",
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        )),
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                        child: const Center(
                                                          child: Text(
                                                            "قطر",
                                                            textAlign: TextAlign
                                                                .center,
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            style: TextStyle(
                                                              color:
                                                                  kShadeDarkColor,
                                                              fontFamily:
                                                                  "Vazir",
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Column(
                                                  children:
                                                      widgetReturnerAllPipes(
                                                          allData),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(12),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: kShadeDarkColor,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "فهرست تمامی لوله ها",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Vazir",
                                          fontSize: 16,
                                        ),
                                      ),
                                    )),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: InputMeasure(
                                  hintText: "متراژ لوله به متر",
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
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: Column(
                              children: [
                                noSuchPipeExists
                                    ? Center(
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Text(
                                            "لوله‌ای از نوع PE$peNumber با فشارنامی $pressure و قطر ${exdia}mm موجود نیست، لطفا لوله دیگری انتخاب بفرمایید. لطفا فهرست همه لوله ها را ملاحضه بفرمایید.",
                                            softWrap: true,
                                            textDirection: TextDirection.rtl,
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontFamily: "Vazir",
                                              fontWeight: FontWeight.w900,
                                              fontSize: 12,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
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
                                                getField(snapshot.data,
                                                        "thicknessmm")
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
                                                getField(
                                                        snapshot.data, "weight")
                                                    .toString(),
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
                                                (getField(snapshot.data,
                                                            "weight") *
                                                        getNumberFromController(
                                                            lengthCount))
                                                    .toStringAsFixed(2),
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
                                                getField(snapshot.data,
                                                            "SDR") ==
                                                        getField(snapshot.data,
                                                                "SDR")
                                                            .roundToDouble()
                                                    ? getField(snapshot.data,
                                                            "SDR")
                                                        .toStringAsFixed(0)
                                                    : getField(snapshot.data,
                                                            "SDR")
                                                        .toString(),
                                                style: const TextStyle(
                                                  color: kShadeDarkColor,
                                                  fontFamily: "Vazir",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const Text(
                                                "(SDR)نسبت قطر به ضخامت",
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
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            height: 3,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                color: kPrimaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                formatter.format((getField(
                                                        snapshot.data,
                                                        "weight") *
                                                    getNumberFromController(
                                                        moneyCount))),
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
                                                formatter.format(
                                                    (getNumberFromController(
                                                            lengthCount) *
                                                        getField(snapshot.data,
                                                            "weight") *
                                                        getNumberFromController(
                                                            moneyCount))),
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

double getField(List data, String fieldName) {
  if (data.isEmpty) return -1.0;
  return double.parse(data[0][fieldName].toString());
}
