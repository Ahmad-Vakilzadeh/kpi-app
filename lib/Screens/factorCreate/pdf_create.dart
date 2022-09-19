import 'dart:io';
import 'dart:typed_data';

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
          prodcut["peNumber"],
          prodcut["meter"],
          prodcut["priceEachMeter"],
          prodcut["priceEachMeter"],
          prodcut["priceToal"],
        ),
    ];
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    children: [
                      pw.Text("Customar name"),
                      pw.Text("Customar name"),
                      pw.Text("Customar name"),
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.Text("Customar name"),
                      pw.Text("Customar name"),
                      pw.Text("Customar name"),
                    ],
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
    return pdf.save();
  }
}
