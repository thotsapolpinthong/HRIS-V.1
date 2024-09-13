// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/payroll_bloc/bloc/payroll_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/payroll/2_to_payroll/employee_detials_table.dart';
import 'package:hris_app_prototype/src/component/payroll/2_to_payroll/pdf_work_hour_employee.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/Login/login_model.dart';
import 'package:hris_app_prototype/src/model/payroll/lot_management/get_lotnumber_dropdown_model.dart';
import 'package:hris_app_prototype/src/model/payroll/to_payroll/time_record_model.dart';
import 'package:hris_app_prototype/src/services/api_payroll_service.dart';
import 'package:hris_app_prototype/src/services/api_role_permission.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ToPayroll extends StatefulWidget {
  const ToPayroll({super.key});

  @override
  State<ToPayroll> createState() => _ToPayrollState();
}

class _ToPayrollState extends State<ToPayroll> {
  //Lot
  TextEditingController startDate = TextEditingController();
  TextEditingController finishDate = TextEditingController();
  GetLotNumberDropdownModel? lotNumberData;
  String? lotNumberId;
  //table
  bool isDataLoading = false;
  int rowIndex = 10;
  int? sortColumnIndex;
  bool sort = true;
  TextEditingController search = TextEditingController();
  bool onSearch = false;
  TimeRecordModel? timeRecordData;
  // List<TimeRecordDatum> timeRecordData = [];
  List<TimeRecordDatum> filterData = [];
//menu count
  bool isShowFloat = false;
  int isSendData = 0; //0 defualt 1 send  2 completelock
  TextEditingController test1 = TextEditingController();
  int eTotal = 0;
  int eCount = 0;
  int eRegularCount = 0;
  int eDailyCount = 0;
  int eTempCount = 0;
  int wOtCount = 0;
  double otnCount = 0;
  double hCount = 0;
  double othCount = 0;
  double foodTotal = 0.00;

