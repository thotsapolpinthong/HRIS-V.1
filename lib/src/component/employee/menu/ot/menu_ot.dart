// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/employee_bloc/employee_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee/menu/ot/create_ot.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';
import 'package:hris_app_prototype/src/model/self_service/ot/ot_reject_model.dart';
import 'package:hris_app_prototype/src/model/self_service/ot/ot_request_model.dart';
import 'package:hris_app_prototype/src/model/self_service/ot/ot_time_count_model.dart';
import 'package:hris_app_prototype/src/services/api_employee_self_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  // GetOvertimeRequestModel? otRequestData;
  OtRequestModel? otRequestData;
  OtTimeCountModel? otTimeCountData;
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

  @override
  void initState() {
    context.read<EmployeeBloc>().add(
        FetchDataOtEmployeeEvent(employeeId: widget.employeeData.employeeId));
    fetchData();
    // fetchData();
    // Iterable<PayrollLot> result =
    //     lotList.where((element) => element.lotId == lotId);
    // if (result.isNotEmpty) {
    //   setState(() {
    //     startDate.text = result.first.startDate.toString();
    //     endDate.text = result.first.endDate.toString();
    //   });
    // }
    super.initState();
  }

  fetchData() async {
    // otRequestData = await ApiEmployeeSelfService.getOtRequestByEmployeeId(
    //     widget.employeeData.employeeId);
    otTimeCountData = await ApiEmployeeSelfService.getOtTimeCount(
        widget.employeeData.employeeId);
    setState(() {
      otTimeCountData;
    });
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
                    content: SizedBox(
                        width: 480,
                        height: 600,
                        child: CreateOt(
                          employeeData: widget.employeeData,
                        )),
                  ));
        });
  }

  Widget rowStat(OtTimeCountModel? otTimeCountData) {
    return Row(
      children: [
        Expanded(
            child: MyOtListTileMenuOt(
          title: "Holiday",
          subTitle: "ทำงานวันหยุด",
          countTime: otTimeCountData == null
              ? 0
              : otTimeCountData.overTimeCountData.holidayTotalAmount,
          type: 1,
        )).animate().scale().fadeIn().slideX(),
        Expanded(
                child: MyOtListTileMenuOt(
          title: "OT-normal",
          subTitle: "โอทีวันทำงาน",
          countTime: otTimeCountData == null
              ? 0
              : otTimeCountData.overTimeCountData.otNormalTotalAmount,
          type: 2,
        ))
            .animate()
            .scaleXY(delay: 100.ms)
            .fadeIn(delay: 100.ms)
            .slideX(delay: 100.ms),
        Expanded(
                child: MyOtListTileMenuOt(
          title: "OT-holiday",
          subTitle: "โอทีในวันหยุด",
          countTime: otTimeCountData == null
              ? 0
              : otTimeCountData.overTimeCountData.otHolidayTotalAmount,
          type: 3,
        ))
            .animate()
            .scaleXY(delay: 200.ms)
            .fadeIn(delay: 200.ms)
            .slideX(delay: 200.ms),
        Expanded(
                child: MyOtListTileMenuOt(
          title: "OT-special",
          subTitle: "โอทีแบบเหมา",
          countTime: otTimeCountData == null
              ? 0
              : otTimeCountData.overTimeCountData.otSpecialTotalAmount,
          type: 4,
        ))
            .animate()
            .scaleXY(delay: 300.ms)
            .fadeIn(delay: 300.ms)
            .slideX(delay: 300.ms),
      ],
    );
  }

  @override
  void deactivate() {
    context.read<EmployeeBloc>().add(ClearStateOtEvent());
    super.deactivate();
  }

  @override
  void dispose() {
    otTimeCountData;
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
                showDialogCreateOt();
              },
              icon: const Icon(CupertinoIcons.plus),
            ).animate().shake(),
            backgroundColor: Colors.white,
            body: BlocBuilder<EmployeeBloc, EmployeeState>(
              builder: (context, state) {
                return state.isOtLoading
                    ? myLoadingScreen
                    : SizedBox(
                        width: double.infinity, ///////////////
                        child: PaginatedDataTable(
                            columnSpacing: 10,
                            header: SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: Row(children: [
                                const Expanded(
                                    flex: 2,
                                    child: Text(
                                        "ตารางแสดงข้อมูลการทำงานล่วงเวลา (OT)",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800))),
                                Expanded(
                                  flex: 3,
                                  child: rowStat(otTimeCountData),
                                ),
                              ]),
                            ),

                            //  columnSpacing: 30,
                            columns: const [
                              DataColumn(label: Text("OT Date")),
                              DataColumn(label: Text("OT Type")),
                              DataColumn(label: Text("Request Type")),
                              DataColumn(label: Text("Time Scan(In)")),
                              DataColumn(label: Text("Time Scan(Out)")),
                              DataColumn(label: Text("Request Time")),
                              DataColumn(label: Text("Total (hr.)")),
                              DataColumn(label: Text("Discription")),
                              DataColumn(label: Text("Status")),
                              DataColumn(label: Text("Reject")),
                            ],
                            source: DataTableRowSource(
                                state.otRequestData?.overTimeRequestData,
                                context,
                                widget.employeeData.employeeId)),
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
  final List<OverTimeRequestDatum>? requestData;
  final BuildContext context;
  final String employeeIdRequest;
  DataTableRowSource(
    this.requestData,
    this.context,
    this.employeeIdRequest,
  );
  // List<OtDataTime> leaveList = [
  //   OtDataTime(
  //       otDate: "2024-01-01",
  //       otNormal: 3.00,
  //       holiday: 0,
  //       otHoliday: 0,
  //       otCharter: 0,
  //       payrollLot: "01/2024",
  //       requestType: "OT-หลังเลิกงาน",
  //       remark: "Create by HRM"),
  //   OtDataTime(
  //       otDate: "2024-01-02",
  //       otNormal: 4.00,
  //       holiday: 0,
  //       otHoliday: 0,
  //       otCharter: 0,
  //       payrollLot: "01/2024",
  //       requestType: "OT-หลังเลิกงาน",
  //       remark: "Create by HRM"),
  //   OtDataTime(
  //       otDate: "2024-01-03",
  //       otNormal: 3.00,
  //       holiday: 0,
  //       otHoliday: 0,
  //       otCharter: 0,
  //       payrollLot: "01/2024",
  //       requestType: "OT-หลังเลิกงาน",
  //       remark: "Create by HRM"),
  //   OtDataTime(
  //       otDate: "2024-01-04",
  //       otNormal: 2.50,
  //       holiday: 0,
  //       otHoliday: 0,
  //       otCharter: 0,
  //       payrollLot: "01/2024",
  //       requestType: "OT-หลังเลิกงาน",
  //       remark: "Create by HRM"),
  // ];

  @override
  DataRow? getRow(int index) {
    final data = requestData?[index];
    return requestData != null
        ? DataRow(cells: [
            DataCell(Text(data!.otDate)),
            DataCell(Text(data.otTypeData.otTypeName)),
            DataCell(Text(data.oTrequestTypeData.oTrequestTypeName)),
            DataCell(Row(
              children: [
                data.workTimeScan.startTimeType == ""
                    ? Container()
                    : Icon(
                        data.workTimeScan.startTimeType == "time scan"
                            ? Icons.fingerprint_rounded
                            : data.workTimeScan.startTimeType ==
                                    "manual work date"
                                ? Icons.edit_document
                                : Icons.abc,
                        color: Colors.grey,
                      ),
                const Gap(5),
                Text(data.workTimeScan.startTime),
              ],
            )),
            DataCell(Row(
              children: [
                data.workTimeScan.endTimeType == ""
                    ? Container()
                    : Icon(
                        data.workTimeScan.endTimeType == "time scan"
                            ? Icons.fingerprint_rounded
                            : data.workTimeScan.endTimeType ==
                                    "manual work date"
                                ? Icons.edit_document
                                : Icons.abc,
                        color: Colors.grey,
                      ),
                const Gap(5),
                Text(data.workTimeScan.endTime),
              ],
            )),
            DataCell(Text(
                "${data.otData[0].otStartTime} - ${data.otData[0].otEndTime}")),
            DataCell(Text(data.ncountOt)),
            DataCell(Text(data.otDescription)),
            DataCell(
              Container(
                decoration: BoxDecoration(
                    color: data.status == "request"
                        ? Colors.amberAccent[100]
                        : data.status == "approve"
                            ? Colors.greenAccent
                            : Colors.redAccent[100],
                    borderRadius: BorderRadius.circular(14)),
                width: 85,
                height: 28,
                child: Center(
                    child: Text(data.status,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            //fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800]))),
              ),
            ),
            DataCell(data.status != "request" && data.status != "approve"
                ? Container()
                : RowDeleteBox(onPressed: () {
                    alertDialogInfo(data.otRequestId);
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
  int get rowCount => requestData == null ? 0 : requestData!.length;

  @override
  int get selectedRowCount => 0;

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
    OtRejectModel model = OtRejectModel(
        otRequestId: requestId, rejectBy: employeeId!, comment: "Reject by HR");
    bool success = await ApiEmployeeSelfService.otReject(model);
    // LeaveRejectModel leaveModel = LeaveRejectModel(
    //     leaveRequestId: requestId,
    //     rejectBy: employeeId!,
    //     comment: "Reject by HR");
    // bool success = await ApiEmployeeSelfService.leaveReject(leaveModel);
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
            .add(FetchDataOtEmployeeEvent(employeeId: employeeIdRequest));
        Navigator.pop(context);
      },
    ).show();
  }
}

class MyOtListTileMenuOt extends StatelessWidget {
  final double countTime;
  final String title;
  final String subTitle;
  final int type; //  1,2,3,4
  const MyOtListTileMenuOt({
    Key? key,
    required this.countTime,
    required this.title,
    required this.subTitle,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.grey[200],
      child: SizedBox(
        height: 54,
        child: Center(
          child: ListTile(
            title: Text(title),
            // subtitle: Text(title),
            trailing: SizedBox(
              height: 43,
              child: Column(
                children: [
                  Text(
                    countTime.toStringAsFixed(2),
                    style: TextStyle(
                        fontSize: 16,
                        color: countTime == 0
                            ? Colors.black54
                            : Colors.greenAccent[700]),
                  ),
                  const Text(
                    "ชั่วโมง",
                    style: TextStyle(color: Colors.black54),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
