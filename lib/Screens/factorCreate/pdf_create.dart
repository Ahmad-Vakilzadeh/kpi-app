import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
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
      List<Map<String, dynamic>> soldProducts) async {
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
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Column(
                    children: [
                      pw.Text(
                        "پیشنهاد قیمت",
                      ),
                      pw.SizedBox(height: 10),
                      pw.Container(
                        width: 100,
                        height: 3,
                        color: PdfColor(0.1, 0.1, 0.1),
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
                    pw.Text("مشخصات فروشنده"),
                    pw.Container(width: double.infinity, height: 2),
                    SellersData()
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

  pw.Row SellersData() => pw.Row(
        children: [
          pw.Column(
            children: [
              pw.Text(
                "نام شخص حقیقی / حقوقی: صنایع پلی اتیلن کرمان",
                style: pw.TextStyle(
                  fontFallback: [],
                ),
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
