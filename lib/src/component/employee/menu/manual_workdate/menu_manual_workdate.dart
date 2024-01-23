// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee/menu/manual_workdate/create_manual_workdate.dart';
import 'package:hris_app_prototype/src/component/employee/menu/ot/menu_ot.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_address.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';

class ManualWorkdateMenu extends StatefulWidget {
  final EmployeeDatum employeeData;
  const ManualWorkdateMenu({
    Key? key,
    required this.employeeData,
  }) : super(key: key);

  @override
  State<ManualWorkdateMenu> createState() => _ManualWorkdateMenuState();
}

class _ManualWorkdateMenuState extends State<ManualWorkdateMenu> {
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  List<PayrollLot> lotList = [
    PayrollLot(
        lotId: "1",
        lotName: "01/2024",
        startDate: "2023-12-26",
        endDate: "2024-01-25"),
    PayrollLot(
        lotId: "2",
        lotName: "02/2024",
        startDate: "2024-01-26",
        endDate: "2024-02-25"),
    PayrollLot(
        lotId: "3",
        lotName: "03/2024",
        startDate: "2024-02-26",
        endDate: "2024-03-25"),
    PayrollLot(
        lotId: "4",
        lotName: "04/2024",
        startDate: "2024-03-26",
        endDate: "2024-04-25"),
  ];
  String lotId = "1";
  showDialogCreate() {
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
                      title: "บันทึกข้อมูลเวลาเข้า - ออกงาน",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    content: SizedBox(
                        width: 460, height: 300, child: CreateManualWorkdate()),
                  ));
        });
  }

  @override
  void initState() {
    Iterable<PayrollLot> result =
        lotList.where((element) => element.lotId == lotId);
    if (result.isNotEmpty) {
      setState(() {
        startDate.text = result.first.startDate.toString();
        endDate.text = result.first.endDate.toString();
      });
    }
    super.initState();
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
                showDialogCreate();
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
                          child: Text("Manual Work date",
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
                    DataColumn(label: Text("Date")),
                    DataColumn(label: Text("Type")),
                    DataColumn(label: Text("Time")),
                    DataColumn(label: Text("ModifiedBy")),
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
  List<WorkDataTime> leaveList = [
    WorkDataTime(
        workDate: "2023-12-26",
        type: "A01",
        time: "08:00:00",
        modifiedBy: "เวลากับรหัสพนักงาน"),
    WorkDataTime(
        workDate: "2023-12-27",
        type: "A02",
        time: "17:00:00",
        modifiedBy: "เวลากับรหัสพนักงาน"),
    WorkDataTime(
        workDate: "2023-12-28",
        type: "A01",
        time: "08:00:00",
        modifiedBy: "เวลากับรหัสพนักงาน"),
    WorkDataTime(
        workDate: "2024-01-02",
        type: "A02",
        time: "17:00:00",
        modifiedBy: "เวลากับรหัสพนักงาน"),
  ];

  @override
  DataRow? getRow(int index) {
    final data = leaveList[index];
    return DataRow(cells: [
      DataCell(Text(data.workDate)),
      DataCell(Text(data.type)),
      DataCell(Text(data.time)),
      DataCell(Text(data.modifiedBy)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => leaveList.length;

  @override
  int get selectedRowCount => 0;
}

class WorkDataTime {
  final String workDate;
  final String type;
  final String time;
  final String modifiedBy;
  WorkDataTime({
    required this.workDate,
    required this.type,
    required this.time,
    required this.modifiedBy,
  });
}
