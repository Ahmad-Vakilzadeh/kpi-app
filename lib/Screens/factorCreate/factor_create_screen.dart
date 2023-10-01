import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:encrypt/encrypt.dart' as e;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart' as intl;
import 'package:flutter/services.dart';
import 'package:kpi_app/Screens/factorCreate/pdf_create.dart';
import 'package:kpi_app/Screens/factorCreate/widgets/add_button.dart';

import 'package:kpi_app/Screens/factorCreate/widgets/factor_card.dart';
import 'package:kpi_app/Screens/factorCreate/widgets/factor_create_button.dart';
import 'package:kpi_app/Screens/factorCreate/widgets/factor_create_card.dart';
import 'package:kpi_app/Screens/factorCreate/widgets/search_bar.dart';

import 'package:kpi_app/Widgets/input_measure.dart';
import 'package:kpi_app/main.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:sqflite/sqflite.dart';
import '../../Engine/measuring.dart';
import '../../constants.dart';

int peNumber = 100;
int exdia = 250;
int exdialoden = 20;
double? pressureloden = 4;
double? pressure = 4;
bool openPagecheck = false;
bool openPagecheckTwo = false;
var formatter = intl.NumberFormat('###,###,###');
@RoutePage()
class FactorCreate extends StatefulWidget {
   const FactorCreate({Key? key}) : super(key: key);


  @override
  State<FactorCreate> createState() => _FactorCreateState();
}

