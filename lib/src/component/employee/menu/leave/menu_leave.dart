// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/employee_bloc/employee_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee/menu/leave/create_leave.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model/leave_amount_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model/leave_approve_and_reject_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model/leave_data_employee_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model/leave_quota_employee_model.dart';
import 'package:hris_app_prototype/src/services/api_employee_self_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeLeaveMenu extends StatefulWidget {
  final EmployeeDatum employeeData;
  const EmployeeLeaveMenu({super.key, required this.employeeData});

  @override
  State<EmployeeLeaveMenu> createState() => _EmployeeLeaveMenuState();
}

class _EmployeeLeaveMenuState extends State<EmployeeLeaveMenu> {
  TextEditingController yearLeaved = TextEditingController();
  TextEditingController toDate = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();

  LeaveRequestByEmployeeModel? leaveDataEmployee;
  LeaveRequestAmountModel? leaveAmount;
  LeaveQuotaByEmployeeModel? quotaData;
  String selectYear = "1";
  double vacationLeave = 0;
  double bussinessLeave = 0;
  double sickLeave = 0;

  double vacationLeaveRequest = 0;
  double bussinessLeaveRequest = 0;
  double sickLeaveRequest = 0;

  // List<PayrollLot> lotList = [
  //   PayrollLot(
  //       lotId: "1",
  //       lotName: "01/2024",
  //       startDate: "2023-12-26",
  //       endDate: "2024-01-25"),
  //   PayrollLot(
  //       lotId: "2",
  //       lotName: "02/2024",
  //       startDate: "2024-01-26",
  //       endDate: "2024-02-25"),
  //   PayrollLot(
  //       lotId: "3",
  //       lotName: "03/2024",
  //       startDate: "2024-02-26",
  //       endDate: "2024-03-25"),
  //   PayrollLot(
  //       lotId: "4",
  //       lotName: "04/2024",
  //       startDate: "2024-03-26",
  //       endDate: "2024-04-25"),
  // ];
  // String lotId = "1";

