import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/payroll/3_salary/salary_management_menu.dart';
import 'package:hris_app_prototype/src/component/payroll/5_payroll/payroll_details.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/organization/organization/dropdown/parent_org_dd_model.dart';
import 'package:hris_app_prototype/src/model/payroll/lot_management/get_lotnumber_dropdown_model.dart';
import 'package:hris_app_prototype/src/model/payroll/payroll/payroll_data_model.dart';
import 'package:hris_app_prototype/src/services/api_org_service.dart';
import 'package:hris_app_prototype/src/services/api_payroll_service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Payrollmanagement extends StatefulWidget {
  const Payrollmanagement({super.key});

  @override
  State<Payrollmanagement> createState() => _PayrollmanagementState();
}

class _PayrollmanagementState extends State<Payrollmanagement> {
  Timer? _timer;
  bool thLanguage = false;

  bool isShowFloat = false;
  //table
  bool isDataLoading = true;
  int rowIndex = 10;
  int? sortColumnIndex;
  bool sort = true;
  TextEditingController search = TextEditingController();
  bool onSearch = false;
  List<PayrollDatum> filterData = [];
  List<PayrollDatum> mainData = [];
  //upload file
  bool isuploadDSL = false;
  //Lot
  TextEditingController startDate = TextEditingController();
  TextEditingController finishDate = TextEditingController();
  GetLotNumberDropdownModel? lotNumberData;
  String? lotNumberId;
  //department
  List<OrganizationDataam> orgList = [];
  String? orgCode;
  //type
  // List<PositionTypeDatum>? positionTypeList;
  List<Item> positionTypeList = [
    Item(id: 0, name: "พนักงานทั้งหมด"),
    Item(id: 1, name: "พนักงานประจำ"),
    Item(id: 2, name: "พนักงานรายวัน/รายวันประจำ"),
  ];
  String? positionTypeId;
  //employee type
  int isSendData = 0; //0 defualt 1 send  2 completelock
  //sso
  int ssoPercent = 0;
  double ssoMin = 0;
  double ssoMax = 0;
  double ssoMinSalary = 0;
  double ssoMaxSalary = 0;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );

    if (result != null) {
      String userEmployeeId = "";
      SharedPreferences preferences = await SharedPreferences.getInstance();
      userEmployeeId = preferences.getString("employeeId")!;
      // _filePath = result.files.single.path;
      isuploadDSL = await ApiPayrollService.uploadDSL(userEmployeeId,
          startDate.text, finishDate.text, File(result.files.single.path!));

      setState(() {
        isuploadDSL;
      });
    }
  }

  getNumberDesimal(double value) {
    String number;
    NumberFormat numberFormat = NumberFormat("#,##0.00", "en_US");
    if (value == 0) {
      number = "0";
    } else {
      number = numberFormat.format(value);
    }
    return number;
  }

  Future fetchData() async {
    lotNumberData = await ApiPayrollService.getLotNumberAll();
    orgList = await ApiOrgService.getParentOrgDropdown();
    // positionTypeList = await ApiOrgService.getPositionTypeDropdown();

    if (lotNumberData != null) {
      String maxLotMonth = '';
      for (var e in lotNumberData!.lotNumberData) {
        if (e.lotMonth.compareTo(maxLotMonth) > 0) {
          startDate.text = e.startDate;
          finishDate.text = e.finishDate;
          lotNumberId = e.lotNumberId;
          ssoPercent = e.ssoPercent;
          ssoMin = e.ssoMin;
          ssoMax = e.ssoMax;
          ssoMinSalary = e.ssoMinSalary;
          ssoMaxSalary = e.ssoMaxSalary;
          isSendData = int.parse(e.lockHr == "No data" ? "0" : e.lockHr);
        }
      }
    }

    fetchPayrollData();
    _timer = Timer.periodic(const Duration(microseconds: 1000), (timer) {
      //ตรวจสอบว่า widget ยังคงติดตั้งอยู่ก่อนเรียกใช้ setState()
      if (mounted) {}
    });
  }

  Future fetchPayrollData() async {
    setState(() => isDataLoading = true);
    PayrollDataModel? data = await ApiPayrollService.getPayrollData(
        startDate.text, finishDate.text, int.parse(positionTypeId!), orgCode);

    mainData = data?.payrollData ?? [];
    filterData = mainData;
    if (mainData.isNotEmpty) {
      isShowFloat = true;
    } else {
      isShowFloat = false;
    }
    isDataLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    positionTypeId = "0";
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  Widget lotMenu() {
    return SizedBox(
      height: 58,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: DropdownGlobal(
                  labeltext: 'Lot Number',
                  value: lotNumberId,
                  items: lotNumberData?.lotNumberData.map((e) {
                    return DropdownMenuItem<String>(
                      value: e.lotNumberId,
                      child: SizedBox(
                          width: 80, child: Text("${e.lotYear}/${e.lotMonth}")),
                    );
                  }).toList(),
                  onChanged: (newValue) async {
                    lotNumberData = await ApiPayrollService.getLotNumberAll();
                    setState(() {
                      lotNumberId = newValue.toString();
                      Iterable<LotNumberDatum> result = lotNumberData!
                          .lotNumberData
                          .where((element) => element.lotNumberId == newValue);
                      if (result.isNotEmpty) {
                        startDate.text = result.first.startDate.toString();
                        finishDate.text = result.first.finishDate.toString();
                        ssoPercent = result.first.ssoPercent;
                        ssoMin = result.first.ssoMin;
                        ssoMax = result.first.ssoMax;
                        ssoMinSalary = result.first.ssoMinSalary;
                        ssoMaxSalary = result.first.ssoMaxSalary;
                      }
                      isDataLoading = true;
                      fetchPayrollData();
                    });
                  },
                  validator: null),
            ),
            Expanded(
              flex: 3,
              child: TextFormFieldDatepickGlobal(
                  controller: startDate,
                  labelText: "Start Date",
                  validatorless: null,
                  enabled: true,
                  ontap: null),
            ),
            Expanded(
              flex: 3,
              child: TextFormFieldDatepickGlobal(
                  controller: finishDate,
                  labelText: "Finish Date",
                  validatorless: null,
                  enabled: true,
                  ontap: null),
            ),
            Expanded(
              flex: 4,
              child: DropdownGlobal(
                  labeltext: 'Employee Type',
                  value: positionTypeId,
                  items: positionTypeList.map((e) {
                    return DropdownMenuItem<String>(
                      value: e.id.toString(),
                      child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 100,
                          ),
                          child: Text(e.name)),
                    );
                  }).toList(),
                  onChanged: (newValue) async {
                    setState(() {
                      positionTypeId = newValue.toString();
                      fetchPayrollData();
                    });
                  },
                  validator: null),
            ),
            Expanded(
              flex: 5,
              child: DropdownGlobal(
                  labeltext: 'Department',
                  value: orgCode,
                  items: orgList.map((e) {
                    return DropdownMenuItem<String>(
                      value: e.organizationCode,
                      child: Container(
                          constraints: const BoxConstraints(maxWidth: 180),
                          child: Text(
                              "${e.organizationCode.split('0')[0]} : ${e.organizationName}")),
                    );
                  }).toList(),
                  onChanged: (newValue) async {
                    setState(() {
                      orgCode = newValue.toString();
                      fetchPayrollData();
                    });
                  },
                  validator: null),
            ),
          ],
        ),
      ),
    );
  }

  Widget uploadMenu() {
    return Row(
      children: [
        const Text(
          "Upload : ",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Image.asset('assets/xls.png', width: 30),
        const Gap(3),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UploadButton(
                width: 100,
                height: 32,
                text: "ไฟล์ กยศ.",
                isUploaded: isuploadDSL,
                onPressed: () => _pickFile()),
            const Gap(5),
            UploadButton(
                width: 200,
                height: 32,
                text: "ไฟล์ โบนัส / ปรับเงินเดือน",
                isUploaded: false,
                onPressed: () => _pickFile()),
          ],
        ),
        const Gap(10),
        const Text(
          "Print : ",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ButtonTableMenu(
                  width: 100,
                  height: 32,
                  text: "พิมพ์สลิป",
                  iconColor: mythemecolor,
                  isUploaded: true,
                  onPressed: () {},
                  child: const Icon(Icons.print_rounded)),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> actionBar() {
    return [
      Tooltip(
        message: "Search ( Employee ID , Staff Type , Name , Salary )",
        child: SizedBox(
          width: 280,
          height: 44,
          child: TextFormFieldSearch(
            prefixIcon: const Icon(Icons.search_rounded),
            hintText: "Search (ENG/TH)",
            controller: search,
            readOnly: false,
            enabled: true,
            onChanged: (value) {
              if (value == '') {
                setState(() {
                  onSearch = false;
                  filterData = mainData;
                });
              } else {
                setState(() {
                  onSearch = true;
                  filterData = mainData.where((e) {
                    final id = e.employeeId
                        .toString()
                        .toLowerCase()
                        .contains(value.toLowerCase());
                    final type = e.staffType
                        .toString()
                        .toLowerCase()
                        .contains(value.toLowerCase());
                    final firstname = e.firstName
                        .toString()
                        .toLowerCase()
                        .contains(value.toLowerCase());
                    final lastname = e.lastName
                        .toString()
                        .toLowerCase()
                        .contains(value.toLowerCase());
                    final salary = e.salary
                        .toString()
                        .toLowerCase()
                        .contains(value.toLowerCase());
                    final wage = e.wage
                        .toString()
                        .toLowerCase()
                        .contains(value.toLowerCase());
                    return id ||
                        type ||
                        firstname ||
                        lastname ||
                        salary ||
                        wage;
                  }).toList();
                });
              }
            },
          ),
        ),
      )
    ];
  }

  Widget floatingMenu() {
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
                  child: summary(),
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

  Widget summary() {
    LotNumberDatum lot = lotNumberData!.lotNumberData
        .firstWhere((element) => element.lotNumberId == lotNumberId);
    double sumSalary = 0.0;
    double sumOt = 0.0;
    double sumExtra = 0.0;
    double sumBonus = 0.0;
    double sumShiftFee = 0.0;
    double sumAllowance = 0.0;
    double sumTotalSalary = 0.0;
    double sumLeaveExceeds = 0.0;
    double sumSso = 0.0;
    double sumTax = 0.0;
    double sumDeductWage = 0.0;
    double sumStudentLoans = 0.0;
    double sumNetSalary = 0.0;
    for (var i in mainData) {
      sumSalary += i.salary;
      sumOt += i.normalOtWage + i.holidayOtWage + i.workHolidayWage;
      sumExtra += i.extraWage;
      sumBonus += i.bonus;
      sumShiftFee += i.shiftFee;
      sumAllowance += i.allowance;
      sumTotalSalary += i.totalSalary;
      sumLeaveExceeds += i.leaveExceeds;
      sumSso += i.sso;
      sumTax += i.tax;
      sumDeductWage += i.deductWage;
      sumStudentLoans += i.studentLoans;
      sumNetSalary += i.netSalary;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Column(
            children: [
              TextThai(
                text: "Payroll  Summary. '${lot.lotYear} / ${lot.lotMonth}'",
                textStyle: const TextStyle(fontSize: 16),
              ),
              const Gap(5),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 6,
                  children: [
                    MySumCard(
                        headerText: thLanguage ? "เงินเดือน" : "Salary",
                        number: getNumberDesimal(sumSalary),
                        unitText: thLanguage ? "บาท" : "THB"),
                    MySumCard(
                        headerText: thLanguage ? "รวมค่าโอที" : "Net Ot",
                        number: getNumberDesimal(sumOt),
                        unitText: thLanguage ? "บาท" : "THB"),
                    MySumCard(
                        headerText: thLanguage ? "ค่าแรงจูงใจ" : "Motivation",
                        number: getNumberDesimal(sumShiftFee),
                        unitText: thLanguage ? "บาท" : "THB"),
                    MySumCard(
                        headerText: thLanguage ? "โบนัส" : "Bonus",
                        number: getNumberDesimal(sumBonus),
                        unitText: thLanguage ? "บาท" : "THB"),
                    MySumCard(
                        headerText: thLanguage ? "เงินพิเศษ" : "Extra",
                        number: getNumberDesimal(sumExtra),
                        unitText: thLanguage ? "บาท" : "THB"),
                    MySumCard(
                        headerText: thLanguage ? "ค่าอาหาร" : "Allowance",
                        number: getNumberDesimal(sumAllowance),
                        unitText: thLanguage ? "บาท" : "THB"),
                    MySumCard(
                        headerText: thLanguage ? "รายได้รวม" : "Total Salary",
                        number: getNumberDesimal(sumTotalSalary),
                        unitText: thLanguage ? "บาท" : "THB"),
                    MySumCard(
                        headerText: thLanguage ? "ลาเกิน" : "Leave Exc.",
                        number: getNumberDesimal(sumLeaveExceeds),
                        unitText: thLanguage ? "บาท" : "THB"),
                    MySumCard(
                        headerText: thLanguage ? "หักประกันสังคม" : "SSO",
                        number: getNumberDesimal(sumSso),
                        unitText: thLanguage ? "บาท" : "THB"),
                    MySumCard(
                        headerText: thLanguage ? "หักภาษี" : "Tax",
                        number: getNumberDesimal(sumTax),
                        unitText: thLanguage ? "บาท" : "THB"),
                    MySumCard(
                        headerText: thLanguage ? "หักเงิน" : "Deduction",
                        number: getNumberDesimal(sumDeductWage),
                        unitText: thLanguage ? "บาท" : "THB"),
                    MySumCard(
                        headerText: thLanguage ? "หัก กยศ." : "DSL",
                        number: getNumberDesimal(sumStudentLoans),
                        unitText: thLanguage ? "บาท" : "THB"),
                    MySumCard(
                        headerText: thLanguage ? "รายได้สุทธิ" : "Net Salary",
                        number: getNumberDesimal(sumNetSalary),
                        unitText: thLanguage ? "บาท" : "THB"),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
              right: 1,
              bottom: 1,
              child: Row(
                children: [
                  SizedBox(
                      height: 40,
                      width: 120,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            backgroundColor: Colors.greenAccent,
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.black87),
                          ))).animate().fade(delay: 250.ms),
                  // const Icon(
                  //   Icons.lock_rounded,
                  //   color: Colors.grey,
                  //   size: 25,
                  // ).animate().shake(delay: 250.ms),
                ],
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
      ).animate().fade(delay: const Duration(milliseconds: 220)),
    );
  }

  Widget valueTextfield(double value, String label, String? suffix) {
    TextEditingController data = TextEditingController();
    data.text = getNumberDesimal(value);
    return TextFormFieldGlobal(
      controller: data,
      labelText: label,
      enabled: false,
      suffixText: suffix ?? "บาท",
    );
  }

  Widget ssoBar() {
    ssoPercent;
    ssoMin;
    ssoMax;
    ssoMinSalary;
    ssoMaxSalary;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Gap(5),
        const TextThai(text: "ประกันสังคม :"),
        SizedBox(
            width: 80,
            child: valueTextfield(
                double.parse(ssoPercent.toString()), "เบี้ยประกัน", "%")),
        Expanded(
            flex: 1,
            child: valueTextfield(double.parse(ssoMinSalary.toString()),
                "ฐานเงินเดือนต่ำสุด", null)),
        Expanded(
            flex: 1,
            child: valueTextfield(
                double.parse(ssoMin.toString()), "หักต่ำสุด", null)),
        Expanded(
            flex: 1,
            child: valueTextfield(double.parse(ssoMaxSalary.toString()),
                "ฐานเงินเดือนสูงสุด", null)),
        Expanded(
            flex: 1,
            child: valueTextfield(
                double.parse(ssoMax.toString()), "หักสูงสุด", null))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return isDataLoading
        ? myLoadingScreen
        : Padding(
            padding: const EdgeInsets.all(12.0),
            child: Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
              floatingActionButton: floatingMenu(),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const Center(
                      child: TextThai(
                        text: "ประมวลผลข้อมูลการจ่ายเงินเดือน ( Payroll )",
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                    Row(
                      children: [
                        const Gap(14),
                        Expanded(child: lotMenu()),
                        const Gap(14),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        margin: const EdgeInsets.all(0),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: PaginatedDataTable(
                            header: uploadMenu(),
                            actions: actionBar(),
                            headingRowHeight: 45,
                            dataRowMaxHeight: 42,
                            dataRowMinHeight: 42,
                            columnSpacing: 25,
                            showFirstLastButtons: true,
                            rowsPerPage: rowIndex,
                            availableRowsPerPage: const [10, 20],
                            sortColumnIndex: sortColumnIndex,
                            sortAscending: sort,
                            onRowsPerPageChanged: (value) {
                              setState(() {
                                rowIndex = value!;
                              });
                            },
                            columns: const [
                              DataColumn(label: Text("Details")),
                              DataColumn(numeric: true, label: Text("Emp. ID")),
                              DataColumn(label: Text("Type")),
                              DataColumn(label: Text("Name")),
                              DataColumn(
                                  numeric: true, label: Text("Salary/Wage")),
                              DataColumn(
                                  numeric: true, label: Text("Workdate")),
                              DataColumn(
                                  numeric: true, label: Text("Ot-normal")),
                              DataColumn(
                                  numeric: true, label: Text("Ot-holiday")),
                              DataColumn(numeric: true, label: Text("Holiday")),
                              DataColumn(numeric: true, label: Text("Extra")),
                              DataColumn(numeric: true, label: Text("Bonus")),
                              DataColumn(
                                  numeric: true, label: Text("Motivation")),
                              DataColumn(
                                  numeric: true, label: Text("Allowance")),
                              DataColumn(
                                  numeric: true, label: Text("Total Salary")),
                              DataColumn(
                                  numeric: true, label: Text("Leave Exceeds")),
                              DataColumn(numeric: true, label: Text("SSO")),
                              DataColumn(numeric: true, label: Text("Tax")),
                              DataColumn(
                                  numeric: true, label: Text("Deduction")),
                              DataColumn(numeric: true, label: Text("DSL")),
                              DataColumn(
                                  numeric: true, label: Text("Net Salary")),
                            ],
                            source: SubDataTableSource(
                                context, filterData, fetchData),
                          ),
                        ),
                      ),
                    ),
                    const Gap(8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: ssoBar()),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class SubDataTableSource extends DataTableSource {
  final BuildContext context;
  final List<PayrollDatum>? data;
  final Function()? fetchData;

  SubDataTableSource(
    this.context,
    this.data,
    this.fetchData,
  );
  TextEditingController comment = TextEditingController();

  employeeDetail(PayrollDatum data) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 350, vertical: 20),
            child: Card(
                color: mygreycolors,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Stack(
                  children: [
                    PayrollDetailsManagement(
                      data: data,
                      fetchData: fetchData!,
                    ),
                    Positioned(
                        top: 5,
                        right: 5,
                        child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () => Navigator.pop(context),
                            child: Transform.rotate(
                                angle: (45 * 22 / 7) / 180,
                                child: Icon(
                                  Icons.add_rounded,
                                  size: 32,
                                  color: Colors.grey[700],
                                )))),
                  ],
                )),
          );
        });
  }

  @override
  DataRow getRow(int index) {
    final d = data![index];
    return DataRow(onLongPress: () => employeeDetail(d), cells: [
      DataCell(Center(
          child: SizedBox(
              height: 35,
              width: 45,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      backgroundColor: mygreycolors),
                  onPressed: () => employeeDetail(d),
                  child: Icon(Icons.assignment, color: mythemecolor))))),
      DataCell(Text(d.employeeId)),
      DataCell(Text(d.staffType)),
      DataCell(Text("${d.firstName} ${d.lastName}")),
      DataCell(Text(d.staffType == "พนักงานประจำ"
          ? d.salary.toString()
          : d.wage.toString())),
      DataCell(Text(d.workAmount.toString())),
      DataCell(Text(d.normalOtWage.toString())),
      DataCell(Text(d.holidayOtWage.toString())),
      DataCell(Text(d.workHolidayWage.toString())),
      DataCell(Text(d.extraWage.toString())),
      DataCell(Text(d.bonus.toString())),
      DataCell(Text(d.shiftFee.toString())),
      DataCell(Text(d.allowance.toString())),
      DataCell(Text(d.totalSalary.toString())),
      DataCell(Text(d.leaveExceeds.toString())),
      DataCell(Text(d.sso.toString())),
      DataCell(Text(d.tax.toString())),
      DataCell(Text(d.deductWage.toString())),
      DataCell(Text(d.studentLoans.toString())),
      DataCell(Text(d.netSalary.toString())),
    ]);
  }

  @override
  int get rowCount => data?.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class MySumCard extends StatelessWidget {
  final String headerText;
  final String number;
  final String unitText;
  const MySumCard({
    Key? key,
    required this.headerText,
    required this.number,
    required this.unitText,
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
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
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
