// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/payroll_bloc/bloc/payroll_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/payroll/lot_management/get_lotnumber_dropdown_model.dart';
import 'package:hris_app_prototype/src/model/payroll/to_payroll/time_record_model.dart';
import 'package:hris_app_prototype/src/services/api_employee_self_service.dart';
import 'package:hris_app_prototype/src/services/api_payroll_service.dart';

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
  TimeRecordModel? timeRecordData;
  // List<TimeRecordDatum> timeRecordData = [];
  List<TimeRecordDatum> filterData = [];
//menu count
  bool isExpandCount = false;
  int isSendData = 0; //0 defualt 1 send  2 complete
  TextEditingController test1 = TextEditingController();
  int eTotal = 0;
  int eCount = 0;
  int eRegularCount = 0;
  int eDailyCount = 0;
  int eTempCount = 0;
  double otnCount = 0;
  double hCount = 0;
  double othCount = 0;
  double foodTotal = 0.00;
  fetchData() async {
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
            finishDate.text = e.finishDate;
            lotNumberId = e.lotNumberId;
          }
        }
      }
    });
  }

  Future fetchTimeRecord() async {
    setState(() {
      isDataLoading = true;
    });
    timeRecordData = await ApiPayrollService.getTimeRecord(
      startDate.text,
      finishDate.text,
    );

    setState(() {
      timeRecordData;
      eTotal = 0;
      eCount = 0;
      eRegularCount = 0;
      eDailyCount = 0;
      eTempCount = 0;
      otnCount = 0.00;
      hCount = 0.00;
      othCount = 0.00;
      foodTotal = 0.00;
      filterData = timeRecordData?.timeRecordData ?? [];
      if (timeRecordData?.timeRecordData != null) {
        calculate(timeRecordData!.timeRecordData);
      }
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
          break;
        case "พนักงานรายวันประจำ":
          eRegularCount++;
          break;
        case "พนักงานรายวัน":
          eDailyCount++;
          break;
        case "พนักงานรายวันชั่วคราว":
          eTempCount++;
          break;
      }
      // OT
      otnCount += double.parse(element.normalOt ?? "0");
      hCount += double.parse(element.workHoliday ?? "0");
      othCount = double.parse(element.holidayOt ?? "0");
      //ค่าอาหารกลางวัน
      double ft = double.parse(element.foodAllowance);
      foodTotal += (ft * 25);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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
                        Icon(
                          Icons.search_rounded,
                          size: 28,
                          color: Colors.grey[600],
                        ),
                        SizedBox(
                          width: 340,
                          child: TextFormFieldGlobal(
                            controller: search,
                            onChanged: (value) {},
                            labelText: "Search (TH/EN)",
                            hintText: "ค้นหาข้อมูลในตาราง",
                            enabled: true,
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
                                          columns: const [
                                            DataColumn(
                                                numeric: true,
                                                label: Text("EmployeeID")),
                                            DataColumn(label: Text("Dept")),
                                            DataColumn(
                                                label: Text("Firstname")),
                                            DataColumn(label: Text("Lastname")),
                                            DataColumn(label: Text("Position")),
                                            DataColumn(label: Text("Type")),
                                            DataColumn(
                                                numeric: true,
                                                label: Text("Workdate")),
                                            DataColumn(
                                                numeric: true,
                                                label: Text("OT normal")),
                                            DataColumn(
                                                numeric: true,
                                                label: Text("holiday")),
                                            DataColumn(
                                                numeric: true,
                                                label: Text("OT holiday")),
                                            DataColumn(
                                                numeric: true,
                                                label: Text("Foodallowance")),
                                          ],
                                          source: PersonDataTableSource(
                                              filterData, context, null, null),
                                        ),
                                      ),
                                    ),
                                  );
                      },
                    ),
                  ),
                  BlocBuilder<PayrollBloc, PayrollState>(
                    builder: (context, state) {
                      return isDataLoading
                          ? Container()
                          : timeRecordData == null
                              ? Container()
                              : menuCount(timeRecordData?.timeRecordData ?? []);
                    },
                  ),
                  const Gap(20)
                ],
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: menuCounttest()),
      ),
    );
  }

  Widget lotMenu() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Card(
        // color: Colors.amberAccent[100],
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                          startDate.text = result.first.startDate.toString();
                          finishDate.text = result.first.finishDate.toString();
                        }
                      });
                    },
                    validator: null),
              ),
              SizedBox(
                width: 250,
                child: TextFormFieldDatepickGlobal(
                    controller: startDate,
                    labelText: "วันที่เริ่มต้น",
                    validatorless: null,
                    ontap: () {}),
              ),
              SizedBox(
                width: 250,
                child: TextFormFieldDatepickGlobal(
                    controller: finishDate,
                    labelText: "วันที่สิ้นสุด",
                    validatorless: null,
                    ontap: () {}),
              ),
              const Gap(4),
              SizedBox(
                width: 45,
                height: 45,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget menuCount(List<TimeRecordDatum> timeRecordData) {
    // double workdate = double.parse(timeRecordData.)
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
                alignment: Alignment.centerLeft,
                child: MyContainerShadows(
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: MediaQuery.of(context).size.height / 2.5,
                    mainColor: mygreycolors!,
                    shadowColor1: Colors.grey.shade500,
                    shadowColor2: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GridView.count(
                        crossAxisCount: 5,
                        children: [
                          MyCard(
                              typeCount: false,
                              headerText: "พนง.ทั้งหมด",
                              number: eTotal.toString(),
                              unitText: "คน"),
                          MyCard(
                              typeCount: false,
                              headerText: "พนง.ประจำ",
                              number: eCount.toString(),
                              unitText: "คน"),
                          MyCard(
                              typeCount: false,
                              headerText: "พนง.รายวันประจำ",
                              number: eRegularCount.toString(),
                              unitText: "คน"),
                          MyCard(
                              typeCount: false,
                              headerText: "พนง.รายวัน",
                              number: eDailyCount.toString(),
                              unitText: "คน"),
                          MyCard(
                              typeCount: false,
                              headerText: "พนง.รายวันชั่วคราว",
                              number: eTempCount.toString(),
                              unitText: "คน"),
                          MyCard(
                              typeCount: true,
                              headerText: "โอทีวันทำงาน",
                              number: otnCount.toStringAsFixed(2),
                              unitText: "ชั่วโมง"),
                          MyCard(
                              typeCount: true,
                              headerText: "ทำงานวันหยุด",
                              number: hCount.toStringAsFixed(2),
                              unitText: "ชั่วโมง"),
                          MyCard(
                              typeCount: true,
                              headerText: "โอทีวันหยุด",
                              number: othCount.toStringAsFixed(2),
                              unitText: "ชั่วโมง"),
                          MyCard(
                              typeCount: true,
                              headerText: "ค่าอาหาร",
                              number: foodTotal.toString(),
                              unitText: "บาท"),
                        ],
                      ),
                    ))),
          ),
          SizedBox(
            width: 200,
            height: MediaQuery.of(context).size.height / 2.5,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () {
                  setState(() {
                    isSendData = 1;
                  });
                  Future.delayed(const Duration(seconds: 3), () {
                    setState(() {
                      isSendData = 2;
                    });
                  });
                },
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.toll_rounded),
                    Gap(5),
                    Text("Send to Payroll")
                  ],
                )),
          ),
          statusState(),
        ],
      ),
    );
  }

  Widget statusState() {
    switch (isSendData) {
      case 1:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: MyContainerShadows(
            width: MediaQuery.of(context).size.width / 5,
            height: MediaQuery.of(context).size.height / 2.5,
            mainColor: Colors.amberAccent,
            shadowColor1: Colors.grey.shade500,
            shadowColor2: Colors.white,
            child: Center(child: Text("Processing...")),
          ),
        );
      case 2:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: MyContainerShadows(
            width: MediaQuery.of(context).size.width / 5,
            height: MediaQuery.of(context).size.height / 2.5,
            mainColor: Colors.greenAccent,
            shadowColor1: Colors.grey.shade500,
            shadowColor2: Colors.white,
            child: Center(child: Text("Complete!")),
          ),
        );
      default:
        return Container();
    }
  }

  Widget menuCounttest() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          MyContainerShadows(
            height:
                isExpandCount ? MediaQuery.of(context).size.height / 2.5 : 50,
            width: isExpandCount ? MediaQuery.of(context).size.width / 2.5 : 50,
            mainColor: isExpandCount ? mygreycolors! : mythemecolor,
            shadowColor1: Colors.grey.shade500,
            shadowColor2: Colors.white,
            child: isExpandCount
                ? Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            splashColor: myredcolors,
                            onPressed: () {
                              setState(() {
                                isExpandCount = !isExpandCount;
                              });
                            },
                            icon: const Icon(Icons.close_fullscreen_rounded)),
                      ),
                      Expanded(child: Container()),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: () {}, child: const Text("Confirm")),
                          )),
                    ],
                  )
                : IconButton(
                    color: mygreycolors,
                    splashColor: myredcolors,
                    onPressed: () {
                      setState(() {
                        isExpandCount = !isExpandCount;
                      });
                    },
                    icon: const Icon(Icons.open_in_new_rounded)),
          ),
        ],
      ),
    );
  }
}

