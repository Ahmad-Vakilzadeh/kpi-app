import 'package:flutter/material.dart';

import 'package:kpi_app/Engine/measuring.dart';
import 'package:kpi_app/Screens/factorCreate/factor_create_screen.dart';
import 'package:kpi_app/Screens/factorCreate/widgets/add_button.dart';
import 'package:kpi_app/Screens/factorCreate/widgets/search_bar.dart';
import 'package:kpi_app/Widgets/input_measure.dart';
import 'package:kpi_app/constants.dart';
import 'package:sqflite/sqflite.dart';

class FactorCreateCard extends StatefulWidget {
  const FactorCreateCard(
      {Key? key,
      required this.meterControllerMain,
      required this.addingFunction,
      required this.exdiaTextOne,
      required this.peNumberTextOne,
      required this.pressureTextOne,
      required this.sBarController})
      : super(key: key);
  final TextEditingController meterControllerMain;
  final Function addingFunction;
  final String exdiaTextOne;
  final String peNumberTextOne;
  final String pressureTextOne;
  final TextEditingController sBarController;

  @override
  State<FactorCreateCard> createState() => _FactorCreateCardState();
}

class _FactorCreateCardState extends State<FactorCreateCard> {
  widgetReturnerAllPipes(
      List<Map<String, dynamic>> allData, TextEditingController controller) {
    List<Widget> mainResult = [];
    for (var element in allData) {
      mainResult.add(
        GestureDetector(
          onTap: () {
            setState(
              () {
                peNumber = element["PE"];
                pressure = double.tryParse(element["pressure"].toString());
                exdia = element["exdia"];
                controller.text = "";
                Navigator.of(context).pop();
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
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
        ),
      );
    }
    return mainResult;
  }

  late String searchText;
  late String meterText;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                "اضافه کردن لوله",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: kShadeDarkColor,
                  fontSize: 24,
                  fontFamily: "Vazir",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                    "برای انتخاب لوله مستطیل زیر را لمس کنید",
                                    style: TextStyle(
                                      color: kShadeDarkColor,
                                      fontSize: 14,
                                      fontFamily: "Vazir",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "باشد",
                                          style: TextStyle(
                                            color: kShadeDarkColor,
                                            fontSize: 12,
                                            fontFamily: "Vazir",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        icon: Icon(Icons.help_outline),
                        color: kShadeDarkColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            "اضافه کردن لوله",
                            style: TextStyle(
                              color: kShadeDarkColor,
                              fontSize: 14,
                              fontFamily: "Vazir",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.add_outlined,
                            color: kPrimaryColor,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    var data = await SqfL.open();
                    List<Map<String, dynamic>> allData = await data.rawQuery(
                        "SELECT DISTINCT PE,exdia,pressure FROM pe ORDER BY exdia,pressure,exdia");

                    await PipeModalBottomSheet(context, data, allData);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: kShadeDarkColor.withOpacity(0.4),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: PipeButtonContent(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: InputMeasure(
                hintText: "متراژ",
                icon: Icons.numbers_outlined,
                name: "متراژ لوله",
                customController: widget.meterControllerMain,
                onChange: () {
                  setState(() {});
                },
                numberOnly: true,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.addingFunction();
                  if (widget.meterControllerMain.value.text.isNotEmpty) {
                    const snackBar = SnackBar(
                      duration: Duration(milliseconds: 800),
                      content: Text(
                        'لوله اضافه شد',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Vazir",
                            fontSize: 16),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {}
                });
              },
              child: AddButton(controller: widget.meterControllerMain),
            ),
          ],
        ),
      ),
    );
  }

  PipeModalBottomSheet(BuildContext context, Database data,
      List<Map<String, dynamic>> allData) async {
    List<Map<String, dynamic>> searchData = [];
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Center(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Text(
                          "فهرست لوله های قابل سفارش در شرکت صنایع",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
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
                          textDirection: TextDirection.rtl,
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
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Vazir",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: const Text(
                                "PE",
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: kShadeDarkColor,
                                  fontFamily: "Vazir",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: const Center(
                                child: Text(
                                  "فشار نامی",
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    color: kShadeDarkColor,
                                    fontFamily: "Vazir",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: const Center(
                                child: Text(
                                  "قطر",
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    color: kShadeDarkColor,
                                    fontFamily: "Vazir",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 45,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: SearchBar(
                                onTapIcon: () async {
                                  //TODO: ASK FATHER : wont work on tap and on change!
                                  searchText = widget.sBarController.value.text
                                      .replaceAll(",", "");
                                  if (widget
                                      .sBarController.value.text.isNotEmpty) {
                                    searchData = await data.rawQuery(
                                        "SELECT DISTINCT exdia,pressure,PE FROM pe WHERE exdia like  '$searchText%' ORDER By exdia,pressure,PE");
                                    setState(() {});
                                  }
                                },
                                customController: widget.sBarController,
                                hintText: "قطر...",
                                onChangeCustom: () async {
                                  searchText = widget.sBarController.value.text
                                      .replaceAll(",", "");
                                  if (widget
                                      .sBarController.value.text.isNotEmpty) {
                                    searchData = await data.rawQuery(
                                        "SELECT DISTINCT exdia,pressure,PE FROM pe WHERE exdia like  '$searchText%' ORDER By exdia,pressure,PE");
                                  } else searchData=allData;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    if (widget.sBarController.value.text.isEmpty)
                      Expanded(
                        child: SingleChildScrollView(
                            child: Column(
                                children: widgetReturnerAllPipes(
                                    allData, widget.sBarController))),
                      )
                    else if (searchData.isEmpty)
                      Column(
                        children: const [
                          SizedBox(
                            height: 70,
                          ),
                          Text(
                            "برای این سایز لوله ای موجود نیست",
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: kShadeDarkColor,
                              fontFamily: "Vazir",
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    else
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                              children: widgetReturnerAllPipes(
                                  searchData, widget.sBarController)),
                        ),
                      )
                  ],
                ),
              ),
            );
          });
        });
  }
}

class PipeButtonContent extends StatelessWidget {
  const PipeButtonContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: kPrimaryColor.withOpacity(0.1)),
            child: Center(
              child: Text(
                peNumber.toString(),
                style: const TextStyle(
                  color: kShadeDarkColor,
                  fontFamily: "Vazir",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: kPrimaryColor.withOpacity(0.1)),
            child: Center(
              child: Text(
                pressure.toString(),
                style: const TextStyle(
                  color: kShadeDarkColor,
                  fontFamily: "Vazir",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: kPrimaryColor.withOpacity(0.1)),
            child: Center(
              child: Text(
                exdia.toString(),
                style: const TextStyle(
                  color: kShadeDarkColor,
                  fontFamily: "Vazir",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
