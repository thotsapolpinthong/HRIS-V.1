// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/timeattendance_bloc/timeattendance_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/component/time_attendance/workdate_spacial/create_update_wd_sp.dart';
import 'package:hris_app_prototype/src/model/payroll/lot_management/get_lotnumber_dropdown_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/shift/dropdown_shift_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/workdate_spacial/wd_sp_model.dart';
import 'package:hris_app_prototype/src/services/api_payroll_service.dart';
import 'package:hris_app_prototype/src/services/api_time_attendance_service.dart';

class WorkSPTable extends StatefulWidget {
  const WorkSPTable({super.key});

  @override
  State<WorkSPTable> createState() => _WorkSPTableState();
}

class _WorkSPTableState extends State<WorkSPTable> {
  bool isLoading = false;
  //lot
  String? lotNumberId;
  GetLotNumberDropdownModel? lotNumberData;
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  //table
  int rowIndex = 10;
  int? sortColumnIndex;
  bool sort = true;
  TextEditingController search = TextEditingController();
  bool onSearch = false;
  List<WorkDateSpecialDatum> mainData = [];
//Shift Dropdown Data
  List<ShiftDatum>? shiftList;

  Future fetchDataTable() async {
    WorkdateSpaecialModel? data = await ApiTimeAtendanceService.getDataWorkSp(
        startDate.text, endDate.text);

    setState(() {
      mainData = data?.workDateSpecialData ?? [];
      isLoading = false;
    });
  }

  Future fetchLotData() async {
    //lotnumber data-------------
    lotNumberData = await ApiPayrollService.getLotNumberAll();
    shiftList = await ApiTimeAtendanceService.getShiftDropdown();
    setState(() {
      lotNumberData;
      shiftList;
      //เงื่อนไขหาเดือนล่าสุด
      if (lotNumberData != null) {
        String maxLotMonth = '';
        for (var e in lotNumberData!.lotNumberData) {
          if (e.lotMonth.compareTo(maxLotMonth) > 0) {
            startDate.text = e.startDate.substring(0, 10);
            endDate.text = e.finishDate.substring(0, 10);
            lotNumberId = e.lotNumberId;
          }
        }
      }
    });
    // ignore: use_build_context_synchronously
    context.read<TimeattendanceBloc>().add(FetchWorkdateSpacialEvent(
        startDate: startDate.text, endDate: endDate.text));
    // fetchDataTable();
  }

  createSp() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: mygreycolors,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: TitleDialog(
              title: "Create Workdate Spacial",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            content: SizedBox(
                width: 400,
                height: 300,
                child: EditWorkdateSp(
                  onEdit: false,
                  startDate: startDate.text,
                  endDate: endDate.text,
                )),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    fetchLotData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: SizedBox(
          height: 50,
          width: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              onPressed: () {
                createSp();
              },
              child: const Icon(Icons.add_rounded)),
        ),
        body: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text("Workdate Spacial Management",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              lotMenu(),
              BlocBuilder<TimeattendanceBloc, TimeattendanceState>(
                builder: (context, state) {
                  mainData = state.workSpData?.workDateSpecialData ?? [];
                  return state.isDataLoading
                      ? myLoadingScreen
                      : SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: PaginatedDataTable(
                                  // header: Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text("Workdate Spacial Management",
                                  //         style: TextStyle(
                                  //             fontSize: 20,
                                  //             fontWeight: FontWeight.bold)),
                                  //     lotMenu(),
                                  //   ],
                                  // ),
                                  columnSpacing: 10,
                                  showFirstLastButtons: true,
                                  rowsPerPage: rowIndex,
                                  availableRowsPerPage: const [5, 10, 20],
                                  sortColumnIndex: sortColumnIndex,
                                  sortAscending: sort,
                                  onRowsPerPageChanged: (value) {
                                    setState(() {
                                      rowIndex = value!;
                                    });
                                  },
                                  columns: const [
                                    DataColumn(label: Text("Date")),
                                    DataColumn(label: Text("Shift")),
                                    DataColumn(label: Text("Time Out Spacial")),
                                    DataColumn(label: Text("Status")),
                                    DataColumn(label: Text("Edit")),
                                  ],
                                  source: MainDataTableSource(context, mainData,
                                      shiftList, startDate.text, endDate.text)),
                            ),
                          ),
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget lotMenu() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 65,
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                          isLoading = true;
                          lotNumberId = newValue.toString();
                          Iterable<LotNumberDatum> result =
                              lotNumberData!.lotNumberData.where(
                                  (element) => element.lotNumberId == newValue);
                          if (result.isNotEmpty) {
                            startDate.text =
                                result.first.startDate.substring(0, 10);
                            endDate.text =
                                result.first.finishDate.substring(0, 10);
                          }
                          if (mainData != []) {
                            // fetchDataTable();
                            context.read<TimeattendanceBloc>().add(
                                FetchWorkdateSpacialEvent(
                                    startDate: startDate.text,
                                    endDate: endDate.text));
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
                      controller: endDate,
                      labelText: "Finish Date",
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
                        // fetchDataTable();
                        context.read<TimeattendanceBloc>().add(
                            FetchWorkdateSpacialEvent(
                                startDate: startDate.text,
                                endDate: endDate.text));
                      },
                      child: Icon(
                        Icons.manage_search_rounded,
                        size: 30,
                        color: mygreycolors,
                      )),
                ),
                const Gap(4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainDataTableSource extends DataTableSource {
  final BuildContext context;
  final List<WorkDateSpecialDatum>? data;
  final List<ShiftDatum>? shiftList;
  final String startDate;
  final String endDate;
  MainDataTableSource(
    this.context,
    this.data,
    this.shiftList,
    this.startDate,
    this.endDate,
  );

  editSp(var data) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: mygreycolors,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: TitleDialog(
              title: "Edit Workdate Spacial",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            content: SizedBox(
                width: 400,
                height: 300,
                child: EditWorkdateSp(
                    onEdit: true,
                    data: data,
                    startDate: startDate,
                    endDate: endDate)),
          );
        });
  }

  @override
  DataRow getRow(int index) {
    final d = data![index];
    ShiftDatum? e = shiftList
        ?.firstWhere((element) => element.shiftId == d.shiftId.toString());
    return DataRow(
        color:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          return index % 2 == 0 ? Colors.white : Colors.grey[50]!;
        }),
        cells: [
          DataCell(Text(d.date.toIso8601String().split('T')[0])),
          DataCell(Text(
              "${e?.shiftName ?? ""} ${e?.startTime ?? ""} - ${e?.endTime ?? ""}")),
          DataCell(Text(d.endTime)),
          DataCell(SizedBox(
              width: 92,
              child: Card(
                  elevation: 2,
                  color: !d.status ? Colors.redAccent : Colors.greenAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          !d.status ? Icons.cancel : Icons.check_circle,
                          color: Colors.white,
                          size: 18,
                        ),
                        Text(
                          !d.status ? 'Inactive' : 'Active',
                          style: TextStyle(
                              color:
                                  !d.status ? Colors.white : Colors.grey[800]),
                        )
                      ],
                    ),
                  )))),
          DataCell(
            SizedBox(
              width: 40,
              height: 38,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[700],
                      padding: const EdgeInsets.all(1)),
                  onPressed: () {
                    editSp(d);
                  },
                  child: const Icon(Icons.edit)),
            ),
          ),
        ]);
  }

  @override
  int get rowCount => data?.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
