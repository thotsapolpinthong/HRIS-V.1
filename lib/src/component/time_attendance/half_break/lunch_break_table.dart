import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_app_prototype/src/bloc/timeattendance_bloc/timeattendance_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/component/time_attendance/half_break/create_update_lb.dart';
import 'package:hris_app_prototype/src/model/payroll/lot_management/get_lotnumber_dropdown_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/lunch_break_half/get_lbh_model.dart';
import 'package:hris_app_prototype/src/services/api_payroll_service.dart';

class LunchBreakTable extends StatefulWidget {
  const LunchBreakTable({super.key});

  @override
  State<LunchBreakTable> createState() => _LunchBreakTableState();
}

class _LunchBreakTableState extends State<LunchBreakTable> {
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
  List<HalfHourLunchBreakDatum> mainData = [];

  createHb() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: mygreycolors,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: TitleDialog(
              title: "Create Lunch Break",
              onPressed: () {
                context.read<TimeattendanceBloc>().add(FetchLunchBreakHalfEvent(
                    startDate: startDate.text, endDate: endDate.text));
                Navigator.pop(context);
              },
            ),
            content: SizedBox(
                width: 400,
                height: 380,
                child: EditLunchBreak(
                  onEdit: false,
                  startDate: startDate.text,
                  endDate: endDate.text,
                )),
          );
        });
  }

  Future fetchLotData() async {
    //lotnumber data-------------
    lotNumberData = await ApiPayrollService.getLotNumberAll();
    setState(() {
      lotNumberData;
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
    context.read<TimeattendanceBloc>().add(FetchLunchBreakHalfEvent(
        startDate: startDate.text, endDate: endDate.text));
  }

  onSortColumn(int columnIndex, bool ascending) {
    switch (columnIndex) {
      case 0:
        if (sort) {
          mainData.sort((a, b) => a.employeeId.compareTo(b.employeeId));
        } else {
          mainData.sort((a, b) => b.employeeId.compareTo(a.employeeId));
        }
        break;
      case 1:
        if (sort) {
          mainData.sort((a, b) => a.startDate.compareTo(b.startDate));
        } else {
          mainData.sort((a, b) => b.startDate.compareTo(a.startDate));
        }
        break;
      case 2:
        if (sort) {
          mainData.sort((a, b) => a.endDate.compareTo(b.endDate));
        } else {
          mainData.sort((a, b) => b.endDate.compareTo(a.endDate));
        }
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLotData();
  }

  Widget lotMenu() {
    return SizedBox(
      height: 60,
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
                      // isLoading = true;
                      lotNumberId = newValue.toString();
                      Iterable<LotNumberDatum> result = lotNumberData!
                          .lotNumberData
                          .where((element) => element.lotNumberId == newValue);
                      if (result.isNotEmpty) {
                        startDate.text =
                            result.first.startDate.substring(0, 10);
                        endDate.text = result.first.finishDate.substring(0, 10);
                      }
                      if (mainData != []) {
                        // fetchDataTable();
                        context.read<TimeattendanceBloc>().add(
                            FetchLunchBreakHalfEvent(
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
                  enabled: false,
                  ontap: null),
            ),
            SizedBox(
              width: 240,
              child: TextFormFieldDatepickGlobal(
                  controller: endDate,
                  labelText: "End Date",
                  validatorless: null,
                  enabled: false,
                  ontap: null),
            ),
            // const Gap(4),
            // SizedBox(
            //   width: 45,
            //   height: 45,
            //   child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //           shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(8)),
            //           padding: const EdgeInsets.all(0)),
            //       onPressed: () {
            //         context.read<TimeattendanceBloc>().add(
            //             FetchLunchBreakHalfEvent(
            //                 startDate: startDate.text, endDate: endDate.text));
            //       },
            //       child: Icon(
            //         Icons.manage_search_rounded,
            //         size: 30,
            //         color: mygreycolors,
            //       )),
            // ),
            // const Gap(4),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Scaffold(
        // ),
        body: SizedBox(
          height: double.infinity,
          child: Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: BlocBuilder<TimeattendanceBloc, TimeattendanceState>(
              builder: (context, state) {
                mainData = state.lunchBreakData?.halfHourLunchBreakData ?? [];
                return state.isDataLoading
                    ? myLoadingScreen
                    : Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: PaginatedDataTable(
                                  header: Text("Lunch Break Management",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  actions: [
                                    lotMenu(),
                                    MyFloatingButton(
                                        onPressed: () {
                                          createHb();
                                        },
                                        icon: const Icon(Icons.add_rounded,
                                            size: 30)),
                                  ],
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
                                  columns: [
                                    DataColumn(
                                        label: Text("Employee Id"),
                                        onSort: (columnIndex, ascending) {
                                          setState(() {
                                            sort = !sort;
                                            sortColumnIndex = columnIndex;
                                            onSortColumn(
                                                columnIndex, ascending);
                                          });
                                        }),
                                    DataColumn(
                                        label: Text("Start Date"),
                                        onSort: (columnIndex, ascending) {
                                          setState(() {
                                            sort = !sort;
                                            sortColumnIndex = columnIndex;
                                            onSortColumn(
                                                columnIndex, ascending);
                                          });
                                        }),
                                    DataColumn(
                                        label: Text("End Date"),
                                        onSort: (columnIndex, ascending) {
                                          setState(() {
                                            sort = !sort;
                                            sortColumnIndex = columnIndex;
                                            onSortColumn(
                                                columnIndex, ascending);
                                          });
                                        }),
                                    DataColumn(label: Text("Status")),
                                    DataColumn(label: Text("Edit")),
                                  ],
                                  source: MainDataTableSource(context, mainData,
                                      startDate.text, endDate.text),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class MainDataTableSource extends DataTableSource {
  final BuildContext context;
  final List<HalfHourLunchBreakDatum>? data;
  final String startDate;
  final String endDate;
  MainDataTableSource(
    this.context,
    this.data,
    this.startDate,
    this.endDate,
  );

  editHb(var data) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: mygreycolors,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: TitleDialog(
              title: "Edit Lunch Break",
              onPressed: () {
                context.read<TimeattendanceBloc>().add(FetchLunchBreakHalfEvent(
                    startDate: startDate, endDate: endDate));
                Navigator.pop(context);
              },
            ),
            content: SizedBox(
                width: 400,
                height: 380,
                child: EditLunchBreak(
                  onEdit: true,
                  startDate: startDate,
                  endDate: endDate,
                  data: data,
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
          DataCell(Text(d.employeeId)),
          DataCell(Text(d.startDate.split('T')[0])),
          DataCell(Text(d.endDate.split('T')[0])),
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
                    editHb(d);
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
