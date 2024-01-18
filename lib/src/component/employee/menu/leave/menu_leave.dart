import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee/menu/leave/create_leave.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_address.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';

class EmployeeLeaveMenu extends StatefulWidget {
  final EmployeeDatum employeeData;
  const EmployeeLeaveMenu({super.key, required this.employeeData});

  @override
  State<EmployeeLeaveMenu> createState() => _EmployeeLeaveMenuState();
}

class _EmployeeLeaveMenuState extends State<EmployeeLeaveMenu> {
  TextEditingController yearLeaved = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController toDate = TextEditingController();

  String selectYear = "1";
  List<DropdownYear> yearsList = [
    DropdownYear(yearsId: "1", yearsName: "2024"),
    DropdownYear(yearsId: "2", yearsName: "2023"),
    DropdownYear(yearsId: "3", yearsName: "2022"),
    DropdownYear(yearsId: "4", yearsName: "2021"),
  ];

  int annualLeave = 14;
  int personalLeave = 0;
  int sickLeave = 0;

  showDialogCreateLeave() {
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
                      title: "บันทึกข้อมูลวันลา",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    content: const SizedBox(
                        width: 460, height: 300, child: CreateLeave()),
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
                showDialogCreateLeave();
              },
              icon: const Icon(CupertinoIcons.plus),
            ).animate().shake(),
            backgroundColor: Colors.white,
            body: SizedBox(
              width: double.infinity, ///////////////
              child: PaginatedDataTable(
                  header: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Row(children: [
                      const Expanded(
                          child: Text("ตารางแสดงข้อมูลการลา",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800))),
                      // Expanded(
                      //     child: DropdownOrg(
                      //         labeltext: 'ประจำปี (ค.ศ.)',
                      //         value: selectYear,
                      //         items: yearsList.map((e) {
                      //           return DropdownMenuItem<String>(
                      //             value: e.yearsId.toString(),
                      //             child: Container(
                      //                 constraints:
                      //                     const BoxConstraints(maxWidth: 260),
                      //                 child: Text(e.yearsName)),
                      //           );
                      //         }).toList(),
                      //         onChanged: (newValue) {},
                      //         validator: null)),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text("Leave day quota : ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w800)),
                            Expanded(
                              child: DropdownOrg(
                                  labeltext: 'ประจำปี (ค.ศ.)',
                                  value: selectYear,
                                  items: yearsList.map((e) {
                                    return DropdownMenuItem<String>(
                                      value: e.yearsId.toString(),
                                      child: Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 260),
                                          child: Text(e.yearsName)),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {},
                                  validator: null),
                            ),
                            Card(
                              elevation: 3,
                              color: Colors.greenAccent,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "ลาพักร้อน",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text("คงเหลือ $annualLeave (ต่อปี)"),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation: 3,
                              color: Colors.amber,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "ลากิจ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text("คงเหลือ $personalLeave (ต่อปี)"),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation: 3,
                              color: Colors.greenAccent,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "ลาป่วย",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text("ใช้ไป $sickLeave "),
                                  ],
                                ),
                              ),
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
                    DataColumn(label: Text("Leave amout")),
                    DataColumn(label: Text("Noted")),
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
  List<LeaveData> leaveList = [
    LeaveData(
        date: "2024-01-15",
        type: "ลากิจ",
        leaveAmount: "1",
        noted: "testtesttesttest"),
    LeaveData(
        date: "2024-01-20",
        type: "ลากิจ",
        leaveAmount: "2",
        noted: "testtesttesttest"),
    LeaveData(
        date: "2024-02-05",
        type: "ลาป่วย",
        leaveAmount: "0.5",
        noted: "testtesttesttest")
  ];

  @override
  DataRow? getRow(int index) {
    final data = leaveList[index];
    return DataRow(cells: [
      DataCell(Text(data.date)),
      DataCell(Text(data.type)),
      DataCell(Text(data.leaveAmount)),
      DataCell(Text(data.noted)),
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

// Model

// Data
class LeaveData {
  final String date;
  final String type;
  final String leaveAmount;
  final String noted;

  LeaveData(
      {required this.date,
      required this.type,
      required this.leaveAmount,
      required this.noted});
}

//Dropdown year
class DropdownYear {
  String yearsId;
  String yearsName;
  DropdownYear({required this.yearsId, required this.yearsName});
}