class PersonDataTableSource extends DataTableSource {
  final BuildContext context;
  List<TimeRecordDatum>? data;
  final Function? fetchFunction;
  final Function? deleteFunction;

  PersonDataTableSource(
      this.data, this.context, this.fetchFunction, this.deleteFunction);
  TextEditingController comment = TextEditingController();
  @override
  DataRow getRow(int index) {
    final d = data![index];
    return DataRow(cells: [
      DataCell(Text(d.employeeId)),
      DataCell(Text(d.departmentName)),
      DataCell(Text(d.firstName)),
      DataCell(Text(d.lastName)),
      DataCell(Text(d.positionName)),
      DataCell(Text(d.staffType)),
      DataCell(Text(d.nWorkDate)),
      DataCell(Text(d.normalOt ?? "0")),
      DataCell(Text(d.workHoliday ?? "0")),
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
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextThai(text: headerText),
              Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        number,
                        style: TextStyle(
                            fontSize: typeCount == true ? 18 : 22,
                            fontWeight: FontWeight.bold),
                      ))),
              const Gap(5),
              Align(
                  alignment: Alignment.bottomRight,
                  child: TextThai(
                    text: unitText,
                    textStyle: TextStyle(color: Colors.grey),
                  )),
            ],
          ),
        ));
  }
}
