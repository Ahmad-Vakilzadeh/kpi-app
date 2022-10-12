import 'package:flutter/material.dart';

import 'package:intl/intl.dart' as intl;

import 'package:kpi_app/Screens/factorCreate/widgets/delete_button.dart';
import 'package:kpi_app/Screens/factorCreate/widgets/factor_card.dart';
import 'package:kpi_app/Screens/factorCreate/widgets/factor_create_button.dart';
import 'package:kpi_app/Screens/factorCreate/widgets/factor_create_card.dart';

import 'package:kpi_app/Widgets/input_measure.dart';
import '../../constants.dart';
import 'widgets/content_pipe_drop.dart';

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
                addingFunction: () {
                  if (reciptList.length < 7) {
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
    );
  }
}
