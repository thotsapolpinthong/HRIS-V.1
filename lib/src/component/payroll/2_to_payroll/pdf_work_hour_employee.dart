import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/organization/organization/dropdown/parent_org_dd_model.dart';
import 'package:hris_app_prototype/src/services/api_org_service.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'dart:convert';

class WorkHourPdfPage extends StatefulWidget {
  const WorkHourPdfPage({super.key});

  @override
  State<WorkHourPdfPage> createState() => _WorkHourPdfPageState();
}

class _WorkHourPdfPageState extends State<WorkHourPdfPage> {
  List<OrganizationDataam> orgList = [];
  String? orgCode;
  String pdfUrl = 'http://192.168.0.215/RPTHR014.pdf'; // URL ของไฟล์ PDF ของคุณ

  Future fetchData() async {
    orgList = await ApiOrgService.getParentOrgDropdown();
    setState(() {
      orgList;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> _printPdf() async {
    try {
      // ดาวน์โหลดไฟล์ PDF
      final response = await http.get(Uri.parse(pdfUrl));

      if (response.statusCode == 200) {
        // เข้าถึงข้อมูลไฟล์ PDF
        final pdfData = response.bodyBytes;

        // สั่งพิมพ์ไฟล์ PDF
        await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdfData,
        );
      } else {
        throw Exception('Failed to load PDF');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Viewer"),
        actions: [],
      ),
      floatingActionButton: SizedBox(
        width: 50,
        height: 50,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            onPressed: () {
              _printPdf();
            },
            child: Icon(Icons.print_rounded)),
      ),
      body: Column(
        children: [
          DropdownGlobal(
            labeltext: 'Department',
            value: orgCode,
            validator: null,
            items: orgList.map((e) {
              return DropdownMenuItem<String>(
                value: e.organizationCode.toString(),
                child: Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Text(
                        "${e.organizationCode.split('0')[0]} : ${e.organizationName}")),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                orgCode = newValue.toString();
              });
            },
          ),
          if (orgCode != null)
            Expanded(
              child: Card(
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child:
                      SfPdfViewer.network("http://192.168.0.215/RPTHR014.pdf"),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
