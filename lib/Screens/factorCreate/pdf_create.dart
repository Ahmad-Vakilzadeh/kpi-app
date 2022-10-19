import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import "package:pdf/pdf.dart";
import 'package:pdf/widgets.dart' as pw;
import 'package:bidi/bidi.dart' as bidi;

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
    OpenFile.open(filePath);
  }

  Future<Uint8List> createInvoice(List<Map<String, dynamic>> soldProducts,
      String date, String buyername) async {
    final pdf = pw.Document();

    var data2 = await rootBundle.load("assets/fonts/Iran_sans.ttf");
    pw.Font iranSansFont = pw.Font.ttf(data2);

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
                    child: dateText(date, iranSansFont),
                  ),
                  pw.Column(
                    children: [
                      pw.Text(
                        "پیشنهاد قیمت",
                        style: pw.TextStyle(font: iranSansFont),
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
                      style: pw.TextStyle(font: iranSansFont),
                      textDirection: pw.TextDirection.rtl,
                    ),
                    pw.Container(
                      width: double.infinity,
                      height: 1,
                      color: const PdfColor(0.1, 0.1, 0.1),
                    ),
                    pw.Container(
                      margin: const pw.EdgeInsets.symmetric(horizontal: 5),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            children: [
                              pw.Text(
                                "شماره تلفن / نمابر: ۰۳۴۳۲۷۵۰۱۹۷",
                                style: pw.TextStyle(
                                  font: iranSansFont,
                                  fontSize: 8,
                                ),
                                textDirection: pw.TextDirection.rtl,
                              ),
                              pw.Text(
                                "کد پستی: ۷۶۱۴۹۱۴۸۸۸",
                                style: pw.TextStyle(
                                  font: iranSansFont,
                                  fontSize: 8,
                                ),
                                textDirection: pw.TextDirection.rtl,
                              ),
                            ],
                          ),
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            children: [
                              pw.Text(
                                "نام شخص حقیقی / حقوقی: صنایع پلی اتیلن کرمان",
                                style: pw.TextStyle(
                                  font: iranSansFont,
                                  fontSize: 8,
                                ),
                                textDirection: pw.TextDirection.rtl,
                              ),
                              pw.Row(
                                children: [
                                  // pw.Text(
                                  //   "صندوق پستی : ۷۶۱۳۵-۶۱۳",
                                  //   style: pw.TextStyle(
                                  //     font: iranSansFont,
                                  //     fontSize: 8,
                                  //   ),
                                  //   textDirection: pw.TextDirection.rtl,
                                  // ),
                                  pw.SizedBox(width: 10),
                                  pw.Text(
                                    "نشانی: کرمان - کیلومتر ۵ جاده زرند",
                                    style: pw.TextStyle(
                                      font: iranSansFont,
                                      fontSize: 8,
                                    ),
                                    textDirection: pw.TextDirection.rtl,
                                  ),
                                ],
                              ),
                              // pw.Text(
                              //   "کد پستی صندوق ۷۶۱۳۸۳۶۲۷۸",
                              //   style: pw.TextStyle(
                              //     font: iranSansFont,
                              //     fontSize: 8,
                              //   ),
                              //   textDirection: pw.TextDirection.rtl,
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    pw.Container(
                      width: double.infinity,
                      height: 1,
                      color: const PdfColor(0.1, 0.1, 0.1),
                    ),
                    pw.Text(
                      "مشخصات خریدار",
                      style: pw.TextStyle(font: iranSansFont),
                      textDirection: pw.TextDirection.rtl,
                    ),
                    pw.Container(
                      width: double.infinity,
                      height: 1,
                      color: const PdfColor(0.1, 0.1, 0.1),
                    ),
                    pw.Container(
                      margin: const pw.EdgeInsets.symmetric(horizontal: 5),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        children: [
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            children: [
                              pw.Text(
                                "نام شخص حقیقی / حقوقی: $buyername",
                                style: pw.TextStyle(
                                  font: iranSansFont,
                                  fontSize: 8,
                                ),
                                textDirection: pw.TextDirection.rtl,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    pw.Container(
                      width: double.infinity,
                      height: 1,
                      color: const PdfColor(0.1, 0.1, 0.1),
                    ),
                    pw.Text(
                      "مشخصات کالا یا خدمات مورد معامله",
                      style: pw.TextStyle(font: iranSansFont),
                      textDirection: pw.TextDirection.rtl,
                    ),
                    pw.Container(
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          width: 2,
                          color: const PdfColor(0.1, 0.1, 0.1),
                        ),
                      ),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        children: [
                          pw.Expanded(
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                  color: const PdfColor(0.1, 0.1, 0.1),
                                ),
                              ),
                              height: 30,
                              width: 20,
                              child: pw.Center(
                                child: pw.Text(
                                  "مبلغ کل",
                                  style: pw.TextStyle(
                                    font: iranSansFont,
                                    fontSize: 8,
                                  ),
                                  textDirection: pw.TextDirection.rtl,
                                ),
                              ),
                            ),
                          ),
                          pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                color: const PdfColor(0.1, 0.1, 0.1),
                              ),
                            ),
                            height: 30,
                            width: 70,
                            child: pw.Center(
                              child: pw.Text(
                                "ارزش افزوده",
                                style: pw.TextStyle(
                                  font: iranSansFont,
                                  fontSize: 8,
                                ),
                                textDirection: pw.TextDirection.rtl,
                              ),
                            ),
                          ),
                          pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                color: const PdfColor(0.1, 0.1, 0.1),
                              ),
                            ),
                            height: 30,
                            width: 70,
                            child: pw.Center(
                              child: pw.Text(
                                "مبلغ واحد",
                                style: pw.TextStyle(
                                  font: iranSansFont,
                                  fontSize: 8,
                                ),
                                textDirection: pw.TextDirection.rtl,
                              ),
                            ),
                          ),
                          pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                color: const PdfColor(0.1, 0.1, 0.1),
                              ),
                            ),
                            height: 30,
                            width: 40,
                            child: pw.Center(
                              child: pw.Text(
                                "تعداد \n متر",
                                style: pw.TextStyle(
                                  font: iranSansFont,
                                  fontSize: 8,
                                ),
                                textDirection: pw.TextDirection.rtl,
                              ),
                            ),
                          ),
                          pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                color: const PdfColor(0.1, 0.1, 0.1),
                              ),
                            ),
                            height: 30,
                            width: 130,
                            child: pw.Center(
                              child: pw.Text(
                                "شرح کالا یا خدمت",
                                style: pw.TextStyle(
                                  font: iranSansFont,
                                  fontSize: 8,
                                ),
                                textDirection: pw.TextDirection.rtl,
                              ),
                            ),
                          ),
                          pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                color: const PdfColor(0.1, 0.1, 0.1),
                              ),
                            ),
                            height: 30,
                            width: 25,
                            child: pw.Center(
                              child: pw.Text(
                                "ردیف",
                                style: pw.TextStyle(
                                  font: iranSansFont,
                                  fontSize: 8,
                                ),
                                textDirection: pw.TextDirection.rtl,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    listOfSoldItems(soldProducts, iranSansFont),
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.end,
                            children: [
                              pw.Text(
                                "شرایط تحویل: درب کارخانه",
                                style: pw.TextStyle(
                                  font: iranSansFont,
                                  fontSize: 8,
                                ),
                                textDirection: pw.TextDirection.rtl,
                              ),
                              pw.SizedBox(width: 100),
                              pw.Text(
                                "نحوه پرداخت: نقدي",
                                style: pw.TextStyle(
                                  font: iranSansFont,
                                  fontSize: 8,
                                ),
                                textDirection: pw.TextDirection.rtl,
                              ),
                            ],
                          ),
                          pw.Text(
                            "در صورت تایید، فاکتور طرح بنام بهره بردار صادر میگردد و قابل تغییر نمیباشد.",
                            style: pw.TextStyle(
                              font: iranSansFont,
                              fontSize: 8,
                            ),
                            textDirection: pw.TextDirection.rtl,
                          ),
                          pw.Text(
                            "زمان آماده شدن سفارش 10 روزه میباشد و چنانچه سریعتر تولید شود براي شما ارسال خواهد شد.",
                            style: pw.TextStyle(
                              font: iranSansFont,
                              fontSize: 8,
                            ),
                            textDirection: pw.TextDirection.rtl,
                          ),
                          pw.Text(
                            "در صورت عدم پاسخ گویی جهت ارسال پس از یک هفته سفارش شما لغو می شود.",
                            style: pw.TextStyle(
                              font: iranSansFont,
                              fontSize: 8,
                            ),
                            textDirection: pw.TextDirection.rtl,
                          ),
                          pw.SizedBox(height: 20),
                          pw.Text(
                            "تاریخ اعتبار پیش فاکتور1 روز می باشد.",
                            style: pw.TextStyle(
                              font: iranSansFont,
                              fontSize: 8,
                            ),
                            textDirection: pw.TextDirection.rtl,
                          ),
                          pw.Text(
                            "احتراما خواهشمند است پیش فاکتور فوق را تائید بفرمایید.",
                            style: pw.TextStyle(
                              font: iranSansFont,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 10,
                            ),
                            textDirection: pw.TextDirection.rtl,
                          ),
                        ],
                      ),
                    ),
                    pw.Row(
                      children: [
                        pw.Expanded(
                          child: pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                width: 2,
                                color: const PdfColor(0.1, 0.1, 0.1),
                              ),
                            ),
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              "امضاء فروشنده:",
                              style: pw.TextStyle(
                                font: iranSansFont,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 10,
                              ),
                              textDirection: pw.TextDirection.rtl,
                            ),
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                width: 2,
                                color: const PdfColor(0.1, 0.1, 0.1),
                              ),
                            ),
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(
                              "محل امضاء خریدار:",
                              style: pw.TextStyle(
                                font: iranSansFont,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 10,
                              ),
                              textDirection: pw.TextDirection.rtl,
                            ),
                          ),
                        ),
                      ],
                    )
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

  pw.Column listOfSoldItems(
      List<Map<String, dynamic>> soldItems, pw.Font iranSansFont) {
    int rowNumber = 0;
    NumberFormat formatNumTemplate = NumberFormat.decimalPattern('en_us');
    double totalPrice = 0;
    double totalTax = 0;

    List<pw.Widget> widgets = [];
    for (var element in soldItems) {
      rowNumber++;
      totalPrice = totalPrice + double.parse(element["totalPrice"]);
      totalTax = totalTax + (double.parse(element["totalPrice"]) / 100) * 9;

      widgets.add(
        pw.Row(
          children: [
            pw.Expanded(
              child: pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: const PdfColor(0.1, 0.1, 0.1),
                  ),
                ),
                height: 30,
                width: 20,
                child: pw.Center(
                  child: pw.Text(
                    formatNumTemplate
                        .format(
                            ((double.parse(element["totalPrice"]) / 100) * 9) +
                                double.parse(element["totalPrice"]))
                        .toString()
                        .replaceAll("1", "۱")
                        .replaceAll("2", "۲")
                        .replaceAll("3", "۳")
                        .replaceAll("4", "۴")
                        .replaceAll("5", "۵")
                        .replaceAll("6", "۶")
                        .replaceAll("7", "۷")
                        .replaceAll("8", "۸")
                        .replaceAll("9", "۹")
                        .replaceAll("0", "۰"),
                    style: pw.TextStyle(
                      font: iranSansFont,
                      fontSize: 8,
                    ),
                    textDirection: pw.TextDirection.ltr,
                  ),
                ),
              ),
            ),
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: const PdfColor(0.1, 0.1, 0.1),
                ),
              ),
              height: 30,
              width: 70,
              child: pw.Center(
                child: pw.Text(
                  formatNumTemplate
                      .format((double.parse(element['totalPrice']) / 100) * 9)
                      .toString()
                      .replaceAll("1", "۱")
                      .replaceAll("2", "۲")
                      .replaceAll("3", "۳")
                      .replaceAll("4", "۴")
                      .replaceAll("5", "۵")
                      .replaceAll("6", "۶")
                      .replaceAll("7", "۷")
                      .replaceAll("8", "۸")
                      .replaceAll("9", "۹")
                      .replaceAll("0", "۰"),
                  style: pw.TextStyle(
                    font: iranSansFont,
                    fontSize: 8,
                  ),
                  textDirection: pw.TextDirection.ltr,
                ),
              ),
            ),
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: const PdfColor(0.1, 0.1, 0.1),
                ),
              ),
              height: 30,
              width: 70,
              child: pw.Center(
                child: pw.Text(
                  formatNumTemplate
                      .format(double.parse(element["priceEachMeter"]))
                      .toString()
                      .replaceAll("1", "۱")
                      .replaceAll("2", "۲")
                      .replaceAll("3", "۳")
                      .replaceAll("4", "۴")
                      .replaceAll("5", "۵")
                      .replaceAll("6", "۶")
                      .replaceAll("7", "۷")
                      .replaceAll("8", "۸")
                      .replaceAll("9", "۹")
                      .replaceAll("0", "۰"),
                  style: pw.TextStyle(
                    font: iranSansFont,
                    fontSize: 8,
                  ),
                  textDirection: pw.TextDirection.ltr,
                ),
              ),
            ),
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: const PdfColor(0.1, 0.1, 0.1),
                ),
              ),
              height: 30,
              width: 40,
              child: pw.Center(
                child: pw.Text(
                  formatNumTemplate
                      .format(double.parse(element["meter"]))
                      .toString()
                      .replaceAll("1", "۱")
                      .replaceAll("2", "۲")
                      .replaceAll("3", "۳")
                      .replaceAll("4", "۴")
                      .replaceAll("5", "۵")
                      .replaceAll("6", "۶")
                      .replaceAll("7", "۷")
                      .replaceAll("8", "۸")
                      .replaceAll("9", "۹")
                      .replaceAll("0", "۰"),
                  style: pw.TextStyle(
                    font: iranSansFont,
                    fontSize: 8,
                  ),
                  textDirection: pw.TextDirection.ltr,
                ),
              ),
            ),
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: const PdfColor(0.1, 0.1, 0.1),
                ),
              ),
              height: 30,
              width: 130,
              child: pw.Center(
                child: pw.Text(
                  "PE: ${element["peNumber"]} سایز ${element["pressure"]}) ${element["exdia"]} بار(",
                  style: pw.TextStyle(
                    font: iranSansFont,
                    fontSize: 8,
                  ),
                  textDirection: pw.TextDirection.rtl,
                ),
              ),
            ),
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: const PdfColor(0.1, 0.1, 0.1),
                ),
              ),
              height: 30,
              width: 25,
              child: pw.Center(
                child: pw.Text(
                  rowNumber
                      .toString()
                      .replaceAll("1", "۱")
                      .replaceAll("2", "۲")
                      .replaceAll("3", "۳")
                      .replaceAll("4", "۴")
                      .replaceAll("5", "۵")
                      .replaceAll("6", "۶")
                      .replaceAll("7", "۷")
                      .replaceAll("8", "۸")
                      .replaceAll("9", "۹")
                      .replaceAll("0", "۰"),
                  style: pw.TextStyle(
                    font: iranSansFont,
                    fontSize: 8,
                  ),
                  textDirection: pw.TextDirection.ltr,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return pw.Column(
      children: [
        pw.Column(children: widgets),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Expanded(
              child: pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: const PdfColor(0.1, 0.1, 0.1),
                  ),
                ),
                height: 30,
                width: 20,
                child: pw.Center(
                  child: pw.Text(
                    formatNumTemplate
                        .format(totalPrice + totalTax)
                        .toString()
                        .replaceAll("1", "۱")
                        .replaceAll("2", "۲")
                        .replaceAll("3", "۳")
                        .replaceAll("4", "۴")
                        .replaceAll("5", "۵")
                        .replaceAll("6", "۶")
                        .replaceAll("7", "۷")
                        .replaceAll("8", "۸")
                        .replaceAll("9", "۹")
                        .replaceAll("0", "۰"),
                    style: pw.TextStyle(
                      font: iranSansFont,
                      fontSize: 8,
                    ),
                    textDirection: pw.TextDirection.ltr,
                  ),
                ),
              ),
            ),
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: const PdfColor(0.1, 0.1, 0.1),
                ),
              ),
              height: 30,
              width: 70,
              child: pw.Center(
                child: pw.Text(
                  formatNumTemplate
                      .format(totalTax)
                      .toString()
                      .replaceAll("1", "۱")
                      .replaceAll("2", "۲")
                      .replaceAll("3", "۳")
                      .replaceAll("4", "۴")
                      .replaceAll("5", "۵")
                      .replaceAll("6", "۶")
                      .replaceAll("7", "۷")
                      .replaceAll("8", "۸")
                      .replaceAll("9", "۹")
                      .replaceAll("0", "۰"),
                  style: pw.TextStyle(
                    font: iranSansFont,
                    fontSize: 8,
                  ),
                  textDirection: pw.TextDirection.ltr,
                ),
              ),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.only(left: 10),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: const PdfColor(0.1, 0.1, 0.1),
                ),
              ),
              width: 265,
              height: 30,
              child: pw.Row(
                children: [
                  pw.Text(
                    "جمع کل ریال: ",
                    style: pw.TextStyle(font: iranSansFont, fontSize: 10),
                    textDirection: pw.TextDirection.rtl,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  pw.Row sellersData(pw.Font font) => pw.Row(
        children: [
          pw.Column(
            children: [],
          ),
        ],
      );

  pw.Text dateText(String date, pw.Font font) {
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
      style: pw.TextStyle(font: font),
      textDirection: pw.TextDirection.rtl,
    );
  }
}
