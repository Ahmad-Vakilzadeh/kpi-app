import 'package:flutter/material.dart';
import 'package:kpi_app/Engine/measuring.dart';
import 'package:kpi_app/Screens/factorCreate/pdf_create.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../../constants.dart';

class CompleteFactorButton extends StatefulWidget {
  final List<Map<String, dynamic>> reciptListBottom;
  final String name;
  final double moneyCount;

  const CompleteFactorButton({
    Key? key,
    required this.reciptListBottom,
    required this.name,
    required this.moneyCount,
  }) : super(key: key);
  @override
  State<CompleteFactorButton> createState() => _CompleteFactorButtonState();
}

class _CompleteFactorButtonState extends State<CompleteFactorButton> {
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

  final PdfServices service = PdfServices();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.name != "" && widget.moneyCount.toString() != "0.0") {
          DateTime dt = DateTime.now();
          Jalali j = dt.toJalali();
          await loadingDataForList();
          final data = await service.createInvoice(
            calculatedAnswer,
            "تاریخ: ${j.year}/${j.month}/${j.day}",
            widget.name,
          );

          service.savePdfFile(j.toString().replaceAll("Jalali", "KPI "), data);
          number++;
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
                  widget.moneyCount.toString() != "0.0" &&
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
