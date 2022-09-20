import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_document/open_document.dart';
import 'package:path_provider/path_provider.dart';
import "package:pdf/pdf.dart";
import 'package:pdf/widgets.dart' as pw;

class CustomRow {
  final String itemName;
  final String amount;
  final String price;
  final String pricePlus;
  final String priceTotal;

  CustomRow(
    this.itemName,
    this.amount,
    this.price,
    this.pricePlus,
    this.priceTotal,
  );
}

class PdfServices {
  Future<Uint8List> createHelworld() {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(child: pw.Text("hello"));
        },
      ),
    );
    return pdf.save();
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenDocument.openDocument(filePath: filePath);
  }

  Future<Uint8List> createInvoice(
      List<Map<String, dynamic>> soldProducts, String date) async {
    final pdf = pw.Document();
    final List<CustomRow> elements = [
      CustomRow("شرح کالا یا خدمت", "تعداد / مقدار", "مبلغ واحد", "ارزش افزوده",
          "مبلغ کل"),
      for (var prodcut in soldProducts)
        CustomRow(
          prodcut["peNumber"].toString(),
          prodcut["meter"].toString(),
          prodcut["priceEachMeter"].toString(),
          prodcut["priceEachMeter"].toString(),
          prodcut["priceToal"].toString(),
        ),
    ];

    var data = await rootBundle.load("assets/fonts/Vazir.ttf");
    pw.Font vazirFont = pw.Font.ttf(data);
    print(vazirFont);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Row(
                children: [
                  pw.Container(
                    margin: const pw.EdgeInsets.only(right: 100),
                    child: DateText(date, vazirFont),
                  ),
                  pw.Column(
                    children: [
                      pw.Text(
                        "پیشنهاد قیمت",
                        style: pw.TextStyle(font: vazirFont),
                        textDirection: pw.TextDirection.rtl,
                      ),
                      pw.SizedBox(height: 10),
                      pw.Container(
                        width: 100,
                        height: 2,
                        color: const PdfColor(0.1, 0.1, 0.1),
                      ),
                      pw.SizedBox(height: 30),
                    ],
                  ),
                ],
              ),
              pw.Container(
                decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                  width: 1,
                )),
                child: pw.Column(
                  children: [
                    pw.Text(
                      "مشخصات فروشنده",
                      style: pw.TextStyle(font: vazirFont),
                      textDirection: pw.TextDirection.rtl,
                    ),
                    pw.Container(
                      width: double.infinity,
                      height: 2,
                      color: const PdfColor(0.1, 0.1, 0.1),
                    ),
                    // SellersData(vazirFont),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
    return pdf.save();
  }

  pw.Text DateText(String date, pw.Font vazirFont) {
    String persianDate = date.replaceAll("0", "۰");
    persianDate = persianDate.replaceAll("1", "۱");
    persianDate = persianDate.replaceAll("2", "۲");
    persianDate = persianDate.replaceAll("3", "۳");
    persianDate = persianDate.replaceAll("4", "۴");
    persianDate = persianDate.replaceAll("5", "۵");
    persianDate = persianDate.replaceAll("6", "۶");
    persianDate = persianDate.replaceAll("7", "۷");
    persianDate = persianDate.replaceAll("8", "۸");
    persianDate = persianDate.replaceAll("9", "۹");

    return pw.Text(
      persianDate,
      style: pw.TextStyle(font: vazirFont),
      textDirection: pw.TextDirection.rtl,
    );
  }

  pw.Row SellersData(pw.Font font) => pw.Row(
        children: [
          pw.Column(
            children: [
              pw.Text(
                "نام شخص حقیقی / حقوقی: صنایع پلی اتیلن کرمان",
                style: pw.TextStyle(font: font),
                textDirection: pw.TextDirection.rtl,
              ),
              pw.Row(
                children: [
                  pw.Text("نشانی: کرمان - کیلومتر 5 جاده زرند"),
                  pw.Text("صندوق پستی : 613-76135"),
                ],
              ),
              pw.Text("  پستی محل صندوق 7613836178کد"),
            ],
          ),
        ],
      );
}
