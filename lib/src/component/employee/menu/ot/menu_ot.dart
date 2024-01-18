// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee/menu/ot/create_ot.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_address.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';

class EmployeeOtMenu extends StatefulWidget {
  final EmployeeDatum employeeData;
  const EmployeeOtMenu({
    Key? key,
    required this.employeeData,
  }) : super(key: key);

  @override
  State<EmployeeOtMenu> createState() => _EmployeeOtMenuState();
}

class _EmployeeOtMenuState extends State<EmployeeOtMenu> {
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  List<PayrollLot> lotList = [
    PayrollLot(
        lotId: "1",
        lotName: "01/2024",
        startDate: "2023/12/26",
        endDate: "2024/01/25"),
    PayrollLot(
        lotId: "2",
        lotName: "02/2024",
        startDate: "2024/01/26",
        endDate: "2024/02/25"),
    PayrollLot(
        lotId: "3",
        lotName: "03/2024",
        startDate: "2024/02/26",
        endDate: "2024/03/25"),
    PayrollLot(
        lotId: "4",
        lotName: "04/2024",
        startDate: "2024/03/26",
        endDate: "2024/04/25"),
  ];
  String lotId = "1";

  @override
  void initState() {
    Iterable<PayrollLot> result =
        lotList.where((element) => element.lotId == lotId);
    if (result.isNotEmpty) {
      setState(() {
        startDate.text = result.first.startDate.toString();
        endDate.text = result.first.endDate.toString();
      });

      super.initState();
    }
  }

  showDialogCreateOt() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                    backgroundColor: mygreycolors,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: TitleDialog(
                      title: "บันทึกข้อมูลการทำงานล่วงเวลา",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    content:
                        SizedBox(width: 460, height: 400, child: CreateOt()),
                  ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            floatingActionButton: MyFloatingButton(
              onPressed: () {
                showDialogCreateOt();
              },
              icon: const Icon(CupertinoIcons.plus),
            ).animate().shake(),
            backgroundColor: Colors.white,
            body: SizedBox(
              width: double.infinity, ///////////////
              child: PaginatedDataTable(
                  columnSpacing: 10,
                  header: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Row(children: [
                      const Expanded(
                          child: Text("ตารางแสดงข้อมูลการทำงานล่วงเวลา",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800))),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 122,
                                child: DropdownOrg(
                                    labeltext: 'Lot Number',
                                    value: lotId,
                                    items: lotList.map((e) {
                                      return DropdownMenuItem<String>(
                                        value: e.lotId.toString(),
                                        child: Container(
                                            width: 58,
                                            constraints: const BoxConstraints(
                                                maxWidth: 100, minWidth: 70),
                                            child: Text(e.lotName)),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      lotId = newValue.toString();
                                      Iterable<PayrollLot> result =
                                          lotList.where((element) =>
                                              element.lotId == newValue);
                                      if (result.isNotEmpty) {
                                        startDate.text =
                                            result.first.startDate.toString();
                                        endDate.text =
                                            result.first.endDate.toString();
                                      }
                                    },
                                    validator: null),
                              ),
                            ),
                            Expanded(
                              child: TextFormFieldGlobal(
                                  controller: startDate,
                                  labelText: "วันที่เริ่มต้น",
                                  hintText: '',
                                  enabled: false,
                                  validatorless: null),
                            ),
                            Expanded(
                              child: TextFormFieldGlobal(
                                  controller: endDate,
                                  labelText: "วันที่สิ้นสุด",
                                  hintText: '',
                                  enabled: false,
                                  validatorless: null),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),

                  //  columnSpacing: 30,
                  columns: const [
                    DataColumn(label: Text("OT Date")),
                    DataColumn(label: Text("OT-normal (hr.)")),
                    DataColumn(label: Text("Holiday (hr.)")),
                    DataColumn(label: Text("OT-Holiday (hr.)")),
                    DataColumn(label: Text("OT-แบบเหมา (hr.)")),
                    DataColumn(label: Text("Payroll Lot")),
                    DataColumn(label: Text("Request Type")),
                    DataColumn(label: Text("Remark")),
                    DataColumn(label: Text("Delete")),
                  ],
                  source: DataTableRowSource()),
            ),
          ),
        ),
      ),
    );
  }
}

class DataTableRowSource extends DataTableSource {
  DataTableRowSource();
  List<OtDataTime> leaveList = [
    OtDataTime(
        otDate: "2024/01/01",
        otNormal: 3.00,
        holiday: 0,
        otHoliday: 0,
        otCharter: 0,
        payrollLot: "01/2024",
        requestType: "OT-หลังเลิกงาน",
        remark: "Create by HRM"),
    OtDataTime(
        otDate: "2024/01/02",
        otNormal: 4.00,
        holiday: 0,
        otHoliday: 0,
        otCharter: 0,
        payrollLot: "01/2024",
        requestType: "OT-หลังเลิกงาน",
        remark: "Create by HRM"),
    OtDataTime(
        otDate: "2024/01/03",
        otNormal: 3.00,
        holiday: 0,
        otHoliday: 0,
        otCharter: 0,
        payrollLot: "01/2024",
        requestType: "OT-หลังเลิกงาน",
        remark: "Create by HRM"),
    OtDataTime(
        otDate: "2024/01/04",
        otNormal: 2.50,
        holiday: 0,
        otHoliday: 0,
        otCharter: 0,
        payrollLot: "01/2024",
        requestType: "OT-หลังเลิกงาน",
        remark: "Create by HRM"),
  ];

  @override
  DataRow? getRow(int index) {
    final data = leaveList[index];
    return DataRow(cells: [
      DataCell(Text(data.otDate)),
      DataCell(Text(data.otNormal.toString())),
      DataCell(Text(data.holiday.toString())),
      DataCell(Text(data.otHoliday.toString())),
      DataCell(Text(data.otCharter.toString())),
      DataCell(Text(data.payrollLot)),
      DataCell(Text(data.requestType)),
      DataCell(Text(data.remark)),
      DataCell(RowDeleteBox(onPressed: () {})),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => leaveList.length;

  @override
  int get selectedRowCount => 0;
}

class OtDataTime {
  final String otDate;
  final double otNormal;
  final double holiday;
  final double otHoliday;
  final double otCharter;
  final String payrollLot;
  final String requestType;
  final String remark;
  OtDataTime({
    required this.otDate,
    required this.otNormal,
    required this.holiday,
    required this.otHoliday,
    required this.otCharter,
    required this.payrollLot,
    required this.requestType,
    required this.remark,
  });
}

class PayrollLot {
  final String lotId;
  final String lotName;
  final String startDate;
  final String endDate;
  PayrollLot({
    required this.lotId,
    required this.lotName,
    required this.startDate,
    required this.endDate,
  });
}