class _FactorCreateState extends State<FactorCreate>
    with TickerProviderStateMixin {
  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController moneyCount;
  late TextEditingController moneyCountSecond;
  late TextEditingController meterControllerMain;
  late TextEditingController lodenPriceController;
  late TextEditingController lodenMeterController;
  late TextEditingController excessTextInformation;

  late TextEditingController moneyCountDialog;
  late TextEditingController moneyCountSecondDialog;

  late List<Map<String, dynamic>> reciptList = [];
  late TextEditingController searchBarController;

  late AnimationController lowDensAnimation;
  late AnimationController excessTextAnimation;

  @override
  void initState() {
    super.initState();
    searchBarController = TextEditingController();
    meterControllerMain = TextEditingController();
    nameController = TextEditingController();
    excessTextInformation = TextEditingController();
    addressController = TextEditingController();
    lodenMeterController = TextEditingController();
    lodenPriceController = TextEditingController();
    moneyCount = TextEditingController();
    moneyCountSecond = TextEditingController();
    moneyCountDialog = TextEditingController();
    moneyCountSecondDialog = TextEditingController();
    lowDensAnimation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    excessTextAnimation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    if(isLink){_checkIfLink(UrlPath);}
  }



  _checkIfLink(String input) async{
    late double lodenMoneyCount = double.parse(
        lodenPriceController.value.text.replaceAll(",", ""));
    late double moneyCountSecondDialogTxt = double.parse(
        moneyCountSecondDialog.value.text.replaceAll(",", ""));
    late double moneyCountDialogTxt = double.parse(
        moneyCountDialog.value.text.replaceAll(",", ""));

    final String decryptedText = _decryptMessage(input);

    String check = "";
    List<String> result = decryptedText.split("\n");
    if (result[0].trim() == check) {
      // ignore: use_build_context_synchronously
      await showFileLoadDialog(context);
      await processCsv(result, moneyCountDialogTxt, lodenMoneyCount,
      moneyCountDialogTxt);
      moneyCountDialog.clear();
      lodenPriceController.clear();
      moneyCountSecondDialog.clear();
    } else {
      // ignore: use_build_context_synchronously
      showCustomerTextWarning(
          context, "مشکل متن", "متن لینک  اشتباه میباشد");
    }
  }


  double getNumberFromController(TextEditingController c) {
    if (c.text == "") {
      return 0;
    } else {
      return double.parse(c.text.replaceAll(",", ""));
    }
  }

  Future showCustomerTextWarning(
          BuildContext context, String text, String secondText) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text(
              text,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: kShadeDarkColor,
                fontSize: 20,
                fontFamily: "Vazir",
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              secondText,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: kShadeDarkColor,
                fontSize: 14,
                fontFamily: "Vazir",
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "باشد",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Vazir",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
      );

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
                  "لغو",
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

  Future<bool?> showFileLoadDialog(BuildContext context) async => showDialog(
      context: context,
      builder: (BuildContext conetxt) => Dialog(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InputMeasure(
                      peText: "PE80",
                      obligated: true,
                      numberOnly: true,
                      hintText: "قیمت هر کیلوگرم لوله",
                      icon: Icons.money_outlined,
                      name: "قیمت هر کیلوگرم لوله",
                      customController: moneyCountDialog,
                      onChange: () {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputMeasure(
                      peText: "PE100",
                      obligated: true,
                      numberOnly: true,
                      hintText: "قیمت هر کیلوگرم لوله",
                      icon: Icons.money_outlined,
                      name: "قیمت هر کیلوگرم لوله",
                      customController: moneyCountSecondDialog,
                      onChange: () {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputMeasure(
                        hintText: "قیمت لوله لودن",
                        icon: Icons.gas_meter_outlined,
                        name: "قیمت لوله لودن",
                        customController: lodenPriceController,
                        onChange: () {},
                        numberOnly: true,
                        obligated: true),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (moneyCountDialog.value.text.isEmpty ||
                            moneyCountSecondDialog.value.text.isEmpty ||
                            lodenPriceController.value.text.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    "لطفا فرم ها را پر کنید",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: kShadeDarkColor,
                                      fontSize: 20,
                                      fontFamily: "Vazir",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: const Text(
                                    "پر کردن فرم ها الزامی است",
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
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text(
                                        "باشد",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "Vazir",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              });
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: moneyCount.toString() != "0.0"
                              ? kPrimaryColor
                              : Colors.grey,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 25,
                              color: kPrimaryColor.withOpacity(0.2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 35),
                        height: 55,
                        child: const Center(
                          child: Text(
                            "صدور پیش فاکتور",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Vazir",
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));

  double getField(List data, String fieldName) {
    if (data.isEmpty) return -1.0;
    return double.parse(data[0][fieldName].toString());
  }

  processCsv(
      List<String> result, double nOne, double nTwoL, double nThree) async {
    late List<Map<String, dynamic>> loadingDataList = [];
    late List<Map<String, dynamic>> outputList = [];
    try {
      result.removeAt(0);
      String nameAndDateText = result[0];
      result.removeAt(0);
      String excessText = result[0];
      result.removeAt(0);

      List<String> nameAndData = nameAndDateText.split(",");
      var data = await SqfL.open();
      List<Map<String, dynamic>> forLoopList;
      for (var element in result) {
        List<String> listed = element.split(",");
        if (listed[2] == "LD") {
          forLoopList = await data.rawQuery(
              "SELECT DISTINCT * FROM lowdens WHERE exdia= ${listed[0]} AND pressure = ${listed[1]}");
        } else {
          forLoopList = await data.rawQuery(
              "SELECT DISTINCT * FROM pe WHERE PE = ${listed[2]} AND exdia= ${listed[0]} AND pressure = ${listed[1]}");
        }
        double weight = getField(forLoopList, "weight");

        double length = double.parse(listed[3].toString().replaceAll(",", ""));
        double eachMeterPrice;
        double totalPrice;
        double moneyCountDialogTxt = nOne;
        double moneyCountSecondDialogTxt = nThree;
        double lodenMoneyCount = nTwoL;

        if (element[2] == 100 && moneyCountSecondDialogTxt != 0) {
          eachMeterPrice = weight * moneyCountSecondDialogTxt;
          totalPrice = weight * length * moneyCountDialogTxt;
        } else if (element[2] == "LD") {
          totalPrice = weight * length * lodenMoneyCount;
          eachMeterPrice = weight * lodenMoneyCount;
        } else {
          totalPrice = weight * length * moneyCountDialogTxt;
          eachMeterPrice = weight * moneyCountDialogTxt;
        }

        loadingDataList.add({
          "meter": listed[3],
          "peNumber": listed[2],
          "pressure": listed[1],
          "exdia": listed[0],
          "priceEachMeter": eachMeterPrice.toStringAsFixed(0),
          "totalPrice": totalPrice.toStringAsFixed(0),
        });
      }
      await showPdfFromFile(
        loadingDataList,
        nameAndData[2],
        nameAndData[0],
        excessText,
        nameAndData[1],
      );
    } catch (e) {}
  }

  showPdfFromFile(List<Map<String, dynamic>> list, String date, String name,
      String excessText, String address) async {
    final PdfServices service = PdfServices();
    final data = await service.createInvoice(
      list,
      date,
      name,
      excessText,
      address,
    );
    DateTime dt = DateTime.now();
    Jalali j = dt.toJalali();
    service.savePdfFile(j.toString().replaceAll("Jalali", "KPI "), data);
  }

  String _decryptMessage(String encryptedMessage) {
    final key = e.Key.fromUtf8('1234574677475848283748374833373a');
    final iv = e.IV.fromLength(16);

    final encrypted = e.Encrypted.from64(encryptedMessage);

    final encrypter = e.Encrypter(e.AES(key));
    return encrypter.decrypt(encrypted, iv: iv);
  }

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
          actions: [
            IconButton(
              onPressed: () async {
                late double lodenMoneyCount = double.parse(
                    lodenPriceController.value.text.replaceAll(",", ""));
                late double moneyCountSecondDialogTxt = double.parse(
                    moneyCountSecondDialog.value.text.replaceAll(",", ""));
                late double moneyCountDialogTxt = double.parse(
                    moneyCountDialog.value.text.replaceAll(",", ""));
                ClipboardData? cdata =
                    await Clipboard.getData(Clipboard.kTextPlain);
                final String encryptedMessage = cdata!.text as String;

                final String usingString = _decryptMessage(encryptedMessage);

                String check = "";
                List<String> result = usingString.split("\n");
                if (result[0].trim() == check) {
                  // ignore: use_build_context_synchronously
                  await showFileLoadDialog(context);
                  await processCsv(result, moneyCountDialogTxt, lodenMoneyCount,
                      moneyCountDialogTxt);
                  moneyCountDialog.clear();
                  lodenPriceController.clear();
                  moneyCountSecondDialog.clear();
                } else {
                  // ignore: use_build_context_synchronously
                  showCustomerTextWarning(
                      context, "مشکل متن", "متن لینک  اشتباه میباشد");
                }
              },
              icon: const Icon(
                Icons.file_download_outlined,
                color: kShadeDarkColor,
              ),
            ),
          ],
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
                            "مشخصات مشتری",
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
                              obligated: true,
                              numberOnly: false,
                              hintText: "اسم کامل مشتری",
                              icon: Icons.account_circle_outlined,
                              name: "اسم مشتری",
                              customController: nameController,
                              onChange: () {
                                setState(() {});
                              }),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: InputMeasure(
                              obligated: false,
                              numberOnly: false,
                              hintText: "ادرس مشتری",
                              icon: Icons.home_outlined,
                              name: "ادرس",
                              customController: addressController,
                              onChange: () {
                                setState(() {});
                              }),
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
                  excessTextCard: () {
                    excessTextAnimation.forward();
                    if (excessTextAnimation.isCompleted) {
                      excessTextAnimation.reverse();
                    }
                  },
                  moneyCountSecond: moneyCountSecond,
                  lowDensFunction: () {
                    lowDensAnimation.forward();
                    if (lowDensAnimation.isCompleted) {
                      lowDensAnimation.reverse();
                    }
                  },
                  moneyCountPass: moneyCount,
                  exdiaTextOne: exdia.toString(),
                  peNumberTextOne: peNumber.toString(),
                  pressureTextOne: pressure.toString(),
                  meterControllerMain: meterControllerMain,
                  addingFunction: () async {
                    setState(() {
                      openPagecheck = true;
                    });
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
                                  ),
                                ),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "لغو",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: kShadeDarkColor,
                                          fontSize: 16,
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
                SizeTransition(
                  sizeFactor: lowDensAnimation,
                  child: Container(
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
                              "لوله لودن",
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
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                MixedInput(
                                  name: "مشخصات لوله لودن",
                                  icon: Icons.gas_meter_outlined,
                                  hintTextOne: "متراژ",
                                  hintTextTwo: "قیمت هر متر",
                                  controllerOne: lodenMeterController,
                                  controllerTwo: lodenPriceController,
                                  onChange: () {},
                                  obligated: true,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    var data = await SqfL.open();
                                    List<Map<String, dynamic>> allData =
                                        await data.rawQuery(
                                            "SELECT DISTINCT exdia,pressure FROM lowdens ORDER BY exdia,pressure");

                                    // ignore: use_build_context_synchronously
                                    await PipeModalBottomSheet(
                                        context, data, allData);
                                    if (openPagecheckTwo == false) {
                                      setState(() {
                                        openPagecheckTwo = true;
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 55,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: kShadeDarkColor.withOpacity(0.4),
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: PipeButtonContentLowDense(
                                        openPageChecker: openPagecheckTwo),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              lowDensAnimation.reverse();
                              setState(() {
                                if (lodenMeterController
                                        .value.text.isNotEmpty &&
                                    openPagecheckTwo) {
                                  addingFunction() async {
                                    openPagecheckTwo = true;
                                    bool checker = true;
                                    for (var element in reciptList) {
                                      if (element["pressure"] ==
                                              pressureloden &&
                                          element["exdia"] == exdialoden) {
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
                                                  ),
                                                ),
                                                content: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        "لغو",
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                          color:
                                                              kShadeDarkColor,
                                                          fontSize: 16,
                                                          fontFamily: "Vazir",
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                        if (lodenMeterController.value.text !=
                                                "متراژ" &&
                                            lodenMeterController.value.text !=
                                                "") {
                                          reciptList.add({
                                            "meter": lodenMeterController
                                                .value.text
                                                .replaceAll(",", "")
                                                .toString(),
                                            "peNumber": "LD",
                                            "pressure": pressureloden,
                                            "exdia": exdialoden,
                                          });
                                        }
                                      });
                                    }
                                  }

                                  setState(() {
                                    addingFunction();
                                  });

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
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  setState(() {
                                    openPagecheckTwo = true;
                                  });
                                } else {}
                              });
                            },
                            child: AddButtonLowDense(
                              active: openPagecheckTwo,
                              controllerMeter: lodenMeterController,
                              controllerMoney: lodenPriceController,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FactorCard(reciptList: reciptList),
                const SizedBox(
                  height: 15,
                ),
                SizeTransition(
                  sizeFactor: excessTextAnimation,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
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
                                "توضیحات اضافه",
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
                              child: InputMeasure(
                                customController: excessTextInformation,
                                icon: Icons.text_fields_outlined,
                                hintText: "توضیحات اختیاری",
                                name: "توضیحات اختیاری",
                                numberOnly: false,
                                obligated: false,
                                onChange: () {},
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CompleteFactorButton(
                  addressController: addressController,
                  excessTextController: excessTextInformation,
                  moneyCountOne: getNumberFromController(moneyCount),
                  moneyCountTwo: moneyCountSecond.value.text.isNotEmpty
                      ? getNumberFromController(moneyCountSecond)
                      : 0,
                  name: nameController.value.text,
                  reciptListBottom: reciptList,
                  lowDenseTextController: lodenMeterController,
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

  widgetReturnerAllPipes(
      List<Map<String, dynamic>> allData, TextEditingController controller) {
    List<Widget> mainResult = [];
    for (var element in allData) {
      mainResult.add(
        GestureDetector(
          onTap: () {
            setState(
              () {
                pressureloden = double.tryParse(element["pressure"].toString());
                exdialoden = element["exdia"];
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
                    child: const Center(
                      child: Text(
                        "لودن",
                        style: TextStyle(
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
                              child: SearchBarCustom(
                                onTapIcon: () async {
                                  searchText = searchBarController.value.text
                                      .replaceAll(",", "");
                                  if (searchBarController
                                      .value.text.isNotEmpty) {
                                    searchData = await data.rawQuery(
                                        "SELECT DISTINCT exdia,pressure FROM lowdens WHERE exdia like  '$searchText%' ORDER By exdia,pressure");
                                    setState(() {});
                                  }
                                },
                                customController: searchBarController,
                                hintText: "قطر...",
                                onChangeCustom: () async {
                                  searchText = searchBarController.value.text
                                      .replaceAll(",", "");
                                  if (searchBarController
                                      .value.text.isNotEmpty) {
                                    searchData = await data.rawQuery(
                                        "SELECT DISTINCT exdia,pressure FROM lowdens WHERE exdia like  '$searchText%' ORDER By exdia,pressure");
                                  } else
                                    searchData = allData;
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
                    if (searchBarController.value.text.isEmpty)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: widgetReturnerAllPipes(
                              allData,
                              searchBarController,
                            ),
                          ),
                        ),
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
                                  searchData, searchBarController)),
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
