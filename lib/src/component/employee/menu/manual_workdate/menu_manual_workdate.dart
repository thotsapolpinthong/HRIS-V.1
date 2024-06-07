// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/selfservice_bloc/selfservice_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee/menu/manual_workdate/create_manual_workdate.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';
import 'package:hris_app_prototype/src/model/payroll/lot_management/get_lotnumber_dropdown_model.dart';
import 'package:hris_app_prototype/src/model/self_service/user_info/get_user_info_model.dart';
import 'package:hris_app_prototype/src/model/self_service/workdate/manual_reject_model.dart';
import 'package:hris_app_prototype/src/model/self_service/workdate/request_model.dart';
import 'package:hris_app_prototype/src/services/api_employee_self_service.dart';

import 'package:shared_preferences/shared_preferences.dart';

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
  int isExpandedPage = 0;
  //lot
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  GetLotNumberDropdownModel? lotNumberData;
  String? lotNumberId;
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

  //time stamp
  UserInfoEmployeeModel? userInfoData;

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
                        width: 460,
                        height: 320,
                        child: CreateManualWorkdate(
                          employeeData: widget.employeeData,
                          menuType: 4,
                          calendarStartDate: startDate.text,
                          calendarEndDate: endDate.text,
                          formpage: 2,
                        )),
                  ));
        });
  }

  fetchData() async {
    //request data-------------
    context.read<SelfServiceBloc>().add(FetchDataManualWorkDateEvent(
        employeeId: widget.employeeData.employeeId));
    //lotnumber data-------------
    lotNumberData = await ApiEmployeeSelfService.getLotNumberDropdown();
    setState(() {
      lotNumberData;
      //เงื่อนไขหาเดือนล่าสุด
      if (lotNumberData != null) {
        String maxLotMonth = '';
        for (var e in lotNumberData!.lotNumberData) {
          if (e.lotMonth.compareTo(maxLotMonth) > 0) {
            startDate.text = e.startDate;
            endDate.text = e.finishDate;
            lotNumberId = e.lotMonth;
          }
        }
      }
      fetchDataTimeStamp(startDate.text, endDate.text);
    });
  }

  fetchDataTimeStamp(String startTime, String finishTime) async {
    userInfoData = await ApiEmployeeSelfService.getUserInfoByEmployee(
        widget.employeeData.fingerScanId, startTime, finishTime);
    setState(() {
      userInfoData;
    });
  }

  @override
  void initState() {
    fetchData();
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

  @override
  void deactivate() {
    userInfoData;
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
                showDialogCreate();
              },
              icon: const Icon(CupertinoIcons.plus),
            ).animate().shake(),
            backgroundColor: Colors.white,
            body: BlocBuilder<SelfServiceBloc, SelfServiceState>(
              builder: (context, state) {
                return userInfoData == null
                    ? myLoadingScreen
                    : state.isManualDataLoading == true
                        ? myLoadingScreen
                        : SizedBox(
                            width: double.infinity, ///////////////
                            child: PaginatedDataTable(
                                showFirstLastButtons: true,
                                header: SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: Row(children: [
                                    const Expanded(
                                        flex: 1,
                                        child: Text("Manual Work date",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800))),
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 43,
                                                    child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          elevation:
                                                              isExpandedPage ==
                                                                      0
                                                                  ? 2
                                                                  : 0,
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .horizontal(
                                                                      left: Radius
                                                                          .circular(
                                                                              8))),
                                                          backgroundColor:
                                                              isExpandedPage ==
                                                                      0
                                                                  ? mythemecolor
                                                                  : Colors.grey[
                                                                      350],
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            isExpandedPage = 0;
                                                          });
                                                        },
                                                        child: Text(
                                                          "TimeStamp.",
                                                          style: TextStyle(
                                                              color: isExpandedPage ==
                                                                      0
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black54),
                                                        )),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 43,
                                                    child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          elevation:
                                                              isExpandedPage ==
                                                                      1
                                                                  ? 2
                                                                  : 0,
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .horizontal(
                                                                      right: Radius
                                                                          .circular(
                                                                              8))),
                                                          backgroundColor:
                                                              isExpandedPage ==
                                                                      1
                                                                  ? mythemecolor
                                                                  : Colors.grey[
                                                                      350],
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            isExpandedPage = 1;
                                                          });
                                                        },
                                                        child: Text(
                                                          "Request.",
                                                          style: TextStyle(
                                                              color: isExpandedPage ==
                                                                      1
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black54),
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Gap(5),
                                          Expanded(
                                            child: SizedBox(
                                              width: 122,
                                              child: DropdownGlobal(
                                                  labeltext: 'Lot Number',
                                                  value: lotNumberId,
                                                  items: lotNumberData
                                                      ?.lotNumberData
                                                      .map((e) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value:
                                                          e.lotMonth.toString(),
                                                      child: Container(
                                                          width: 58,
                                                          constraints:
                                                              const BoxConstraints(
                                                                  maxWidth: 150,
                                                                  minWidth:
                                                                      100),
                                                          child: Text(
                                                              "${e.lotYear} / ${e.lotMonth}")),
                                                    );
                                                  }).toList(),
                                                  onChanged: isExpandedPage == 1
                                                      ? null
                                                      : (newValue) async {
                                                          setState(() {
                                                            lotNumberId =
                                                                newValue
                                                                    .toString();
                                                            Iterable<
                                                                    LotNumberDatum>
                                                                result =
                                                                lotNumberData!
                                                                    .lotNumberData
                                                                    .where((element) =>
                                                                        element
                                                                            .lotMonth ==
                                                                        newValue);
                                                            if (result
                                                                .isNotEmpty) {
                                                              startDate.text =
                                                                  result.first
                                                                      .startDate
                                                                      .toString();
                                                              endDate.text = result
                                                                  .first
                                                                  .finishDate
                                                                  .toString();
                                                            }
                                                            fetchDataTimeStamp(
                                                                startDate.text,
                                                                endDate.text);
                                                          });
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
                                columns: isExpandedPage == 0
                                    ? const [
                                        DataColumn(label: Text("Date")),
                                        DataColumn(
                                            label: Text("Time Scan(In)")),
                                        DataColumn(
                                            label: Text("Time Scan(Out)")),
                                      ]
                                    : const [
                                        DataColumn(label: Text("Date")),
                                        DataColumn(label: Text("Type")),
                                        DataColumn(
                                            label: Text("Request Time In")),
                                        DataColumn(
                                            label: Text("Request Time Out")),
                                        DataColumn(label: Text("Description")),
                                        DataColumn(label: Text("Status")),
                                        DataColumn(label: Text("Reject")),
                                      ],
                                source: isExpandedPage == 0
                                    ? DataTableRowSource(
                                        userInfoData?.userInfoData.workTimeData)
                                    : DataTableRowRequestSource(
                                        state.manualRequestData
                                            ?.manualWorkDateRequestData,
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
  List<WorkTimeDatum>? workTimeData;
  DataTableRowSource(
    this.workTimeData,
  );

  // List<WorkDataTime> leaveList = [
  //   WorkDataTime(
  //       workDate: "2023-12-26",
  //       type: "A01",
  //       time: "08:00:00",
  //       modifiedBy: "เวลากับรหัสพนักงาน"),
  //   WorkDataTime(
  //       workDate: "2023-12-27",
  //       type: "A02",
  //       time: "17:00:00",
  //       modifiedBy: "เวลากับรหัสพนักงาน"),
  //   WorkDataTime(
  //       workDate: "2023-12-28",
  //       type: "A01",
  //       time: "08:00:00",
  //       modifiedBy: "เวลากับรหัสพนักงาน"),
  //   WorkDataTime(
  //       workDate: "2024-01-02",
  //       type: "A02",
  //       time: "17:00:00",
  //       modifiedBy: "เวลากับรหัสพนักงาน"),
  // ];
  // List<TimeStammp> timeStampList = [
  //   TimeStammp(date: "2024-02-01", scanIn: "07:55:00", scanOut: "17:20:00"),
  //   TimeStammp(date: "2024-02-02", scanIn: "07:50:00", scanOut: "17:22:00"),
  //   TimeStammp(date: "2024-02-03", scanIn: "", scanOut: "17:25:00"),
  //   TimeStammp(date: "2024-02-04", scanIn: "07:59:00", scanOut: "17:10:00"),
  //   TimeStammp(date: "2024-02-05", scanIn: "07:51:00", scanOut: ""),
  //   TimeStammp(date: "2024-02-06", scanIn: "07:52:00", scanOut: "17:33:00"),
  // ];

  @override
  DataRow? getRow(int index) {
    final data = workTimeData![index];

    return DataRow(cells: [
      DataCell(Text(data.date)),
      DataCell(Text(data.checkInTime == "" ? "-" : data.checkInTime)),
      DataCell(Text(data.checkOutTime == "" ? "-" : data.checkOutTime)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => workTimeData == null ? 0 : workTimeData!.length;

  @override
  int get selectedRowCount => 0;
}

class DataTableRowRequestSource extends DataTableSource {
  List<ManualWorkDateRequestDatum>? manualWorkDateRequestData;
  final BuildContext context;
  final String dataEmployeeId;
  DataTableRowRequestSource(
    this.manualWorkDateRequestData,
    this.context,
    this.dataEmployeeId,
  );

  @override
  DataRow? getRow(int index) {
    final data = manualWorkDateRequestData?[index];

    return manualWorkDateRequestData != null
        ? DataRow(cells: [
            DataCell(Text(data!.date)),
            DataCell(
                Text(data.manualWorkDateTypeData.manualWorkDateTypeNameTh)),
            DataCell(Text(data.startTime == "No data" ? "-" : data.startTime)),
            DataCell(Text(data.endTime == "No data" ? "-" : data.endTime)),
            DataCell(Text(data.decription)),
            DataCell(
              Container(
                decoration: BoxDecoration(
                    color: manualWorkDateRequestData![index].status == "request"
                        ? Colors.amberAccent[100]
                        : manualWorkDateRequestData![index].status == "approve"
                            ? Colors.greenAccent
                            : Colors.redAccent[100],
                    borderRadius: BorderRadius.circular(14)),
                width: 85,
                height: 28,
                child: Center(
                    child: Text(manualWorkDateRequestData![index].status,
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
                    alertDialogInfo(data.manualWorkDateRequestId);
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
  int get rowCount =>
      manualWorkDateRequestData == null ? 0 : manualWorkDateRequestData!.length;

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
              manualWorkDateReject(requestId);
            },
            btnCancelOnPress: () {})
        .show();
  }

  manualWorkDateReject(String requestId) async {
    String? employeeId;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId");
    ManualWorkdateRejectModel model = ManualWorkdateRejectModel(
        manualWorkDateRequestId: requestId,
        rejectBy: employeeId!,
        comment: "Reject by Manager");

    bool success = await ApiEmployeeSelfService.manualWorkDateReject(model);
    if (success == true) {}
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
            .read<SelfServiceBloc>()
            .add(FetchDataManualWorkDateEvent(employeeId: dataEmployeeId));
      },
    ).show();
  }
}
