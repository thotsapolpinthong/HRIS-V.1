import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hris_app_prototype/src/services/api_payroll_service.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class TestPdf extends StatefulWidget {
  const TestPdf({super.key});

  @override
  State<TestPdf> createState() => _TestPdfState();
}

class _TestPdfState extends State<TestPdf> {
  String filePath = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Download PDF Example",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: filePath != ""
          ? PdfViewerPage(path: filePath)
          : Center(
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    filePath = await PdfDownloader.getWorkTimePdf(
                        "2024-04-26", "2024-05-25", "ITC000");
                    setState(() {});
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => PdfViewerPage(path: filePath)),
                    // );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Failed to download PDF: $e")),
                    );
                  }
                },
                child: Text("Download PDF"),
              ),
            ),
    );
  }
}

class PdfViewerPage extends StatelessWidget {
  final String path;

  PdfViewerPage({required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Viewer"),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () async {
              await Printing.layoutPdf(
                onLayout: (PdfPageFormat format) async {
                  final file = File(path);
                  return file.readAsBytes();
                },
              );
            },
          ),
        ],
      ),
      body: SfPdfViewer.file(File(path)),
    );
  }
}