  showDialogCreateLeave() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, setState) => Stack(
                    children: [
                      AlertDialog(
                        backgroundColor: mygreycolors,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        title: TitleDialog(
                          title: "บันทึกข้อมูลวันลา",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        content: SizedBox(
                            width: 460,
                            height: 360,
                            child: CreateLeave(
                              employeeData: widget.employeeData,
                              vacationLeave: vacationLeave,
                              bussinessLeave: bussinessLeave,
                              sickLeave: sickLeave,
                            )),
                      ),
                      Positioned(
                        top: 200,
                        right: 150,
                        child: AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          content: const SizedBox(
                            width: 260,
                            height: 300,
                            child: Text(
                              "หมายเหตุ*\n- โปรดกรอกข้อมูลให้ครบถ้วน\n- หากต้องการลาหลายวันควรเป็นวันที่ติดกัน(ระยะเวลาการลา จะคิดเป็นเต็มวัน)\n- หากต้องการลาไม่เกินหนึ่งวันหรือลาหนึ่งวัน ต้องระบุระยะเวลาการลา\n- หากลา 1 วัน ให้ใส่ระยะเวลาเป็นจำนวน 9 ชั่วโมง ตัวอย่างเช่น '8:00-17:00'\n- หากโปรแกรมมีการเตือนว่าใช้สิทธิลาเกิน แล้วยังทำรายการต่อ จะถือว่าเป็นการยินยอมให้หักเงิน",
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
        });
  }

  fetchData() {
    // leaveDataEmployee =
    //     await ApiEmployeeSelfService.getLeaveRequestByEmployeeId(
    //         widget.employeeData.employeeId);
    // setState(() {
    //   leaveDataEmployee;
    // });
    context.read<EmployeeBloc>().add(FetchDataLeaveEmployeeEvent(
        employeeId: widget.employeeData.employeeId));
  }

  fetchQuotaData(LeaveQuotaByEmployeeModel? quotaData) async {
    //quotaData = await ApiEmployeeService.getLeaveQuotaById(employeeId);
    if (quotaData != null) {
      for (var element in quotaData.leaveSetupData) {
        switch (element.leaveTypeData.leaveTypeId) {
          case "L001":
            double amount = double.parse(element.leaveAmount);
            vacationLeave += amount;
            break;
          case "L002":
            double amount = double.parse(element.leaveAmount);
            bussinessLeave += amount;
            break;
          case "L003":
            double amount = double.parse(element.leaveAmount);
            sickLeave += amount;
            break;
        }
      }
    } else {}
  }

  fetchAmount(LeaveRequestAmountModel? leaveAmount) {
    // leaveAmount =
    //     await ApiEmployeeSelfService.getLeaveAmountByEmployeeId(employeeId);
    if (leaveAmount != null) {
      for (var element in leaveAmount.leaveRequestData) {
        switch (element.leaveTypeData.leaveTypeId) {
          case "L001":
            double amount = double.parse(element.leaveAmount);
            vacationLeaveRequest += amount;
            vacationLeave -= amount;
            break;
          case "L002":
            double amount = double.parse(element.leaveAmount);
            bussinessLeaveRequest += amount;
            bussinessLeave -= amount;
            break;
          case "L003":
            double amount = double.parse(element.leaveAmount);
            sickLeaveRequest += amount;
            sickLeave -= amount;
            break;
        }
      }
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void deactivate() {
    context.read<EmployeeBloc>().add(ClearStateLeaveEvent());
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
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
            body: BlocBuilder<EmployeeBloc, EmployeeState>(
              builder: (context, state) {
                if (state.isleaveLoading == false) {
                  vacationLeave = 0;
                  bussinessLeave = 0;
                  sickLeave = 0;
                  vacationLeaveRequest = 0;
                  bussinessLeaveRequest = 0;
                  sickLeaveRequest = 0;
                  fetchQuotaData(state.quotaData);
                  fetchAmount(state.leaveAmount);
                }
                return state.isleaveLoading == true
                    ? myLoadingScreen
                    : SizedBox(
                        width: double.infinity, ///////////////
                        child: PaginatedDataTable(
                            showFirstLastButtons: true,
                            header: SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: Row(children: [
                                const Expanded(
                                    flex: 1,
                                    child: TextThai(
                                        text: "ตารางแสดงข้อมูลการลา (Leave)",
                                        textStyle: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500))),
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Text("Leave day \nQuota : รายปี",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w800)),
                                      const Gap(15),
                                      Stack(
                                        children: [
                                          Card(
                                            elevation: 3,
                                            color: mygreycolors,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "ลาพักร้อน",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  ),
                                                  Text(
                                                      "ใช้ไป $vacationLeaveRequest วัน คงเหลือ $vacationLeave วัน"),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: 10,
                                            top: 10,
                                            child: Icon(
                                              Icons.circle,
                                              size: 18,
                                              color: vacationLeave >= 1
                                                  ? Colors.greenAccent[700]
                                                  : vacationLeave < 0
                                                      ? Colors.redAccent[700]
                                                      : Colors.amberAccent,
                                            ),
                                          )
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Card(
                                            elevation: 3,
                                            color: mygreycolors,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const TextThai(
                                                    text: "ลากิจ",
                                                    textStyle: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  TextThai(
                                                      text:
                                                          "ใช้ไป $bussinessLeaveRequest วัน คงเหลือ $bussinessLeave วัน"),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: 10,
                                            top: 10,
                                            child: Icon(
                                              Icons.circle,
                                              size: 18,
                                              color: bussinessLeave >= 1
                                                  ? Colors.greenAccent[700]
                                                  : bussinessLeave < 0
                                                      ? Colors.redAccent[700]
                                                      : Colors.amberAccent,
                                            ),
                                          )
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Card(
                                            elevation: 3,
                                            color: mygreycolors,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "ลาป่วย",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  ),
                                                  Text(
                                                      "ใช้ไป $sickLeaveRequest วัน คงเหลือ $sickLeave วัน"),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: 10,
                                            top: 10,
                                            child: Icon(
                                              Icons.circle,
                                              size: 18,
                                              color: sickLeave >= 1
                                                  ? Colors.greenAccent[700]
                                                  : sickLeave < 0
                                                      ? Colors.redAccent[700]
                                                      : Colors.amberAccent,
                                            ),
                                          )
                                        ],
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
                              DataColumn(label: Text("Status")),
                              DataColumn(label: Text("Reject")),
                            ],
                            source: DataTableRowSource(
                                leaveDataEmployee: state.leaveDataEmployee,
                                context: context,
                                fetchData: fetchData,
                                employeeId: widget.employeeData.employeeId)),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class DataTableRowSource extends DataTableSource {
  final LeaveRequestByEmployeeModel? leaveDataEmployee;
  final BuildContext context;
  final Function fetchData;
  final String employeeId;
  DataTableRowSource({
    required this.leaveDataEmployee,
    required this.context,
    required this.fetchData,
    required this.employeeId,
  });

  alertDialogInfo(String requestId) {
    //  type 1 = approve and type 2 = reject
    AwesomeDialog(
            width: 400,
            context: context,
            animType: AnimType.topSlide,
            dialogType: DialogType.info,
            title: 'Reject',
            desc: 'ปฏิเสธ',
            btnOkColor: mythemecolor,
            btnOkOnPress: () {
              leaveReject(requestId);
            },
            btnCancelOnPress: () {})
        .show();
  }

  leaveReject(String requestId) async {
    String? employeeId;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId");
    LeaveRejectModel leaveModel = LeaveRejectModel(
        leaveRequestId: requestId,
        rejectBy: employeeId!,
        comment: "Reject by HR");
    bool success = await ApiEmployeeSelfService.leaveManualReject(leaveModel);
    alertDialog(success, 2);
  }

  alertDialog(bool success, int type) {
    //  type 1 = approve and type 2 = reject
    AwesomeDialog(
      dismissOnTouchOutside: false,
      width: 450,
      context: context,
      animType: AnimType.topSlide,
      dialogType: success == true ? DialogType.success : DialogType.error,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Column(
            children: [
              type == 1
                  ? Text(
                      success == true ? 'Approve Success.' : 'Approve Fail.',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    )
                  : Text(
                      success == true ? 'Reject Success.' : 'Reject Fail.',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
              type == 1
                  ? Text(
                      success == true ? 'อนุมัติ สำเร็จ' : 'อนุมัติ ไม่สำเร็จ',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    )
                  : Text(success == true ? 'ปฏิเสธ สำเร็จ' : 'ปฏิเสธ ไม่สำเร็จ',
                      style: const TextStyle(fontStyle: FontStyle.italic)),
            ],
          ),
        ),
      ),
      btnOkColor: success == true ? Colors.greenAccent : Colors.red,
      btnOkOnPress: () {
        context
            .read<EmployeeBloc>()
            .add(FetchDataLeaveEmployeeEvent(employeeId: employeeId));
        // _EmployeeLeaveMenuState myClass1 = _EmployeeLeaveMenuState();
        // myClass1.fetchQuotaData(employeeId);
        // myClass1.fetchAmount(employeeId);
      },
    ).show();
  }

  @override
  DataRow? getRow(int index) {
    final data = leaveDataEmployee?.leaveRequestData[index];
    return leaveDataEmployee != null
        ? DataRow(
            color: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
              return index % 2 == 0 ? Colors.white : myrowscolors;
            }),
            cells: [
                DataCell(Text(data!.leaveDate.toString())),
                DataCell(Text(data.leaveTypeData.leaveTypeNameTh)),
                DataCell(Text(data.leaveAmount)),
                DataCell(Text(data.leaveDecription)),
                DataCell(
                  Container(
                    decoration: BoxDecoration(
                        color:
                            leaveDataEmployee?.leaveRequestData[index].status ==
                                    "request"
                                ? Colors.amberAccent[100]
                                : leaveDataEmployee
                                            ?.leaveRequestData[index].status ==
                                        "approve"
                                    ? Colors.greenAccent
                                    : Colors.redAccent[100],
                        borderRadius: BorderRadius.circular(14)),
                    width: 85,
                    height: 28,
                    child: Center(
                        child: Text(
                            "${leaveDataEmployee?.leaveRequestData[index].status}",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                //fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800]))),
                  ),
                ),
                DataCell(leaveDataEmployee?.leaveRequestData[index].status ==
                        "reject"
                    ? const Text("")
                    : RowDeleteBox(onPressed: () {
                        alertDialogInfo(leaveDataEmployee!
                            .leaveRequestData[index].leaveRequestId);
                      })),
              ])
        : const DataRow(cells: [
            DataCell(Text("")),
            DataCell(Text("")),
            DataCell(Text("")),
            DataCell(Text("")),
            DataCell(Text("")),
            DataCell(Text("")),
          ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => leaveDataEmployee != null
      ? leaveDataEmployee!.leaveRequestData.length
      : 0;

  @override
  int get selectedRowCount => 0;
}
