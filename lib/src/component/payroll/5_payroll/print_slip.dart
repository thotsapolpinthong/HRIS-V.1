import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/services/api_payroll_service.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PrintSlipPayroll extends StatefulWidget {
  const PrintSlipPayroll({super.key});

  @override
  State<PrintSlipPayroll> createState() => _PrintSlipPayrollState();
}

class _PrintSlipPayrollState extends State<PrintSlipPayroll> {
  String filePath = "";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    try {
      filePath = await PdfDownloader.getWorkTimePdf(
          "2024-04-26", "2024-05-25", "ITC000");
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to download PDF: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Document",
            style: TextStyle(fontSize: 20),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: filePath == ""
            ? null
            : ButtonTableMenu(
                width: 100,
                height: 32,
                text: "พิมพ์สลิป",
                iconColor: mythemecolor,
                isUploaded: true,
                onPressed: () async {
                  await Printing.layoutPdf(
                    onLayout: (PdfPageFormat format) async {
                      final file = File(filePath);
                      return file.readAsBytes();
                    },
                  );
                },
                child: const Icon(Icons.print_rounded)),
        body:
            filePath != "" ? SfPdfViewer.file(File(filePath)) : myLoadingScreen
        // Center(
        //     child: ElevatedButton(
        //       onPressed: () async {
        //         try {
        //           filePath = await PdfDownloader.getWorkTimePdf(
        //               "2024-04-26", "2024-05-25", "ITC000");
        //           setState(() {});
        //         } catch (e) {
        //           ScaffoldMessenger.of(context).showSnackBar(
        //             SnackBar(content: Text("Failed to download PDF: $e")),
        //           );
        //         }
        //       },
        //       child: Text("Download PDF"),
        //     ),
        //   ),
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
