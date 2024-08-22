// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/selfservice_bloc/selfservice_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee/menu/manual_workdate/create_manual_workdate.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';
import 'package:hris_app_prototype/src/model/payroll/lot_management/get_lotnumber_dropdown_model.dart';
import 'package:hris_app_prototype/src/model/self_service/user_info/get_user_info_model.dart';
import 'package:hris_app_prototype/src/model/self_service/workdate/request_model.dart';
import 'package:hris_app_prototype/src/services/api_employee_self_service.dart';

class ManualWorkDateManage extends StatefulWidget {
  final EmployeeDatum? employeeData;
  const ManualWorkDateManage({
    Key? key,
    required this.employeeData,
  }) : super(key: key);

  @override
  State<ManualWorkDateManage> createState() => _ManualWorkDateManageState();
}

class _ManualWorkDateManageState extends State<ManualWorkDateManage> {
  ManualWorkDateRequestModel? requestData;
  bool isLoading = true;
  List<TimeStammp> timeStampList = [
    TimeStammp(date: "2024-02-14", checkInTime: "07:55:00", checkOutTime: ""),
    TimeStammp(date: "2024-02-15", checkInTime: "", checkOutTime: "17:22:00"),
    TimeStammp(
        date: "2024-02-16", checkInTime: "07:55:00", checkOutTime: "17:33:00"),
    TimeStammp(
        date: "2024-02-17", checkInTime: "07:55:00", checkOutTime: "17:33:00"),
    TimeStammp(
        date: "2024-02-18", checkInTime: "07:55:00", checkOutTime: "17:33:00"),
    TimeStammp(date: "2024-02-19", checkInTime: "07:55:00", checkOutTime: ""),
    TimeStammp(date: "2024-02-20", checkInTime: "", checkOutTime: "17:10:00"),
    TimeStammp(
        date: "2024-02-21", checkInTime: "07:55:00", checkOutTime: "17:33:00"),
    TimeStammp(date: "2024-02-22", checkInTime: "07:51:00", checkOutTime: ""),
    TimeStammp(date: "2024-02-23", checkInTime: "", checkOutTime: "17:33:00"),
  ];

  //time stamp
  UserInfoEmployeeModel? userInfoData;

//lot
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  GetLotNumberDropdownModel? lotNumberData;
  String? lotNumberId;
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

