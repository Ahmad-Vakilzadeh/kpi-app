import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kpi_app/Screens/factorCreate/widgets/delete_button.dart';
import 'package:kpi_app/constants.dart';

class FactorCard extends StatefulWidget {
  FactorCard({Key? key, required this.reciptList}) : super(key: key);
  late List<Map<String, dynamic>> reciptList = [];

  @override
  State<FactorCard> createState() => _FactorCardState();
}

class _FactorCardState extends State<FactorCard> {
  listWidgetReturner(List<Map<String, dynamic>> reciptData) {
    NumberFormat formatNumTemplate = NumberFormat.decimalPattern('en_us');

    List<Widget> output = [];
    for (var index = 0; index < reciptData.length; index++) {
      final element = reciptData[index];
      int indexString = index + 1;
      output.add(
        Container(
          height: 40,
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.reciptList.removeAt(index);
                      });
                    },
                    child: const DeleteButton(),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            formatNumTemplate
                                .format(double.parse(element["meter"]))
                                .toString(),
                            style: TextStyle(
                              fontFamily: "Vazir",
                              fontSize: 16,
                              color: kShadeDarkColor.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            ":متراژ",
                            style: TextStyle(
                              fontFamily: "Vazir",
                              fontSize: 16,
                              color: kShadeDarkColor.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "${element["exdia"]}/${element["peNumber"]}/${element["pressure"]}",
                            style: TextStyle(
                              fontFamily: "Vazir",
                              fontSize: 16,
                              color: kShadeDarkColor.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            ":لوله",
                            style: TextStyle(
                              fontFamily: "Vazir",
                              fontSize: 16,
                              color: kShadeDarkColor.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${indexString++}".toString(),
                        style: TextStyle(
                            fontFamily: "Vazir",
                            fontSize: 16,
                            color: kShadeDarkColor.withOpacity(0.8),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 25,
            color: Color(0x200D6472),
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  bottom: 25, top: 25, right: 20, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "لیست پیش فاکتور",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: kShadeDarkColor,
                      fontSize: 24,
                      fontFamily: "Vazir",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Column(
                    children: listWidgetReturner(widget.reciptList),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
