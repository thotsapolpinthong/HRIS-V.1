import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hris_app_prototype/src/bloc/organization_bloc/position_bloc/positions_bloc.dart';
import 'package:hris_app_prototype/src/component/Organization/positions/add/created_position.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/model/organization/position/delete_position_byid_model.dart';
import 'package:hris_app_prototype/src/model/organization/position/getpositionall_model.dart';
import 'package:hris_app_prototype/src/services/api_org_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PositionDataTable extends StatefulWidget {
  const PositionDataTable({super.key});

  @override
  State<PositionDataTable> createState() => _PositionDataTableState();
}

class _PositionDataTableState extends State<PositionDataTable> {
  List<PositionDatum>? positionData;
  List<PositionDatum>? filterData;
  TextEditingController search = TextEditingController();
  int rowIndex = 10;
  int? sortColumnIndex;
  bool sort = true;
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() {
    context.read<PositionsBloc>().add(FetchDataEvent());
  }

  void deleteData(positionId, comment) async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    DeletePositionByIdModel deldata = DeletePositionByIdModel(
      positionId: positionId,
      modifiedBy: employeeId,
      comment: comment,
    );
    setState(() {});
    bool success = await ApiOrgService.deletePositionById(deldata);
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
                success == true
                    ? 'Deleted Position Success.'
                    : 'Deleted Position Fail.',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              Text(
                success == true
                    ? 'ลบตำแหน่งงาน สำเร็จ'
                    : 'ลบตำแหน่งงาน ไม่สำเร็จ',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
      btnOkColor: success == true ? Colors.greenAccent : Colors.red,
      btnOkOnPress: () {
        setState(() {
          context.read<PositionsBloc>().add(FetchDataEvent());
        });
      },
    ).show();
  }

  onSortSearchColumn(int columnIndex, bool ascending) {
    if (sortColumnIndex == 0) {
      if (sort) {
        positionData!.sort((a, b) => a.positionId.compareTo(b.positionId));
      } else {
        positionData!.sort((a, b) => b.positionId.compareTo(a.positionId));
      }
    }
    if (sortColumnIndex == 1) {
      if (sort) {
        positionData!
            .sort((a, b) => a.positionNameTh.compareTo(b.positionNameTh));
      } else {
        positionData!
            .sort((a, b) => b.positionNameTh.compareTo(a.positionNameTh));
      }
    }
    if (sortColumnIndex == 2) {
      if (sort) {
        positionData!
            .sort((a, b) => a.positionNameEn.compareTo(b.positionNameEn));
      } else {
        positionData!
            .sort((a, b) => b.positionNameEn.compareTo(a.positionNameEn));
      }
    }
  }

  onSortColumn(int columnIndex, bool ascending) {
    if (sortColumnIndex == 0) {
      if (sort) {
        filterData!.sort((a, b) => a.positionId.compareTo(b.positionId));
      } else {
        filterData!.sort((a, b) => b.positionId.compareTo(a.positionId));
      }
    }
    if (sortColumnIndex == 1) {
      if (sort) {
        filterData!
            .sort((a, b) => a.positionNameTh.compareTo(b.positionNameTh));
      } else {
        filterData!
            .sort((a, b) => b.positionNameTh.compareTo(a.positionNameTh));
      }
    }
    if (sortColumnIndex == 2) {
      if (sort) {
        filterData!
            .sort((a, b) => a.positionNameEn.compareTo(b.positionNameEn));
      } else {
        filterData!
            .sort((a, b) => b.positionNameEn.compareTo(a.positionNameEn));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PositionsBloc, PositionsState>(
      builder: (context, state) {
        if (state.onSearchData == false) {
          positionData = state.positionModel?.positionData;
          filterData = state.positionModel?.positionData;
        } else {}
        return state.isDataLoading == true && state.positionModel == null ||
                positionData == null
            ? myLoadingScreen
            : SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: PaginatedDataTable(
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
                                      flex: 2,
                                      child: Text('Positions Table.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800))),
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          const Icon(Icons.search_rounded),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: TextFormField(
                                                controller: search,
                                                onChanged: (value) {
                                                  if (value == '') {
                                                    context
                                                        .read<PositionsBloc>()
                                                        .add(DissSearchEvent());
                                                  } else {
                                                    setState(() {
                                                      context
                                                          .read<PositionsBloc>()
                                                          .add(SearchEvent());
                                                      positionData = filterData!
                                                          .where((element) {
                                                        final nameId = element
                                                            .positionId
                                                            .toLowerCase()
                                                            .contains(value
                                                                .toLowerCase());
                                                        final nameTh = element
                                                            .positionNameTh
                                                            .toLowerCase()
                                                            .contains(value
                                                                .toLowerCase());
                                                        final nameEn = element
                                                            .positionNameEn
                                                            .toLowerCase()
                                                            .contains(value
                                                                .toLowerCase());

                                                        return nameId ||
                                                            nameEn ||
                                                            nameTh;
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
                                                            BorderRadius
                                                                .circular(8))),
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
                                  numeric: true,
                                  label: const Text('รหัสตำแหน่ง'),
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
                                  label: const Text('Position name (TH)'),
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
                                  label: const Text('Position name (EN)'),
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
                              const DataColumn(label: Text('     Status')),
                              const DataColumn(
                                  label: Text('Edit/Remove',
                                      style: TextStyle(fontSize: 16))),
                            ],
                            source: PersonDataTableSource(
                                positionData, context, fetchData, deleteData),
                          ),
                        ),
                      ),
                    ).animate().fadeIn(),
                  ),
                ),
              );
      },
    ).animate().fade(duration: 100.ms);
  }
}

class PersonDataTableSource extends DataTableSource {
  final BuildContext context;
  final List<PositionDatum>? data;
  final Function fetchFunction;
  final Function deletePerson;

  PersonDataTableSource(
      this.data, this.context, this.fetchFunction, this.deletePerson);
  TextEditingController comment = TextEditingController();
  @override
  DataRow getRow(int index) {
    final positions = data![index];
    return DataRow(cells: [
      DataCell(Text(positions.positionId)),
      DataCell(Text(positions.positionNameTh)),
      DataCell(Text(positions.positionNameEn == 'No data'
          ? ' - '
          : positions.positionNameEn)),
      DataCell(Container(
          constraints: const BoxConstraints(
              minWidth: 92, maxWidth: 92 // ความสูงขั้นต่ำที่ต้องการ
              ),
          child: positions.positionStatus == "Inactive"
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
                showEditDialog(positions);
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
                showdialogDeletePerson(positions.positionId);
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

  showEditDialog(positions) {
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
                    RichText(
                      text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            TextSpan(
                              text: 'แก้ไขตำแหน่งพนักงาน',
                              style: GoogleFonts.kanit(
                                  textStyle: const TextStyle(fontSize: 18)),
                            ),
                            const TextSpan(
                              text: ' ( Edit Position.)',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                    ),
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
                width: 420,
                height: 480,
                child: EditPositions(
                  onEdit: true,
                  positions: positions,
                ),
              ));
        });
  }

  showdialogDeletePerson(positionId) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return MyDeleteBox(
            onPressedCancel: () {
              fetchFunction;
              Navigator.pop(context);
              comment.text = '';
            },
            controller: comment,
            onPressedOk: () {
              deletePerson(positionId, comment.text);
              fetchFunction;
              Navigator.pop(context);
              comment.text = '';
            },
          );
        });
  }
}
