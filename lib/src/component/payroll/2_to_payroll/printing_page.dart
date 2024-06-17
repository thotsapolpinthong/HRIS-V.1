import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:pdf/src/pdf/page_format.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PrintingPDF extends StatefulWidget {
  const PrintingPDF({super.key});

  @override
  State<PrintingPDF> createState() => _PrintingPDFState();
}

class _PrintingPDFState extends State<PrintingPDF> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Viewer"),
        centerTitle: true,
      ),
      body: PdfPreview(
          maxPageWidth: 550,
          canChangePageFormat: false,
          canDebug: false,
          // actions: [ElevatedButton(onPressed: () {}, child: Text("test"))],
          build: (format) => _generatePdf(format, ""),
          actionBarTheme: PdfActionBarTheme(
            backgroundColor: mythemecolor,
            actionSpacing: 40,
            height: 40,
          )),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final bool test = true;

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "Demo Printing",
                      style: pw.TextStyle(fontSize: 20),
                    ),
                    pw.Text(
                      "Day 29/9/66",
                      style: pw.TextStyle(fontSize: 20),
                    ),
                  ]),
              pw.SizedBox(height: 20),
              pw.FlutterLogo(),
              pw.SizedBox(height: 20),
              pw.Row(
                children: [
                  pw.Text(
                    "asdasdaslkdlasdsad",
                    style: pw.TextStyle(fontSize: 20),
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Row(children: [
                pw.Text(
                  "sadsadasd",
                  style: pw.TextStyle(fontSize: 20),
                ),
              ]),
              pw.SizedBox(height: 20),
              pw.Row(children: [
                pw.Text(
                  "dsgsdfsdf",
                  style: pw.TextStyle(fontSize: 20),
                ),
              ]),
              pw.SizedBox(height: 20),
              pw.Row(children: [
                pw.Text(
                  "sdgsdfsdfds",
                  style: pw.TextStyle(fontSize: 20),
                ),
              ]),
              pw.SizedBox(height: 20),
              pw.Row(children: [
                pw.Text(
                  "dsfdsfdsfdsfdsf",
                  style: pw.TextStyle(fontSize: 20),
                ),
              ]),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
