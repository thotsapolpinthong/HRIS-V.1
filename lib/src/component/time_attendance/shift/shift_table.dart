import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/timeattendance_bloc/timeattendance_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/component/time_attendance/shift/create_update_shift.dart';
import 'package:hris_app_prototype/src/model/time_attendance/shift/delete_shift_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/shift/get_shift_all_model.dart';
import 'package:hris_app_prototype/src/services/api_time_attendance_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShiftDataTable extends StatefulWidget {
  const ShiftDataTable({super.key});

  @override
  State<ShiftDataTable> createState() => _ShiftDataTableState();
}

class _ShiftDataTableState extends State<ShiftDataTable> {
  List<ShiftDatum>? mainData;
  List<ShiftDatum>? filterData;
  TextEditingController search = TextEditingController();
  TextEditingController crop = TextEditingController();
  int rowIndex = 10;
  int? sortColumnIndex;
  bool sort = true;

  void deleteData(id, comment) async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    DeleteShiftModel deldata =
        DeleteShiftModel(shiftId: id, modifiedBy: employeeId, comment: comment);
    setState(() {});
    bool success = await ApiTimeAtendanceService.deleteShiftById(deldata);
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
          context.read<TimeattendanceBloc>().add(FetchDataShiftEvent());
        });
      },
    ).show();
  }

  @override
  void initState() {
    context.read<TimeattendanceBloc>().add(FetchDataShiftEvent());
    super.initState();
  }

  onSortSearchColumn(int columnIndex, bool ascending) {
    if (sortColumnIndex == 0) {
      if (sort) {
        mainData!.sort((a, b) => a.shiftName.compareTo(b.shiftName));
      } else {
        mainData!.sort((a, b) => b.shiftName.compareTo(a.shiftName));
      }
    }
    if (sortColumnIndex == 1) {
      if (sort) {
        mainData!.sort((a, b) => a.startTime.compareTo(b.startTime));
      } else {
        mainData!.sort((a, b) => b.startTime.compareTo(a.startTime));
      }
    }
    if (sortColumnIndex == 2) {
      if (sort) {
        mainData!.sort((a, b) => a.endTime.compareTo(b.endTime));
      } else {
        mainData!.sort((a, b) => b.endTime.compareTo(a.endTime));
      }
    }
  }

  onSortColumn(int columnIndex, bool ascending) {
    if (sortColumnIndex == 0) {
      if (sort) {
        filterData!.sort((a, b) => a.shiftName.compareTo(b.shiftName));
      } else {
        filterData!.sort((a, b) => b.shiftName.compareTo(a.shiftName));
      }
    }

    if (sortColumnIndex == 1) {
      if (sort) {
        filterData!.sort((a, b) => a.startTime.compareTo(b.startTime));
      } else {
        filterData!.sort((a, b) => b.startTime.compareTo(a.startTime));
      }
    }
    if (sortColumnIndex == 2) {
      if (sort) {
        filterData!.sort((a, b) => a.endTime.compareTo(b.endTime));
      } else {
        filterData!.sort((a, b) => b.endTime.compareTo(a.endTime));
      }
    }
  }

  void showDialogCreate() {
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
                    TextThai(text: 'เพิ่มกะการทำงาน (Create Shift.)'),
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
              content: const SizedBox(
                  width: 560,
                  height: 360,
                  child: CreateUpdateShift(onEdit: false)));
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeattendanceBloc, TimeattendanceState>(
      builder: (context, state) {
        if (state.onSearchData == false || mainData == null) {
          mainData = state.shiftData?.shiftData;
          filterData = state.shiftData?.shiftData;
          if (sortColumnIndex == null && mainData != null) {
            mainData!.sort((a, b) => a.startTime.compareTo(b.startTime));
            // mainData = mainData!
            //     .where((element) => element.date
            //         .toLowerCase()
            //         .contains(crop.text.toLowerCase()))
            //     .toList();
          }
        } else {}
        return Expanded(
          child: state.isDataLoading == true && mainData == null ||
                  state.shiftData == null
              ? myLoadingScreen
              : Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: PaginatedDataTable(
                          columnSpacing: 70,
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
                          header: Text('Shift setting table.',
                              style: TextStyle(fontWeight: FontWeight.w800)),
                          actions: [
                            SizedBox(
                              width: 300,
                              height: 46,
                              child: TextFormFieldSearch(
                                  controller: search,
                                  onChanged: (value) {
                                    if (value == '') {
                                      context
                                          .read<TimeattendanceBloc>()
                                          .add(DissSearchEvent());
                                    } else {
                                      setState(() {
                                        context
                                            .read<TimeattendanceBloc>()
                                            .add(SearchEvent());
                                        mainData = filterData!.where((element) {
                                          final nameId = element.shiftName
                                              .toLowerCase()
                                              .contains(value.toLowerCase());
                                          final type = element.startTime
                                              .toLowerCase()
                                              .contains(value.toLowerCase());
                                          final nameTH = element.endTime
                                              .toLowerCase()
                                              .contains(value.toLowerCase());

                                          return nameId || type || nameTH;
                                        }).toList();
                                      });
                                    }
                                  },
                                  enabled: true),
                            ),
                            Tooltip(
                              message: 'Create Shift.',
                              child: MyFloatingButton(
                                      onPressed: () {
                                        showDialogCreate();
                                      },
                                      icon: const Icon(Icons.more_time_rounded))
                                  .animate()
                                  .shake(),
                            )
                          ],
                          columns: [
                            DataColumn(
                                label: const Text('Shift Name'),
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
                                label: const Text('Time'),
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
                            // DataColumn(
                            //     numeric: true,
                            //     label: const Text('End Time'),
                            //     onSort: (columnIndex, ascending) {
                            //       setState(() {
                            //         sort = !sort;
                            //         sortColumnIndex = 2;
                            //         if (state.onSearchData == true) {
                            //           onSortSearchColumn(columnIndex, ascending);
                            //         } else {
                            //           onSortColumn(columnIndex, ascending);
                            //         }
                            //       });
                            //     }),
                            const DataColumn(label: Text('ValidFrom')),
                            const DataColumn(label: Text('EndFrom')),
                            const DataColumn(label: Text('Status')),
                            const DataColumn(label: Text('Select')),
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
  List<ShiftDatum>? data;
  final Function deleteFunction;

  PersonDataTableSource(this.data, this.context, this.deleteFunction);
  TextEditingController comment = TextEditingController();

  @override
  DataRow getRow(int index) {
    // data!.sort((a, b) => a.startTime.compareTo(b.startTime));
    final subData = data![index];

    return DataRow(cells: [
      DataCell(Text(subData.shiftName)),
      DataCell(Text("${subData.startTime}  -  ${subData.endTime}")),
      // DataCell(Text(subData.endTime)),
      DataCell(Text(subData.validFrom)),
      DataCell(Text(subData.endDate)),
      DataCell(Container(
          constraints: const BoxConstraints(
              minWidth: 90, maxWidth: 90 // ความสูงขั้นต่ำที่ต้องการ
              ),
          child: subData.shiftStatus == "Inactive"
              ? const Card(
                  elevation: 2,
                  color: Colors.redAccent,
                  child: Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.cancel,
                          color: Colors.white,
                          size: 18,
                        ),
                        Text(
                          ' Inactive',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ))
              : Card(
                  elevation: 2,
                  color: Colors.greenAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 18,
                        ),
                        Text(' Active',
                            style: TextStyle(color: Colors.grey[800]))
                      ],
                    ),
                  )))),
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
                showdialogDelete(subData.shiftId);
              },
              child: const Icon(Icons.delete_rounded)),
        ),
      ])),
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
                    const Text('แก้ไขข้อมูลกะการทำงาน (Edit Shift).'),
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
                height: 360,
                child: Column(
                  children: [
                    Expanded(
                        child: CreateUpdateShift(
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