  bool thLanguage = false;
  LoginData? _loginData;
  bool hr = false;
  fetchDataLogin() async {
    _loginData = await ApiRolesService.getUserData();
    setState(() {
      if (_loginData != null) {
        if (_loginData?.role.roleId == 'R000000000' ||
            _loginData?.role.roleId == "R000000003" ||
            _loginData?.role.roleId == "R000000004") {
          hr = true;
        } // dev,acc manager
        ;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: myredcolors,
            content: const Text("Load Role Permissions Fail")));
      }
    });
  }

  Future fetchData() async {
    //lotnumber data-------------
    // lotNumberData = await ApiEmployeeSelfService.getLotNumberDropdown();
    lotNumberData = await ApiPayrollService.getLotNumberAll();
    setState(() {
      lotNumberData;
      //เงื่อนไขหาเดือนล่าสุด
      if (lotNumberData != null) {
        String maxLotMonth = '';
        for (var e in lotNumberData!.lotNumberData) {
          if (e.lotMonth.compareTo(maxLotMonth) > 0) {
            startDate.text = e.startDate.substring(0, 10);
            finishDate.text = e.finishDate.substring(0, 10);
            lotNumberId = e.lotNumberId;
            isSendData = int.parse(e.lockHr == "No data" ? "0" : e.lockHr);
          }
        }
        isShowFloat = true;
      }
      fetchTimeRecord();
    });
  }

  Future fetchTimeRecord() async {
    setState(() {
      isDataLoading = true;
    });
    timeRecordData =
        await ApiPayrollService.getTimeRecord(startDate.text, finishDate.text);

    setState(() {
      timeRecordData;
      eTotal = 0;
      eCount = 0;
      eRegularCount = 0;
      eDailyCount = 0;
      eTempCount = 0;
      wOtCount = 0;
      otnCount = 0.00;
      hCount = 0.00;
      othCount = 0.00;
      foodTotal = 0.00;
      filterData = timeRecordData?.timeRecordData ?? [];
      if (timeRecordData?.timeRecordData != null) {
        calculate(timeRecordData!.timeRecordData);
      }
      LotNumberDatum lot = lotNumberData!.lotNumberData
          .firstWhere((element) => element.lotNumberId == lotNumberId);

      isSendData = int.parse(lot.lockHr == "No data" ? "0" : lot.lockHr);

      isDataLoading = false;
    });
  }

  calculate(List<TimeRecordDatum> timeRecordData) {
    eTotal = timeRecordData.length;
    for (var element in timeRecordData) {
      //แยกปนะเภทพนง.
      switch (element.staffType) {
        case "พนักงานประจำ":
          eCount++;
          if (element.normalOt != null ||
              element.holidayOt != null ||
              element.workHoliday != null) wOtCount++;

          break;
        case "พนักงานรายวันประจำ":
          eRegularCount++;
          if (element.normalOt != null ||
              element.holidayOt != null ||
              element.workHoliday != null) wOtCount++;

          break;
        case "พนักงานรายวัน":
          eDailyCount++;
          if (element.normalOt != null ||
              element.holidayOt != null ||
              element.workHoliday != null) wOtCount++;

          break;
        case "พนักงานรายวันชั่วคราว":
          eTempCount++;
          if (element.normalOt != null ||
              element.holidayOt != null ||
              element.workHoliday != null) wOtCount++;

          break;
      }
      // OT
      otnCount += double.parse(element.normalOt ?? "0");
      hCount += double.parse(element.workHoliday ?? "0");
      othCount += double.parse(element.holidayOt ?? "0");
      //ค่าอาหารกลางวัน
      foodTotal += (double.parse(element.foodAllowance) * 25);
    }
  }

  onSearchColumn(int columnIndex, bool ascending) {
    setState(() {
      sort = ascending;
      sortColumnIndex = columnIndex;
      switch (columnIndex) {
        case 0:
          if (sort) {
            filterData.sort((a, b) => a.employeeId.compareTo(b.employeeId));
          } else {
            filterData.sort((a, b) => b.employeeId.compareTo(a.employeeId));
          }
          break;
        case 1:
          if (sort) {
            filterData
                .sort((a, b) => a.departmentName.compareTo(b.departmentName));
          } else {
            filterData
                .sort((a, b) => b.departmentName.compareTo(a.departmentName));
          }
          break;
        case 2:
          if (sort) {
            filterData.sort((a, b) => a.firstName.compareTo(b.firstName));
          } else {
            filterData.sort((a, b) => b.firstName.compareTo(a.firstName));
          }
          break;
        case 4:
          if (sort) {
            filterData.sort((a, b) => a.positionName.compareTo(b.positionName));
          } else {
            filterData.sort((a, b) => b.positionName.compareTo(a.positionName));
          }
          break;
        case 5:
          if (sort) {
            filterData.sort((a, b) => a.staffType.compareTo(b.staffType));
          } else {
            filterData.sort((a, b) => b.staffType.compareTo(a.staffType));
          }
          break;
      }
    });
  }

  toTestPage() {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Padding(
            padding: const EdgeInsets.all(40),
            child: Container(
              decoration: BoxDecoration(
                  color: mygreycolors, borderRadius: BorderRadius.circular(20)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8),
                    child: TitleDialog(
                      title: "",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SfPdfViewer.network(
                            "http://192.168.0.215/RPTHR014.pdf"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Widget lotMenu() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 58,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 280,
                child: DropdownGlobal(
                    labeltext: 'Lot Number',
                    value: lotNumberId,
                    items: lotNumberData?.lotNumberData.map((e) {
                      return DropdownMenuItem<String>(
                        value: e.lotNumberId,
                        child: Container(
                            width: 58,
                            constraints: const BoxConstraints(
                                maxWidth: 150, minWidth: 100),
                            child: Text("${e.lotYear} / ${e.lotMonth}")),
                      );
                    }).toList(),
                    onChanged: (newValue) async {
                      setState(() {
                        lotNumberId = newValue.toString();
                        Iterable<LotNumberDatum> result =
                            lotNumberData!.lotNumberData.where(
                                (element) => element.lotNumberId == newValue);
                        if (result.isNotEmpty) {
                          startDate.text =
                              result.first.startDate.substring(0, 10);
                          finishDate.text =
                              result.first.finishDate.substring(0, 10);
                        }
                        if (timeRecordData != null) {
                          fetchTimeRecord();
                        }
                      });
                    },
                    validator: null),
              ),
              SizedBox(
                width: 240,
                child: TextFormFieldDatepickGlobal(
                    controller: startDate,
                    labelText: "Start Date",
                    validatorless: null,
                    ontap: () {}),
              ),
              SizedBox(
                width: 240,
                child: TextFormFieldDatepickGlobal(
                    controller: finishDate,
                    labelText: "Finish Date",
                    validatorless: null,
                    ontap: () {}),
              ),
              const Gap(4),
              SizedBox(
                width: 42,
                height: 42,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.all(0)),
                    onPressed: () {
                      // context.read<PayrollBloc>().add(
                      //     FetchTimeRecordDataEvent(
                      //         startDate: startDate.text,
                      //         endDate: finishDate.text));
                      fetchTimeRecord();
                    },
                    child: Icon(
                      Icons.person_search_rounded,
                      size: 30,
                      color: mygreycolors,
                    )),
              ),
              const Gap(4),
              Tooltip(
                message: "พิมพ์ใบสรุปวันทำงาน",
                child: SizedBox(
                  width: 42,
                  height: 42,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.all(0)),
                      onPressed: () {
                        // toTestPage();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WorkHourPdfPage(
                                      startDate: startDate.text,
                                      endDate: finishDate.text,
                                      type: "Worktime",
                                    )
                                //  PrintingPDF()
                                ));
                      },
                      child: Icon(
                        Icons.print_rounded,
                        size: 30,
                        color: mygreycolors,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuCount(List<TimeRecordDatum> timeRecordData) {
    // double workdate = double.parse(timeRecordData.)

    LotNumberDatum lot = lotNumberData!.lotNumberData
        .firstWhere((element) => element.lotNumberId == lotNumberId);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Stack(
        children: [
          Column(
            children: [
              TextThai(
                text: "Employee Summary '${lot.lotYear} / ${lot.lotMonth}'",
                textStyle: const TextStyle(fontSize: 16),
              ),
              const Gap(5),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 5,
                  children: [
                    MyCard(
                        typeCount: false,
                        headerText: "Total emp.",
                        number: eTotal.toString(),
                        unitText: "persons"),
                    MyCard(
                        typeCount: false,
                        headerText: "Full-time emp.",
                        number: eCount.toString(),
                        unitText: "persons"),
                    MyCard(
                        typeCount: false,
                        headerText: "Regular daily emp.",
                        number: eRegularCount.toString(),
                        unitText: "persons"),
                    MyCard(
                        typeCount: false,
                        headerText: "Daily emp.",
                        number: eDailyCount.toString(),
                        unitText: "persons"),
                    MyCard(
                        typeCount: false,
                        headerText: "Temporary emp.",
                        number: eTempCount.toString(),
                        unitText: "persons"),
                    MyCard(
                        typeCount: false,
                        headerText: "OT-worker",
                        number: wOtCount.toString(),
                        unitText: "persons"),
                    MyCard(
                        typeCount: true,
                        headerText: "OT-normal",
                        number: otnCount.toStringAsFixed(2),
                        unitText: "hour"),
                    MyCard(
                        typeCount: true,
                        headerText: "Holiday",
                        number: hCount.toStringAsFixed(2),
                        unitText: "hour"),
                    MyCard(
                        typeCount: true,
                        headerText: "OT-holiday",
                        number: othCount.toStringAsFixed(2),
                        unitText: "hour"),
                    MyCard(
                        typeCount: true,
                        headerText: "Food Allowance",
                        number: foodTotal.toString(),
                        unitText: "bath"),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
              right: 1,
              bottom: 1,
              child: isSendData == 2
                  ? Container(
                      width: 160,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[350]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.lock_rounded)
                              .animate()
                              .fade(delay: 0.3.seconds),
                          const Gap(5),
                          Text("Lock Complete")
                        ],
                      ))
                  : SizedBox(
                      width: 160,
                      height: 80,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              disabledBackgroundColor: Colors.greenAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: !hr
                              ? null
                              : isSendData == 2
                                  ? null
                                  : () async {
                                      setState(() {
                                        isSendData = 1;
                                      });
                                      bool success =
                                          await ApiPayrollService.hrLock(
                                              startDate.text,
                                              finishDate.text,
                                              "df");
                                      // Future.delayed(const Duration(seconds: 5), () {
                                      //   setState(() {
                                      //     isSendData = 2;
                                      //   });
                                      // });
                                      Future.delayed(3.seconds, () {
                                        setState(() {
                                          if (success) {
                                            fetchTimeRecord();
                                          } else {
                                            isSendData = 0;
                                          }
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: success
                                                      ? mygreencolors
                                                      : myredcolors,
                                                  content: Text(success
                                                      ? "HR Locking Lot ${startDate.text} - ${finishDate.text} Success"
                                                      : "HR Locking Lot ${startDate.text} - ${finishDate.text} Fail")));
                                        });
                                      });
                                    },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isSendData == 1
                                  ? SizedBox(
                                      child: Lottie.asset(
                                          'assets/topayroll.json',
                                          width: 50,
                                          height: 50,
                                          frameRate: FrameRate(60)),
                                    ).animate().fade()
                                  : Icon(isSendData == 2
                                          ? Icons.lock_rounded
                                          : Icons.toll_rounded)
                                      .animate()
                                      .fade(delay: 0.3.seconds),
                              const Gap(5),
                              Text(isSendData == 0
                                  ? "Send to Payroll"
                                  : isSendData == 1
                                      ? "Sending..."
                                      : "Lock Complete")
                            ],
                          )),
                    )),
          Positioned(
              right: 1,
              top: 1,
              child: Tooltip(
                message: thLanguage ? "เปลี่ยนภาษา" : "Change language.",
                child: InkWell(
                    onTap: () => setState(() => thLanguage = !thLanguage),
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: 'ENG',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: !thLanguage ? 15 : 13,
                                  color: !thLanguage
                                      ? mythemecolor
                                      : Colors.grey[500])),
                          TextSpan(
                              text: '|',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600])),
                          TextSpan(
                              text: 'TH',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: thLanguage ? 15 : 13,
                                  color: thLanguage
                                      ? mythemecolor
                                      : Colors.grey[500])),
                        ],
                      ),
                    )),
              ))
        ],
      ),
    );
  }

  Widget statusState() {
    switch (isSendData) {
      case 1:
        return Container();
      case 2:
        return Container(
          width: 100,
          height: 80,
          decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_rounded)
                  .animate()
                  .fade(duration: 0.5.seconds),
              const Center(child: Text("Complete!")),
            ],
          ),
        ).animate().fade();
      default:
        return Container();
    }
  }

  Widget menuCounttest() {
    return Stack(children: [
      InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: isShowFloat ? null : () => setState(() => isShowFloat = true),
        child: AnimatedContainer(
          width: isShowFloat ? MediaQuery.of(context).size.width / 2 : 55,
          height: isShowFloat ? MediaQuery.of(context).size.height / 1.8 : 55,
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
              color: isShowFloat ? mygreycolors : mythemecolor,
              borderRadius: BorderRadius.circular(isShowFloat ? 12 : 14),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 8.0,
                  spreadRadius: 1.0,
                ),
              ]),
          child: isShowFloat
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: menuCount(
                      timeRecordData?.timeRecordData ?? []) // summary(),
                  )
              : Icon(
                  Icons.article_rounded,
                  color: mygreycolors,
                ),
        ),
      ),
      Positioned(
          top: isShowFloat ? 5 : null,
          left: 5,
          child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () => setState(() => isShowFloat = false),
              child: isShowFloat
                  ? Transform.flip(
                      flipY: true,
                      child: Icon(
                        Icons.remove_rounded,
                        size: 32,
                        color: Colors.grey[700],
                      ),
                    ).animate().fade(delay: 200.ms)
                  : Container())),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: TextThai(
                    text: "ส่งข้อมูลการทำงานถึงฝ่ายบัญชี (To Payroll)",
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(child: lotMenu()),
                      if (timeRecordData != null)
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: SizedBox(
                            width: 340,
                            height: 42,
                            child: TextFormFieldSearch(
                              controller: search,
                              enabled: true,
                              onChanged: (value) {
                                if (value == '') {
                                  setState(() {
                                    onSearch = false;
                                    filterData =
                                        timeRecordData?.timeRecordData ?? [];
                                  });
                                } else {
                                  setState(() {
                                    onSearch = true;
                                    filterData = filterData.where((e) {
                                      final eId = e.employeeId
                                          .toLowerCase()
                                          .contains(value.toLowerCase());
                                      final dep = e.departmentName
                                          .toLowerCase()
                                          .contains(value.toLowerCase());
                                      final fname = e.firstName
                                          .toLowerCase()
                                          .contains(value.toLowerCase());
                                      final lname = e.lastName
                                          .toLowerCase()
                                          .contains(value.toLowerCase());
                                      final pname = e.positionName
                                          .toLowerCase()
                                          .contains(value.toLowerCase());
                                      final type = e.staffType
                                          .toLowerCase()
                                          .contains(value.toLowerCase());

                                      return eId ||
                                          dep ||
                                          fname ||
                                          lname ||
                                          pname ||
                                          type;
                                    }).toList();
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: BlocBuilder<PayrollBloc, PayrollState>(
                    builder: (context, state) {
                      return
                          //  state.isToPayrollLoading == true
                          isDataLoading
                              ? myLoadingScreen
                              : timeRecordData == null
                                  ? SizedBox(
                                      width: 878,
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Column(
                                            children: [
                                              const Gap(4),
                                              Transform.rotate(
                                                  angle: (3.14159 / 2) * 3,
                                                  child: Icon(
                                                    Icons.double_arrow_rounded,
                                                    color: Colors.grey[600],
                                                  )),
                                              const TextThai(
                                                  text: "เรียกดูข้อมูลพนักงาน"),
                                            ],
                                          )))
                                  : Card(
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: PaginatedDataTable(
                                            columnSpacing: 15,
                                            showFirstLastButtons: true,
                                            rowsPerPage: rowIndex,
                                            availableRowsPerPage: const [
                                              5,
                                              10,
                                              20
                                            ],
                                            sortColumnIndex: sortColumnIndex,
                                            sortAscending: sort,
                                            onRowsPerPageChanged: (value) {
                                              setState(() {
                                                rowIndex = value!;
                                              });
                                            },
                                            columns: [
                                              const DataColumn(
                                                  numeric: false,
                                                  label: Text("Details")),
                                              DataColumn(
                                                  numeric: true,
                                                  label: const Text("Emp. ID"),
                                                  onSort:
                                                      (columnIndex, ascending) {
                                                    onSearchColumn(
                                                        columnIndex, ascending);
                                                  }),
                                              DataColumn(
                                                  label: const Text("Dept."),
                                                  onSort:
                                                      (columnIndex, ascending) {
                                                    onSearchColumn(
                                                        columnIndex, ascending);
                                                  }),
                                              DataColumn(
                                                  label:
                                                      const Text("Firstname"),
                                                  onSort:
                                                      (columnIndex, ascending) {
                                                    onSearchColumn(
                                                        columnIndex, ascending);
                                                  }),
                                              const DataColumn(
                                                  label: Text("Lastname")),
                                              const DataColumn(
                                                  label: Text("Position")),
                                              DataColumn(
                                                  label: const Text("Type"),
                                                  onSort:
                                                      (columnIndex, ascending) {
                                                    onSearchColumn(
                                                        columnIndex, ascending);
                                                  }),
                                              const DataColumn(
                                                  numeric: true,
                                                  label: Text("Workdate")),
                                              const DataColumn(
                                                  numeric: true,
                                                  label: Text("Holiday")),
                                              const DataColumn(
                                                  numeric: true,
                                                  label: Text("OT normal")),
                                              const DataColumn(
                                                  numeric: true,
                                                  label: Text("OT holiday")),
                                              const DataColumn(
                                                  numeric: true,
                                                  label: Text("Foodallowance")),
                                            ],
                                            source: PersonDataTableSource(
                                              filterData,
                                              context,
                                              startDate.text,
                                              finishDate.text,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                    },
                  ),
                ),
                // BlocBuilder<PayrollBloc, PayrollState>(
                //   builder: (context, state) {
                //     return isDataLoading
                //         ? Container()
                //         : timeRecordData == null
                //             ? Container()
                //             : menuCount(timeRecordData?.timeRecordData ?? []);
                //   },
                // ),
                const Gap(20)
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: menuCounttest(),
        ),
      ),
    );
  }
}

class PersonDataTableSource extends DataTableSource {
  final BuildContext context;
  List<TimeRecordDatum>? data;
  final String startDate;
  final String finishDate;

  PersonDataTableSource(
      this.data, this.context, this.startDate, this.finishDate);
  TextEditingController comment = TextEditingController();

  getDataEmployee(TimeRecordDatum data) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Padding(
            padding: const EdgeInsets.all(30),
            child: Card(
                color: mygreycolors,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: EmpDetailTable(
                  wDate: data.nWorkDate,
                  empData: data,
                  startDate: startDate,
                  finishDate: finishDate,
                )),
          );
        });
  }

  @override
  DataRow getRow(int index) {
    final d = data![index];
    return DataRow(
        color:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          return index % 2 == 0 ? Colors.white : myrowscolors;
        }),
        cells: [
          DataCell(Center(
            child: SizedBox(
                height: 38,
                width: 38,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: mygreycolors),
                    onPressed: () {
                      getDataEmployee(d);
                    },
                    child: Icon(
                      Icons.assignment,
                      color: mythemecolor,
                    ))),
          )),
          DataCell(Text(d.employeeId)),
          DataCell(Text(d.departmentName)),
          DataCell(Text(d.firstName)),
          DataCell(Text(d.lastName)),
          DataCell(Text(d.positionName)),
          DataCell(Text(d.staffType)),
          DataCell(Text(d.nWorkDate)),
          DataCell(Text(d.workHoliday ?? "0")),
          DataCell(Text(d.normalOt ?? "0")),
          DataCell(Text(d.holidayOt ?? "0")),
          DataCell(Text(d.foodAllowance)),
        ]);
  }

  @override
  int get rowCount => data?.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class MyCard extends StatelessWidget {
  final String headerText;
  final String number;
  final String unitText;
  final bool typeCount;
  const MyCard({
    Key? key,
    required this.headerText,
    required this.number,
    required this.unitText,
    required this.typeCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 100,
            child: Column(
              children: [
                TextThai(text: headerText),
                Expanded(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          number,
                          style: TextStyle(
                              fontSize: typeCount ? 18 : 20,
                              fontWeight: FontWeight.bold),
                        ))),
                Divider(
                  color: Colors.grey[400],
                  height: 10,
                  thickness: 1,
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: TextThai(
                      text: unitText,
                      textStyle: const TextStyle(color: Colors.grey),
                    )),
              ],
            ),
          ),
        ));
  }
}