  showDialogCreate(int menuType, String? date) {
    // menutype 0 = กดที่ตารางลืมเข้า | 1 = กดที่ตารางลืมออก | 2 = ลืมสแกนเข้า ณ วันปัจจุบัน | 3 = บัตรเสีย/ลืมบัตร
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
                      title: "คำขอบันทึกเวลาเข้าออกงาน",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    content: SizedBox(
                        width: 460,
                        height: 320,
                        child: CreateManualWorkdate(
                          employeeData: widget.employeeData!,
                          menuType: menuType,
                          date: date,
                          calendarStartDate: startDate.text,
                          calendarEndDate: endDate.text,
                          formpage: 1,
                        )),
                  ));
        });
  }

  fetchData() async {
    //request data-------------
    context.read<SelfServiceBloc>().add(FetchDataManualWorkDateEvent(
        employeeId: widget.employeeData!.employeeId));
    // requestData =
    //     await ApiEmployeeSelfService.getRequestManualWorkDateByEmployeeId(
    //         widget.employeeData!.employeeId);
    //lotnumber data-------------
    lotNumberData = await ApiEmployeeSelfService.getLotNumberDropdown();
    setState(() {
      // requestData;
      // isLoading = false;
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
        widget.employeeData!.fingerScanId, startTime, finishTime);
    setState(() {
      userInfoData;
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ข้อมูลบันทึกเวลาเข้า - ออกงาน"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(child: Container()),
          Expanded(
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Gap(40),
                  Tooltip(
                    message: "เฉพาะลืมสแกนเข้า ณ วันที่ปัจจุบัน",
                    child: SizedBox(
                        width: 110,
                        height: 40,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            onPressed: () {
                              showDialogCreate(2, null);
                            },
                            child: const Text(
                              "ลืมสแกนเข้า",
                            ))),
                  ),
                  const Gap(10),
                  SizedBox(
                      width: 110,
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amberAccent[100],
                              padding: const EdgeInsets.all(1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          onPressed: () {
                            showDialogCreate(3, null);
                          },
                          child: const Text("ลืมบัตร / บัตรเสีย",
                              style: TextStyle(color: Colors.black87)))),

                  // MyFloatingButton(
                  //   onPressed: () {
                  //     showDialogCreate();
                  //   },
                  //   icon: const Icon(Icons.add),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: BlocBuilder<SelfServiceBloc, SelfServiceState>(
              builder: (context, state) {
                requestData = state.manualRequestData;
                return Column(
                  children: [
                    const Gap(10),
                    const Text(
                      "Manual work date Request",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: state.isManualDataLoading == true
                            ? myLoadingScreen
                            : ListView.builder(
                                itemCount: requestData == null
                                    ? 1
                                    : requestData
                                        ?.manualWorkDateRequestData.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: SizedBox(
                                      height: 70,
                                      child: Center(
                                        child: ListTile(
                                          leading: requestData == null
                                              ? null
                                              : SizedBox(
                                                  height: 40,
                                                  child: Icon(
                                                    requestData
                                                                ?.manualWorkDateRequestData[
                                                                    index]
                                                                .manualWorkDateTypeData
                                                                .manualWorkDateTypeId ==
                                                            "A01"
                                                        ? CupertinoIcons
                                                            .square_arrow_right
                                                        : requestData
                                                                    ?.manualWorkDateRequestData[
                                                                        index]
                                                                    .manualWorkDateTypeData
                                                                    .manualWorkDateTypeId ==
                                                                "A02"
                                                            ? CupertinoIcons
                                                                .square_arrow_left
                                                            : Icons
                                                                .credit_card_off_rounded,
                                                    color: requestData
                                                                ?.manualWorkDateRequestData[
                                                                    index]
                                                                .manualWorkDateTypeData
                                                                .manualWorkDateTypeId ==
                                                            "A01"
                                                        ? mythemecolor
                                                        : requestData
                                                                    ?.manualWorkDateRequestData[
                                                                        index]
                                                                    .manualWorkDateTypeData
                                                                    .manualWorkDateTypeId ==
                                                                "A02"
                                                            ? Colors.red[700]
                                                            : Colors.grey[600],
                                                    size: 30,
                                                  )),
                                          title: requestData == null
                                              ? const Center(
                                                  child: Text(
                                                  "ไม่มีใบคำร้อง",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                              : Row(
                                                  children: [
                                                    Text(
                                                        "${requestData?.manualWorkDateRequestData[index].manualWorkDateTypeData.manualWorkDateTypeNameTh}"),
                                                  ],
                                                ),
                                          subtitle: requestData == null
                                              ? null
                                              : Text(
                                                  "วันที่ ${requestData?.manualWorkDateRequestData[index].date} เวลา ${requestData?.manualWorkDateRequestData[index].startTime}  ${requestData?.manualWorkDateRequestData[index].endTime}"),
                                          trailing: requestData == null
                                              ? null
                                              : Container(
                                                  decoration: BoxDecoration(
                                                      color: requestData
                                                                  ?.manualWorkDateRequestData[
                                                                      index]
                                                                  .status ==
                                                              "request"
                                                          ? Colors
                                                              .amberAccent[100]
                                                          : requestData
                                                                      ?.manualWorkDateRequestData[
                                                                          index]
                                                                      .status ==
                                                                  "approve"
                                                              ? Colors
                                                                  .greenAccent
                                                              : Colors.redAccent[
                                                                  100],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14)),
                                                  width: 100,
                                                  height: 30,
                                                  child: Center(
                                                      child: Text(
                                                          "${requestData?.manualWorkDateRequestData[index].status}",
                                                          style: TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .grey[800]))),
                                                ),
                                        ),
                                      ),
                                    ),
                                  );
                                })),
                  ],
                );
              },
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "TimeStamp ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Align(
              //   alignment: Alignment.center,
              //   child: Container(
              //     alignment: Alignment.center,
              //     width: 300,
              //     decoration: BoxDecoration(
              //         borderRadius: const BorderRadius.vertical(
              //             bottom: Radius.circular(18)),
              //         color: mygreycolors,
              //         boxShadow: const [
              //           BoxShadow(
              //               color: Colors.black38, offset: Offset(0, 1))
              //         ]),
              //     padding: const EdgeInsets.all(10),
              //     child: const Text(
              //       "TimeStamp",
              //       style: TextStyle(
              //           fontSize: 20, fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 122,
                        child: DropdownGlobal(
                            labeltext: 'Lot Number',
                            value: lotNumberId,
                            items: lotNumberData?.lotNumberData.map((e) {
                              return DropdownMenuItem<String>(
                                value: e.lotMonth.toString(),
                                child: Container(
                                    width: 58,
                                    constraints: const BoxConstraints(
                                        maxWidth: 150, minWidth: 100),
                                    child:
                                        Text("${e.lotYear} / ${e.lotMonth}")),
                              );
                            }).toList(),
                            onChanged: (newValue) async {
                              setState(() {
                                lotNumberId = newValue.toString();
                                Iterable<LotNumberDatum> result = lotNumberData!
                                    .lotNumberData
                                    .where((element) =>
                                        element.lotMonth == newValue);
                                if (result.isNotEmpty) {
                                  startDate.text =
                                      result.first.startDate.toString();
                                  endDate.text =
                                      result.first.finishDate.toString();
                                }
                                fetchDataTimeStamp(
                                    startDate.text, endDate.text);
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
              lotNumberData == null
                  ? myLoadingScreen
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 34),
                              child: SingleChildScrollView(
                                child: DataTable(
                                    // headingRowColor:
                                    //     MaterialStatePropertyAll(Colors.amberAccent),
                                    columnSpacing: 1,
                                    columns: const [
                                      DataColumn(
                                          label: Text(
                                        'วันที่',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                      DataColumn(
                                          label: Text('เวลาสแกนนิ้วเข้า',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      DataColumn(
                                          label: Text('เวลาสแกนนิ้วออก',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      DataColumn(
                                          numeric: true,
                                          label: Text('',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ], // timeStampList  <<<<<< Data-test
                                    rows: userInfoData != null
                                        ? userInfoData!
                                            .userInfoData.workTimeData
                                            // timeStampList
                                            .map((index) => DataRow(cells: [
                                                  DataCell(Text(index.date)),
                                                  DataCell(
                                                      Text(index.checkInTime)),
                                                  DataCell(
                                                      Text(index.checkOutTime)),
                                                  DataCell(index
                                                                  .checkInTime ==
                                                              "" ||
                                                          index.checkOutTime ==
                                                              "" ||
                                                          (index.checkInTime ==
                                                              index
                                                                  .checkOutTime)
                                                      ? ElevatedButton(
                                                          onPressed: () {
                                                            showDialogCreate(
                                                                index.checkInTime ==
                                                                        index
                                                                            .checkOutTime
                                                                    ? 5
                                                                    : index.checkInTime ==
                                                                                "" &&
                                                                            index.checkOutTime !=
                                                                                ""
                                                                        ? 0
                                                                        : 1,
                                                                index.date);
                                                          },
                                                          child: const Text(
                                                              "ยื่นคำขอ"))
                                                      : Container()),
                                                ]))
                                            .toList()
                                        : [
                                            DataRow(cells: [
                                              DataCell(Container()),
                                              DataCell(Container()),
                                              DataCell(Container()),
                                              DataCell(Container()),
                                            ]),
                                          ]),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          )),
        ],
      ),
    );
  }
}

class TimeStammp {
  final String date;
  final String checkInTime;
  final String checkOutTime;
  TimeStammp({
    required this.date,
    required this.checkInTime,
    required this.checkOutTime,
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
