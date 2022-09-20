import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kpi_app/Screens/MeasureScreen/measure_screen.dart';
import 'package:kpi_app/Screens/factorCreate/pdf_create.dart';
import 'package:intl/intl.dart' as intl;

import 'package:kpi_app/Widgets/input_measure.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../Engine/measuring.dart';
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

  listWidgetReturner(List<Map<String, dynamic>> reciptData) {
    List<Widget> output = [];

    for (var element in reciptData) {
      final index = reciptList.indexWhere((element1) => element1 == element);
      output.add(
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 2,
                        color: kShadeDarkColor.withOpacity(0.3),
                      )),
                  height: 40,
                  child: Center(
                    child: Text(
                      element["meter"].toString(),
                      style: TextStyle(
                        fontFamily: "Vazir_Regular_UI",
                        color: kShadeDarkColor.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 8,
                child: ContentPipeDropDownButton(
                  isActive: false,
                  iconExist: false,
                  exdiaText: element["exdia"].toString(),
                  peNumberText: element["peNumber"].toString(),
                  pressureText: element["pressure"].toString(),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    reciptList.removeAt(index);
                  });
                },
                child: const DeleteButton(),
              ),
            ],
          ),
        ),
      );
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kShadeDarkColor),
        backgroundColor: Colors.white,
        elevation: 5,
        centerTitle: true,
        title: const Text(
          "صدور پیش فاکتور",
          style: TextStyle(
            color: kShadeDarkColor,
            fontFamily: "Vazir_Regular_UI",
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                          fontFamily: "Vazir_Regular_UI",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: InputMeasure(
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
                        hintText: "قیمت هر کیلوگرم لوله",
                        icon: Icons.money_outlined,
                        name: "قیمت هر کیلوگرم لوله",
                        customController: moneyCount,
                        onChange: () {
                          setState(() {});
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: AddingRow(
                        meterControllerSecondMain: meterControllerMain,
                        sBarControler: searchBarController,
                        addingFunction: () {
                          setState(() {
                            if (meterControllerMain.value.text != "متراژ" &&
                                meterControllerMain.value.text != "") {
                              reciptList.add({
                                "meter": meterControllerMain.value.text,
                                "peNumber": peNumber,
                                "pressure": pressure,
                                "exdia": exdia,
                              });
                            }
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Column(
                        children: listWidgetReturner(reciptList),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {},
              child: _CompleteFactorButton(
                moneyCount: getNumberFromController(moneyCount),
                name: nameController.text,
                reciptListBottom: reciptList,
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.red,
      ),
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
}

class AddingRow extends StatefulWidget {
  const AddingRow({
    Key? key,
    required this.meterControllerSecondMain,
    required this.sBarControler,
    required this.addingFunction,
  }) : super(key: key);

  final TextEditingController sBarControler;
  final Function addingFunction;
  final TextEditingController meterControllerSecondMain;

  @override
  State<AddingRow> createState() => _AddingRowState();
}

class _AddingRowState extends State<AddingRow> {
  widgetReturnerAllPipes(List<Map<String, dynamic>> allData) {
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
                Navigator.of(context).pop();
              },
            );
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
                          fontFamily: "Vazir_Regular_UI",
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
                          fontFamily: "Vazir_Regular_UI",
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
                          fontFamily: "Vazir_Regular_UI",
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

  late String SearchText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 5,
          child: SizedBox(
            height: 40,
            child: PipeMeterField(
              meterController: widget.meterControllerSecondMain,
            ),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 8,
          child: GestureDetector(
            onTap: () async {
              var data = await SqfL.open();
              List<Map<String, dynamic>> allData = await data.rawQuery(
                  "SELECT DISTINCT PE,exdia,pressure FROM pe ORDER BY exdia,pressure,exdia");

              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return Center(
                      child: SingleChildScrollView(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          child: Column(
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
                                        color: kShadeDarkColor,
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
                                  fontFamily: "Vazir_Regular_UI",
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
                                  fontFamily: "Vazir_Regular_UI",
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
                                  fontFamily: "Vazir_Regular_UI",
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: const Text(
                                      "PE",
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        color: kShadeDarkColor,
                                        fontFamily: "Vazir_Regular_UI",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: const Center(
                                      child: Text(
                                        "فشار نامی",
                                        textAlign: TextAlign.center,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          color: kShadeDarkColor,
                                          fontFamily: "Vazir_Regular_UI",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: const Center(
                                      child: Text(
                                        "قطر",
                                        textAlign: TextAlign.center,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          color: kShadeDarkColor,
                                          fontFamily: "Vazir_Regular_UI",
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
                              SizedBox(
                                height: 45,
                                child: SearchBar(
                                  customController: widget.sBarControler,
                                  hintText: "جستجو...",
                                  onChangeCustom: () {
                                    SearchText =
                                        widget.sBarControler.value.text;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(children: widgetReturnerAllPipes(allData))
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
            child: ContentPipeDropDownButton(
              isActive: true,
              iconExist: true,
              peNumberText: peNumber.toString(),
              exdiaText: exdia.toString(),
              pressureText: pressure.toString(),
            ),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        GestureDetector(
          onTap: () {
            widget.addingFunction();
          },
          child: const AddButton(),
        ),
      ],
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kPrimaryColor,
      ),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar(
      {Key? key,
      required this.customController,
      required this.hintText,
      required this.onChangeCustom})
      : super(key: key);

  final TextEditingController customController;
  final String hintText;
  final Function onChangeCustom;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        onChanged: (value) {
          widget.onChangeCustom();
        },
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          LengthLimitingTextInputFormatter(12),
          ThousandsFormatter(),
        ],
        controller: widget.customController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                width: 1,
                color: kShadeDarkColor.withOpacity(0.5),
              )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
            ),
          ),
          icon: Icon(
            Icons.search,
            color: kShadeDarkColor.withOpacity(0.5),
          ),
          hintText: widget.hintText,
          hintTextDirection: TextDirection.rtl,
          hintStyle: TextStyle(
            color: kShadeDarkColor.withOpacity(0.5),
            fontFamily: "Vazir_Regular_UI",
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class ContentPipeDropDownButton extends StatelessWidget {
  const ContentPipeDropDownButton({
    Key? key,
    required this.peNumberText,
    required this.pressureText,
    required this.exdiaText,
    required this.iconExist,
    required this.isActive,
  }) : super(key: key);

  final String peNumberText;
  final String pressureText;
  final String exdiaText;
  final bool iconExist;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
            width: 2,
            color:
                isActive ? kShadeDarkColor : kShadeDarkColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          iconExist
              ? const Icon(
                  Icons.arrow_downward,
                  size: 18,
                  color: kShadeDarkColor,
                )
              : Container(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PipeDropDownText(
                  isActive: isActive,
                  pipeAtribute: peNumberText,
                ),
                PipeDropDownText(
                  pipeAtribute: pressureText,
                  isActive: isActive,
                ),
                PipeDropDownText(
                  pipeAtribute: exdiaText,
                  isActive: isActive,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PipeMeterField extends StatelessWidget {
  const PipeMeterField({
    Key? key,
    required this.meterController,
  }) : super(key: key);
  final TextEditingController meterController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        LengthLimitingTextInputFormatter(12),
        ThousandsFormatter(),
      ],
      controller: meterController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: kShadeDarkColor,
            width: 1,
          ),
        ),
        hintText: "متراژ",
        hintTextDirection: TextDirection.rtl,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontFamily: "Vazir_Regular_UI",
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class PipeDropDownText extends StatelessWidget {
  PipeDropDownText(
      {Key? key, required this.pipeAtribute, required this.isActive})
      : super(key: key);
  final bool isActive;
  final String pipeAtribute;

  @override
  Widget build(BuildContext context) {
    return Text(
      pipeAtribute,
      style: TextStyle(
        color: isActive ? kShadeDarkColor : kShadeDarkColor.withOpacity(0.8),
        fontWeight: FontWeight.bold,
        fontSize: 14,
        fontFamily: "Vazir_Regular_UI",
      ),
    );
  }
}

class _CompleteFactorButton extends StatefulWidget {
  final List<Map<String, dynamic>> reciptListBottom;
  final String name;
  final double moneyCount;

  const _CompleteFactorButton({
    Key? key,
    required this.reciptListBottom,
    required this.name,
    required this.moneyCount,
  }) : super(key: key);
  @override
  State<_CompleteFactorButton> createState() => _CompleteFactorButtonState();
}

class _CompleteFactorButtonState extends State<_CompleteFactorButton> {
  late int number = 0;

  late List<Map<String, dynamic>> calculatedAnswer = [];

  Future<void> loadingDataForList() async {
    late int index = 0;
    var data = await SqfL.open();
    List<Map<String, dynamic>> forLoopList;
    for (var element in widget.reciptListBottom) {
      forLoopList = await data.rawQuery(
          "SELECT DISTINCT * FROM pe WHERE PE = ${element["peNumber"]} AND exdia= ${element["exdia"]} AND pressure = ${element["pressure"]}");
      // calculatedAnswer.add(forLoopList[index]);
      double weight = getField(forLoopList, "weight");
      double lenght =
          double.parse(element["meter"].toString().replaceAll(",", ""));
      double eachMeterPrice = weight * widget.moneyCount;
      double totalPrice = weight * lenght * widget.moneyCount;

      calculatedAnswer.add({
        "meter": widget.reciptListBottom[index]["meter"],
        "peNumber": widget.reciptListBottom[index]["peNumber"],
        "pressure": widget.reciptListBottom[index]["pressure"],
        "exdia": widget.reciptListBottom[index]["exdia"],
        "priceEachMeter": eachMeterPrice.toStringAsFixed(0),
        "totalPrice": totalPrice.toStringAsFixed(0),
      });
      index++;
    }

    index = 0;
  }

  double getField(List data, String fieldName) {
    if (data.isEmpty) return -1.0;
    return double.parse(data[0][fieldName].toString());
  }

  @override
  final PdfServices service = PdfServices();

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        loadingDataForList();
        DateTime dt = DateTime.now();
        Jalali j = dt.toJalali();
        final data = await service.createInvoice(
            calculatedAnswer,
            "تاریخ: " +
                j.year.toString() +
                "/" +
                j.month.toString() +
                "/" +
                j.day.toString());
        service.savePdfFile("invoice_$number", data);
        number++;
      },
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor,
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
              fontFamily: "Vazir_Regular_UI",
            ),
          ),
        ),
      ),
    );
  }
}
