import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/organization_bloc/position_org_bloc/position_org_bloc.dart';
import 'package:hris_app_prototype/src/component/Organization/position_org/create_edit_position_org.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/personal/datatable_personal.dart';
import 'package:hris_app_prototype/src/model/organization/organization/get_org_all_model.dart';
import 'package:hris_app_prototype/src/model/organization/position_org/get_position_org_by_org_id_model.dart';

class PositionOrganizationTable extends StatefulWidget {
  final OrganizationDatum? orgdata;
  final GetPositionOrgByOrgIdModel? positionOrgData;
  const PositionOrganizationTable(
      {super.key, required this.orgdata, required this.positionOrgData});

  @override
  State<PositionOrganizationTable> createState() =>
      _PositionOrganizationTableState();
}

class _PositionOrganizationTableState extends State<PositionOrganizationTable> {
  List<PositionOrganizationDatum>? mainData;
  List<PositionOrganizationDatum>? filterData;
  TextEditingController search = TextEditingController();
  int rowIndex = 10;
  int? sortColumnIndex;
  bool sort = true;

  void deleteData(id, comment) async {
    // String employeeId = "";
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // employeeId = preferences.getString("employeeId")!;
    // DeleteOrganizationByIdModel deldata = DeleteOrganizationByIdModel(
    //   organizationId: id,
    //   modifiedBy: employeeId,
    //   comment: comment,
    // );
    // setState(() {});
    // bool success = await ApiOrgService.deleteOrganizationById(deldata);
    // alertDialog(success);
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
          context.read<PositionOrgBloc>().add(FetchDataPositionOrgEvent(
              organizationId: widget.orgdata!.organizationCode));
        });
      },
    ).show();
  }

  onSortSearchColumn(int columnIndex, bool ascending) {
    if (sortColumnIndex == 1) {
      if (sort) {
        mainData!.sort((a, b) =>
            a.positionOrganizationId.compareTo(b.positionOrganizationId));
      } else {
        mainData!.sort((a, b) =>
            b.positionOrganizationId.compareTo(a.positionOrganizationId));
      }
    }
    if (sortColumnIndex == 2) {
      if (sort) {
        mainData!.sort((a, b) => a.positionData.positionNameTh
            .compareTo(b.positionData.positionNameTh));
      } else {
        mainData!.sort((a, b) => b.positionData.positionNameTh
            .compareTo(a.positionData.positionNameTh));
      }
    }
    if (sortColumnIndex == 3) {
      if (sort) {
        mainData!.sort((a, b) => a
            .parentPositionNodeId.positionData.positionNameTh
            .compareTo(b.parentPositionNodeId.positionData.positionNameTh));
      } else {
        mainData!.sort((a, b) => b
            .parentPositionNodeId.positionData.positionNameTh
            .compareTo(a.parentPositionNodeId.positionData.positionNameTh));
      }
    }
    if (sortColumnIndex == 5) {
      if (sort) {
        mainData!.sort((a, b) =>
            a.jobTitleData.jobTitleName.compareTo(b.jobTitleData.jobTitleName));
      } else {
        mainData!.sort((a, b) =>
            b.jobTitleData.jobTitleName.compareTo(a.jobTitleData.jobTitleName));
      }
    }
  }

  onSortColumn(int columnIndex, bool ascending) {
    if (sortColumnIndex == 1) {
      if (sort) {
        filterData!.sort((a, b) =>
            a.positionOrganizationId.compareTo(b.positionOrganizationId));
      } else {
        filterData!.sort((a, b) =>
            b.positionOrganizationId.compareTo(a.positionOrganizationId));
      }
    }
    if (sortColumnIndex == 2) {
      if (sort) {
        filterData!.sort((a, b) => a.positionData.positionNameTh
            .compareTo(b.positionData.positionNameTh));
      } else {
        filterData!.sort((a, b) => b.positionData.positionNameTh
            .compareTo(a.positionData.positionNameTh));
      }
    }
    if (sortColumnIndex == 3) {
      if (sort) {
        filterData!.sort((a, b) => a
            .parentPositionNodeId.positionData.positionNameTh
            .compareTo(b.parentPositionNodeId.positionData.positionNameTh));
      } else {
        filterData!.sort((a, b) => b
            .parentPositionNodeId.positionData.positionNameTh
            .compareTo(a.parentPositionNodeId.positionData.positionNameTh));
      }
    }
    if (sortColumnIndex == 5) {
      if (sort) {
        filterData!.sort((a, b) =>
            a.jobTitleData.jobTitleName.compareTo(b.jobTitleData.jobTitleName));
      } else {
        filterData!.sort((a, b) =>
            b.jobTitleData.jobTitleName.compareTo(a.jobTitleData.jobTitleName));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PositionOrgBloc, PositionOrgState>(
      builder: (context, state) {
        if (state.onSearchData == false || mainData == null) {
          mainData = widget.positionOrgData!.positionOrganizationData;
          filterData = widget.positionOrgData!.positionOrganizationData;
        } else {}
        return SafeArea(
          child: Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 1200,
                      child: PaginatedDataTable(
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
                        header: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Row(
                            children: [
                              const Expanded(
                                  flex: 1,
                                  child: Text('Position Organizations Table.')),
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      const Icon(Icons.search_rounded),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: TextFormField(
                                            controller: search,
                                            onChanged: (value) {
                                              if (value == '') {
                                                context
                                                    .read<PositionOrgBloc>()
                                                    .add(DissSearchEvent());
                                              } else {
                                                setState(() {
                                                  context
                                                      .read<PositionOrgBloc>()
                                                      .add(SearchEvent());
                                                  mainData = filterData!
                                                      .where((element) {
                                                    final id = element
                                                        .positionOrganizationId
                                                        .toLowerCase()
                                                        .contains(value
                                                            .toLowerCase());
                                                    final name = element
                                                        .positionData
                                                        .positionNameTh
                                                        .toLowerCase()
                                                        .contains(value
                                                            .toLowerCase());
                                                    final parent = element
                                                        .parentPositionNodeId
                                                        .positionData
                                                        .positionNameTh
                                                        .toLowerCase()
                                                        .contains(value
                                                            .toLowerCase());
                                                    final job = element
                                                        .jobTitleData
                                                        .jobTitleName
                                                        .toLowerCase()
                                                        .contains(value
                                                            .toLowerCase());

                                                    return id ||
                                                        job ||
                                                        name ||
                                                        parent;
                                                  }).toList();
                                                });
                                              }
                                            },
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.all(10.0),
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
                          const DataColumn(
                              label: Text('ตัวเลือก',
                                  style: TextStyle(fontSize: 16))),
                          DataColumn(
                              numeric: true,
                              label: const Text('เลขที่โต๊ะ'),
                              onSort: (columnIndex, ascending) {
                                setState(() {
                                  sort = !sort;
                                  sortColumnIndex = 1;
                                  if (state.onSearchData == true) {
                                    onSortSearchColumn(columnIndex, ascending);
                                  } else {
                                    onSortColumn(columnIndex, ascending);
                                  }
                                });
                              }),
                          DataColumn(
                              label: const Text('ชื่อตำแหน่งงาน'),
                              onSort: (columnIndex, ascending) {
                                setState(() {
                                  sort = !sort;
                                  sortColumnIndex = 2;
                                  if (state.onSearchData == true) {
                                    onSortSearchColumn(columnIndex, ascending);
                                  } else {
                                    onSortColumn(columnIndex, ascending);
                                  }
                                });
                              }),
                          DataColumn(
                              label: const Text('ผู้บังคับบัญชา'),
                              onSort: (columnIndex, ascending) {
                                setState(() {
                                  sort = !sort;
                                  sortColumnIndex = 3;
                                  if (state.onSearchData == true) {
                                    onSortSearchColumn(columnIndex, ascending);
                                  } else {
                                    onSortColumn(columnIndex, ascending);
                                  }
                                });
                              }),
                          const DataColumn(
                            label: Text('สถานะ'),
                          ),
                          DataColumn(
                              label: const Text('รายละเอียดงาน'),
                              onSort: (columnIndex, ascending) {
                                setState(() {
                                  sort = !sort;
                                  sortColumnIndex = 5;
                                  if (state.onSearchData == true) {
                                    onSortSearchColumn(columnIndex, ascending);
                                  } else {
                                    onSortColumn(columnIndex, ascending);
                                  }
                                });
                              }),
                        ],
                        source: PersonDataTableSource(
                            widget.orgdata,
                            widget.positionOrgData,
                            mainData,
                            context,
                            deleteData,
                            widget.orgdata!.organizationCode),
                      ),
                    ),
                  ),
                ).animate().fadeIn(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PersonDataTableSource extends DataTableSource {
  final OrganizationDatum? orgdata;
  final GetPositionOrgByOrgIdModel? positionOrgDatum;
  final BuildContext context;
  List<PositionOrganizationDatum>? data;
  final Function deleteFunction;
  String? organizationCode;
  PersonDataTableSource(this.orgdata, this.positionOrgDatum, this.data,
      this.context, this.deleteFunction, this.organizationCode);
  TextEditingController comment = TextEditingController();
  @override
  DataRow getRow(int index) {
    final positionOrgData = data![index];
    return DataRow(cells: [
      DataCell(Row(
        children: [
          SizedBox(
            height: 35,
            width: 45,
            child: Tooltip(
              message: "แก้ไขโต๊ะทำงาน",
              child: ElevatedButton(
                  onPressed: () {
                    showDialogCreate(positionOrgData);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(1)),
                  child: const Icon(Icons.edit)),
            ),
          ),
          const Gap(5),
          if (positionOrgData.employeeData.employeeId == '')
            SizedBox(
              height: 35,
              width: 45,
              child: Tooltip(
                message: "ลบโต๊ะทำงาน",
                child: ElevatedButton(
                  onPressed: () {
                    // showDialogSearch(positionOrgData);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent[700],
                      padding: const EdgeInsets.all(1)),
                  child: const Icon(Icons.delete_rounded),
                ),
              ),
            ),
          const Gap(5),
          if (positionOrgData.employeeData.employeeId == '')
            SizedBox(
              height: 35,
              width: 45,
              child: Tooltip(
                message: "เพิ่มพนักงาน",
                child: ElevatedButton(
                  onPressed: () {
                    showDialogSearch(positionOrgData);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amberAccent[700],
                      padding: const EdgeInsets.all(1)),
                  child: const Icon(CupertinoIcons.person_add_solid),
                ),
              ),
            ),
        ],
      )),
      DataCell(Text(positionOrgData.positionOrganizationId)),
      DataCell(Text(positionOrgData.positionData.positionNameTh)),
      DataCell(Text(
          positionOrgData.parentPositionNodeId.positionData.positionNameTh)),
      DataCell(Text(positionOrgData.employeeData.employeeId == ""
          ? "ตำแหน่งว่าง"
          : "ปฏิบัติงาน")),
      DataCell(Text(positionOrgData.jobTitleData.jobTitleName)),
    ]);
  }

  @override
  int get rowCount => data!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;

  showDialogCreate(positionOrgData) {
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
                    const Text('เพิ่มโต๊ะทำงาน (Position Organization.)'),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[700]),
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
                width: 450,
                height: 600,
                child: EditPositionOrganization(
                    onEdit: true,
                    positionOrgData: positionOrgData,
                    orgData: orgdata,
                    ongraph: true,
                    firstNode: false),
              ));
        });
  }

  showdialogDeletePerson(id) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return MyDeleteBox(
            onPressedCancel: () {
              context.read<PositionOrgBloc>().add(FetchDataPositionOrgEvent(
                  organizationId: organizationCode.toString()));
              Navigator.pop(context);
              comment.text = '';
            },
            controller: comment,
            onPressedOk: () {
              deleteFunction(id, comment.text);
              context.read<PositionOrgBloc>().add(FetchDataPositionOrgEvent(
                  organizationId: organizationCode.toString()));
              Navigator.pop(context);
              comment.text = '';
            },
          );
        });
  }

  showDialogSearch(data) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: mygreycolors,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              content: SafeArea(
                child: SizedBox(
                  width: 1000,
                  height: 800,
                  child: Column(
                    children: [
                      Expanded(
                          child: DataTablePerson(
                        employee: true,
                        positionOrgData: data,
                      )),
                    ],
                  ),
                ),
              ));
        });
  }
}
