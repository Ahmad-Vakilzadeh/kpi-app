import 'package:flutter/material.dart';
import 'package:kpi_app/Engine/measuring.dart';
import 'package:kpi_app/Screens/factorCreate/pdf_create.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../../constants.dart';

class CompleteFactorButton extends StatefulWidget {
  final List<Map<String, dynamic>> reciptListBottom;
  final TextEditingController lowDenseTextController;
  final TextEditingController excessTextController;
  final TextEditingController addressController;
  final String name;
  final double moneyCountOne;
  final double moneyCountTwo;

  const CompleteFactorButton({
    Key? key,
    required this.reciptListBottom,
    required this.name,
    required this.moneyCountOne,
    required this.moneyCountTwo,
    required this.excessTextController,
    required this.addressController,
    required this.lowDenseTextController,
  }) : super(key: key);

  @override
  State<CompleteFactorButton> createState() => _CompleteFactorButtonState();
}

class _CompleteFactorButtonState extends State<CompleteFactorButton> {
  sortingFunction(List<Map<String, dynamic>> list) {
    list.sort((a, b) {
      return b["exdia"].compareTo((a["exdia"]));
    });

    return list;
  }

  late List<Map<String, dynamic>> calculatedAnswer = [];
  late List<Map<String, dynamic>> sortedList = [];

  Future<void> loadingDataForList() async {
    var data = await SqfL.open();
    List<Map<String, dynamic>> forLoopList;
    for (var element in sortedList) {
      if (element["peNumber"] == "LD") {
        forLoopList = await data.rawQuery(
            "SELECT DISTINCT * FROM lowdens WHERE exdia= ${element["exdia"]} AND pressure = ${element["pressure"]}");
      } else {
        forLoopList = await data.rawQuery(
            "SELECT DISTINCT * FROM pe WHERE PE = ${element["peNumber"]} AND exdia= ${element["exdia"]} AND pressure = ${element["pressure"]}");
      }
      double weight = getField(forLoopList, "weight");
      double lenght =
          double.parse(element["meter"].toString().replaceAll(",", ""));
      double eachMeterPrice;
      double totalPrice;

      if (element["peNumber"] == 100 && widget.moneyCountTwo != 0) {
        eachMeterPrice = weight * widget.moneyCountTwo;
        totalPrice = weight * lenght * widget.moneyCountTwo;
      } else if (element["peNumber"] == "LD") {
        print(element);
        eachMeterPrice = weight *
            double.parse(
                widget.lowDenseTextController.value.text.replaceAll(",", ""));
        totalPrice = weight *
            lenght *
            double.parse(
                widget.lowDenseTextController.value.text.replaceAll(",", ""));
      } else {
        eachMeterPrice = weight * widget.moneyCountOne;
        totalPrice = weight * lenght * widget.moneyCountOne;
      }

      calculatedAnswer.add({
        "meter": element["meter"],
        "peNumber": element["peNumber"],
        "pressure": element["pressure"],
        "exdia": element["exdia"],
        "priceEachMeter": eachMeterPrice.toStringAsFixed(0),
        "totalPrice": totalPrice.toStringAsFixed(0),
      });
    }
  }

  double getField(List data, String fieldName) {
    if (data.isEmpty) return -1.0;
    return double.parse(data[0][fieldName].toString());
  }

  final PdfServices service = PdfServices();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.name != "" && widget.moneyCountOne.toString() != "0.0") {
          sortedList = sortingFunction(widget.reciptListBottom);
          DateTime dt = DateTime.now();
          Jalali j = dt.toJalali();
          await loadingDataForList();
          final data = await service.createInvoice(
            calculatedAnswer,
            "تاریخ: ${j.day} / ${j.month} / ${j.year}",
            widget.name,
            widget.excessTextController.value.text,
            widget.addressController.value.text,
          );

          service.savePdfFile(j.toString().replaceAll("Jalali", "KPI "), data);
          calculatedAnswer = [];
        } else {
          const snackBar = SnackBar(
            content: Text(
              'لطفا فرم هارا کامل کنید',
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Vazir",
                  fontSize: 16),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.name != "" &&
                  widget.moneyCountOne.toString() != "0.0" &&
                  widget.reciptListBottom.isNotEmpty
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
    );
  }
}
