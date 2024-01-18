import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/timeattendance_bloc/timeattendance_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/time_attendance/create_update_calendar.dart';
import 'package:hris_app_prototype/src/model/time_attendance/delete_holiday_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/get_holiday_data_model.dart';
import 'package:hris_app_prototype/src/services/api_time_attendance_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalendarDataTable extends StatefulWidget {
  const CalendarDataTable({super.key});

  @override
  State<CalendarDataTable> createState() => _CalendarDataTableState();
}

class _CalendarDataTableState extends State<CalendarDataTable> {
  List<HolidayDatum>? mainData;
  List<HolidayDatum>? filterData;
  TextEditingController search = TextEditingController();
  TextEditingController crop = TextEditingController();
  int rowIndex = 10;
  int? sortColumnIndex;
  bool sort = true;

  fetchData() async {
    HolidayDataModel? data =
        await ApiTimeAtendanceService.fetchDataTableEmployee();
    if (data != null) {
      setState(() {
        mainData = data.holidayData;
        filterData = data.holidayData;
        crop.text = DateTime.now().year.toString();
        mainData = mainData!
            .where((element) =>
                element.date.toLowerCase().contains(crop.text.toLowerCase()))
            .toList();
      });
    }
  }

  void deleteData(id, comment) async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    DeleteHolidayModel deldata = DeleteHolidayModel(
      holidayId: id,
      modifiedBy: employeeId,
      comment: comment,
    );
    setState(() {});
    bool success = await ApiTimeAtendanceService.deleteHolidayById(deldata);
    alertDialog(success);
  }

  alertDialog(bool success) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      width: 500,
      context: context,
      animType: AnimType.topSlide,
      dialogType: success == true ? DialogType.success : DialogType.error,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Column(
            children: [
              Text(
                success == true ? 'Deleted  Success.' : 'Deleted  Fail.',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              Text(
                success == true ? 'ลบข้อมูล สำเร็จ' : 'ลบข้อมูล ไม่สำเร็จ',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
      btnOkColor: success == true ? Colors.greenAccent : Colors.red,
      btnOkOnPress: () {
        setState(() {
          context
              .read<TimeattendanceBloc>()
              .add(FetchDataTimeAttendanceEvent());
        });
      },
    ).show();
  }

  onSortSearchColumn(int columnIndex, bool ascending) {
    if (sortColumnIndex == 0) {
      if (sort) {
        mainData!.sort((a, b) => a.date.compareTo(b.date));
      } else {
        mainData!.sort((a, b) => b.date.compareTo(a.date));
      }
    }
    if (sortColumnIndex == 1) {
      if (sort) {
        mainData!.sort((a, b) => a.holidayNameTh.compareTo(b.holidayNameTh));
      } else {
        mainData!.sort((a, b) => b.holidayNameTh.compareTo(a.holidayNameTh));
      }
    }
    if (sortColumnIndex == 2) {
      if (sort) {
        mainData!.sort((a, b) => a.holidayNameEn.compareTo(b.holidayNameEn));
      } else {
        mainData!.sort((a, b) => b.holidayNameEn.compareTo(a.holidayNameEn));
      }
    }
  }

  onSortColumn(int columnIndex, bool ascending) {
    if (sortColumnIndex == 0) {
      if (sort) {
        filterData!.sort((a, b) => a.date.compareTo(b.date));
      } else {
        filterData!.sort((a, b) => b.date.compareTo(a.date));
      }
    }

    if (sortColumnIndex == 1) {
      if (sort) {
        filterData!.sort((a, b) => a.holidayNameTh.compareTo(b.holidayNameTh));
      } else {
        filterData!.sort((a, b) => b.holidayNameTh.compareTo(a.holidayNameTh));
      }
    }
    if (sortColumnIndex == 2) {
      if (sort) {
        filterData!.sort((a, b) => a.holidayNameEn.compareTo(b.holidayNameEn));
      } else {
        filterData!.sort((a, b) => b.holidayNameEn.compareTo(a.holidayNameEn));
      }
    }
  }

  @override
  void initState() {
    // fetchData();
    context.read<TimeattendanceBloc>().add(FetchDataTimeAttendanceEvent());
    crop.text = DateTime.now().year.toString();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeattendanceBloc, TimeattendanceState>(
      builder: (context, state) {
        if (state.onSearchData == false || mainData == null) {
          mainData = state.holidayData?.holidayData;
          filterData = state.holidayData?.holidayData;
          if (mainData != null) {
            mainData = mainData!
                .where((element) => element.date
                    .toLowerCase()
                    .contains(crop.text.toLowerCase()))
                .toList();
          }
          if (sortColumnIndex == null && mainData != null) {
            mainData!.sort((a, b) => a.date.compareTo(b.date));
          }
        } else {}
        return Expanded(
          child: state.isDataLoading == true && mainData == null
              ? myLoadingScreen
              : Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: PaginatedDataTable(
                          columnSpacing: 30,
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
                          header: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Row(
                              children: [
                                const Expanded(
                                    flex: 1,
                                    child: Text('Holiday calendar table.')),
                                Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        const Text(
                                          'ระบุปี ค.ศ. ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: TextFormField(
                                              controller: crop,
                                              onChanged: (value) {
                                                if (value == '') {
                                                  // context
                                                  //     .read<
                                                  //         OrganizationBloc>()
                                                  //     .add(
                                                  //         DissSearchEvent());
                                                  setState(() {
                                                    // context
                                                    //     .read<
                                                    //         OrganizationBloc>()
                                                    //     .add(SearchEvent());
                                                    mainData = filterData!
                                                        .where((element) {
                                                      final crop = element.date
                                                          .toLowerCase()
                                                          .contains('2'
                                                              .toLowerCase());
                                                      return crop;
                                                    }).toList();
                                                  });
                                                } else {
                                                  setState(() {
                                                    // context
                                                    //     .read<
                                                    //         OrganizationBloc>()
                                                    //     .add(SearchEvent());
                                                    mainData = filterData!
                                                        .where((element) {
                                                      final crop = element.date
                                                          .toLowerCase()
                                                          .contains(value
                                                              .toLowerCase());
                                                      return crop;
                                                    }).toList();
                                                  });
                                                }
                                              },
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.all(10.0),
                                                hintText: 'Ex. "2023"',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  borderSide: BorderSide(
                                                      color: mythemecolor),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Gap(10),
                                        const Icon(Icons.search_rounded),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: TextFormField(
                                              controller: search,
                                              onChanged: (value) {
                                                if (value == '') {
                                                  context
                                                      .read<
                                                          TimeattendanceBloc>()
                                                      .add(DissSearchEvent());
                                                } else {
                                                  setState(() {
                                                    context
                                                        .read<
                                                            TimeattendanceBloc>()
                                                        .add(SearchEvent());

                                                    mainData = filterData!
                                                        .where((element) {
                                                      final date = element.date
                                                          .toLowerCase()
                                                          .contains(value
                                                              .toLowerCase());
                                                      final nameTH = element
                                                          .holidayNameTh
                                                          .toLowerCase()
                                                          .contains(value
                                                              .toLowerCase());
                                                      final nameEN = element
                                                          .holidayNameEn
                                                          .toLowerCase()
                                                          .contains(value
                                                              .toLowerCase());
                                                      return date ||
                                                          nameEN ||
                                                          nameTH;
                                                    }).toList();
                                                  });
                                                }
                                              },
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(
                                                          10.0),
                                                  hintText: 'Search (EN/TH)',
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8))),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          columns: [
                            DataColumn(
                                label: const Text('Date'),
                                onSort: (columnIndex, ascending) {
                                  setState(() {
                                    sort = !sort;
                                    sortColumnIndex = 0;
                                    if (state.onSearchData == true) {
                                      onSortSearchColumn(
                                          columnIndex, ascending);
                                    } else {
                                      onSortColumn(columnIndex, ascending);
                                    }
                                  });
                                }),
                            DataColumn(
                                label: const Text('Holiday (TH)'),
                                onSort: (columnIndex, ascending) {
                                  setState(() {
                                    sort = !sort;
                                    sortColumnIndex = 1;
                                    if (state.onSearchData == true) {
                                      onSortSearchColumn(
                                          columnIndex, ascending);
                                    } else {
                                      onSortColumn(columnIndex, ascending);
                                    }
                                  });
                                }),
                            DataColumn(
                                label: const Text('Holiday (EN)'),
                                onSort: (columnIndex, ascending) {
                                  setState(() {
                                    sort = !sort;
                                    sortColumnIndex = 2;
                                    if (state.onSearchData == true) {
                                      onSortSearchColumn(
                                          columnIndex, ascending);
                                    } else {
                                      onSortColumn(columnIndex, ascending);
                                    }
                                  });
                                }),
                            const DataColumn(
                                label: Text('วันหยุดตามประกาศบริษัท')),
                            const DataColumn(label: Text('Select')),
                            const DataColumn(label: Text('หมายเหตุ')),
                          ],
                          source: PersonDataTableSource(
                              mainData, context, deleteData),
                        ),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class PersonDataTableSource extends DataTableSource {
  final BuildContext context;
  List<HolidayDatum>? data;

  final Function deleteFunction;

  PersonDataTableSource(this.data, this.context, this.deleteFunction);
  TextEditingController comment = TextEditingController();

  @override
  DataRow getRow(int index) {
    // data!.sort((a, b) => a.date.compareTo(b.date));
    final subData = data![index];

    return DataRow(cells: [
      DataCell(Text(subData.date)),
      DataCell(Text(subData.holidayNameTh)),
      DataCell(Text(subData.holidayNameEn)),
      DataCell(subData.holidayFlag == true
          ? Icon(
              Icons.check_box_rounded,
              color: mythemecolor,
            )
          : const Icon(Icons.check_box_outline_blank_rounded)),
      DataCell(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          width: 40,
          height: 38,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[700],
                  padding: const EdgeInsets.all(1)),
              onPressed: () {
                showEditDialog(subData);
              },
              child: const Icon(Icons.edit)),
        ),
        const Gap(5),
        SizedBox(
          width: 40,
          height: 38,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[700],
                  padding: const EdgeInsets.all(1)),
              onPressed: () {
                showdialogDelete(subData.holidayId);
              },
              child: const Icon(Icons.delete_rounded)),
        ),
        // Card(
        //     elevation: 4,
        //     child: IconButton(
        //         splashRadius: 25,
        //         hoverColor: Colors.amber[50],
        //         color: Colors.amber,
        //         icon: const Icon(Icons.edit),
        //         onPressed: () {
        //           showEditDialog(subData);
        //         })),
        // Card(
        //     elevation: 4,
        //     child: IconButton(
        //         splashRadius: 25,
        //         hoverColor: Colors.red[100],
        //         color: Colors.red,
        //         icon: const Icon(Icons.delete),
        //         onPressed: () {}))
      ])),
      DataCell(Text(subData.note == "No data" ? " - " : subData.note)),
    ]);
  }

  @override
  int get rowCount => data!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;

  showEditDialog(data) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: mygreycolors,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('แก้ไขข้อมูลวันหยุด (Edit Holiday.)'),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text(
                        'X',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              content: SizedBox(
                width: 560,
                height: 600,
                child: Column(
                  children: [
                    Expanded(
                        child: CreateUpdateCalendar(
                      onEdit: true,
                      subData: data,
                    )),
                  ],
                ),
              ));
        });
  }

  showdialogDelete(id) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return MyDeleteBox(
            onPressedCancel: () {
              Navigator.pop(context);
              comment.text = '';
            },
            controller: comment,
            onPressedOk: () {
              deleteFunction(id, comment.text);

              Navigator.pop(context);
              comment.text = '';
            },
          );
        });
  }
}
