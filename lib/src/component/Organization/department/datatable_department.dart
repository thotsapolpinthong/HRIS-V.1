import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hris_app_prototype/src/bloc/organization_bloc/department_bloc/bloc/department_bloc.dart';
import 'package:hris_app_prototype/src/component/Organization/department/Edit_department.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/organization/department/delete_department_model.dart';
import 'package:hris_app_prototype/src/model/organization/department/get_departmen_model.dart';
import 'package:hris_app_prototype/src/services/api_org_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DepartmentDataTable extends StatefulWidget {
  const DepartmentDataTable({super.key});

  @override
  State<DepartmentDataTable> createState() => _DepartmentDataTableState();
}

class _DepartmentDataTableState extends State<DepartmentDataTable> {
  List<DepartmentDatum>? departmentData;
  List<DepartmentDatum>? filterData;
  GetAllDepartmentModel? departmentDataAll;
  TextEditingController search = TextEditingController();
  int rowIndex = 10;
  bool isLoading = true;
  int? sortColumnIndex;
  bool sort = true;
  fetchData() async {
    context.read<DepartmentBloc>().add(FetchDataEvent());
    departmentDataAll = await ApiOrgService.fetchAllDepartment();

    departmentData = departmentDataAll?.departmentData;
    isLoading = false;
    setState(() {});
  }

  void deleteData(id, comment) async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    DeleteDepartmentByIdModel deldata = DeleteDepartmentByIdModel(
      deptCode: id,
      modifiedBy: employeeId,
      comment: comment,
    );
    setState(() {});
    bool success = await ApiOrgService.deleteDepartmentById(deldata);
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
                    ? 'Deleted Department Success.'
                    : 'Deleted Department Fail.',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              Text(
                success == true ? 'ลบแผนก สำเร็จ' : 'ลบแผนก ไม่สำเร็จ',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
      btnOkColor: success == true ? Colors.greenAccent : Colors.red,
      btnOkOnPress: () {
        setState(() {
          context.read<DepartmentBloc>().add(FetchDataEvent());
        });
      },
    ).show();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
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
                    RichText(
                      text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            TextSpan(
                              text: 'เพิ่มแผนก',
                              style: GoogleFonts.kanit(
                                  textStyle: const TextStyle(fontSize: 18)),
                            ),
                            const TextSpan(
                              text: ' (Create Department.)',
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
              content: const SizedBox(
                width: 420,
                height: 300,
                child: EditDepartment(onEdit: false),
              ));
        });
  }

  onSortSearchColumn(int columnIndex, bool ascending) {
    if (sortColumnIndex == 0) {
      if (sort) {
        departmentData!.sort((a, b) => a.deptCode.compareTo(b.deptCode));
      } else {
        departmentData!.sort((a, b) => b.deptCode.compareTo(a.deptCode));
      }
    }
    if (sortColumnIndex == 1) {
      if (sort) {
        departmentData!.sort((a, b) => a.deptNameTh.compareTo(b.deptNameTh));
      } else {
        departmentData!.sort((a, b) => b.deptNameTh.compareTo(a.deptNameTh));
      }
    }
    if (sortColumnIndex == 2) {
      if (sort) {
        departmentData!.sort((a, b) => a.deptNameEn.compareTo(b.deptNameEn));
      } else {
        departmentData!.sort((a, b) => b.deptNameEn.compareTo(a.deptNameEn));
      }
    }
  }

  onSortColumn(int columnIndex, bool ascending) {
    if (sortColumnIndex == 0) {
      if (sort) {
        filterData!.sort((a, b) => a.deptCode.compareTo(b.deptCode));
      } else {
        filterData!.sort((a, b) => b.deptCode.compareTo(a.deptCode));
      }
    }
    if (sortColumnIndex == 1) {
      if (sort) {
        filterData!.sort((a, b) => a.deptNameTh.compareTo(b.deptNameTh));
      } else {
        filterData!.sort((a, b) => b.deptNameTh.compareTo(a.deptNameTh));
      }
    }
    if (sortColumnIndex == 2) {
      if (sort) {
        filterData!.sort((a, b) => a.deptNameEn.compareTo(b.deptNameEn));
      } else {
        filterData!.sort((a, b) => b.deptNameEn.compareTo(a.deptNameEn));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? myLoadingScreen
        : BlocBuilder<DepartmentBloc, DepartmentState>(
            builder: (context, state) {
              if (state.onSearchData == false || departmentData == null) {
                departmentData = state.departmentModel?.departmentData;
                filterData = state.departmentModel?.departmentData;
              } else {}
              return state.isDataLoading == true || departmentData == null
                  ? myLoadingScreen
                  : SafeArea(
                      child: Scaffold(
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.endDocked,
                      floatingActionButton: SizedBox(
                        height: 50,
                        width: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            onPressed: () {
                              showDialogCreate();
                            },
                            child: const Icon(Icons.add, size: 30)),
                      ).animate().shake(),
                      body: SizedBox(
                        height: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
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
                                                  child: Text(
                                                      'Department Table.',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .w800))),
                                              Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: TextFormFieldSearch(
                                                        controller: search,
                                                        enabled: true,
                                                        onChanged: (value) {
                                                          if (value == '') {
                                                            context
                                                                .read<
                                                                    DepartmentBloc>()
                                                                .add(
                                                                    DissSearchEvent());
                                                          } else {
                                                            setState(() {
                                                              context
                                                                  .read<
                                                                      DepartmentBloc>()
                                                                  .add(
                                                                      SearchEvent());
                                                              departmentData =
                                                                  filterData!.where(
                                                                      (element) {
                                                                final nameId = element
                                                                    .deptCode
                                                                    .toLowerCase()
                                                                    .contains(value
                                                                        .toLowerCase());
                                                                final nameTH = element
                                                                    .deptNameTh
                                                                    .toLowerCase()
                                                                    .contains(value
                                                                        .toLowerCase());
                                                                final nameEN = element
                                                                    .deptNameEn
                                                                    .toLowerCase()
                                                                    .contains(value
                                                                        .toLowerCase());

                                                                return nameId ||
                                                                    nameTH ||
                                                                    nameEN;
                                                              }).toList();
                                                            });
                                                          }
                                                        }),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        columns: [
                                          DataColumn(
                                              numeric: true,
                                              label:
                                                  const Text('รหัสแผนก (Code)'),
                                              onSort: (columnIndex, ascending) {
                                                setState(() {
                                                  sort = !sort;
                                                  sortColumnIndex = 0;
                                                  if (state.onSearchData ==
                                                      true) {
                                                    onSortSearchColumn(
                                                        columnIndex, ascending);
                                                  } else {
                                                    onSortColumn(
                                                        columnIndex, ascending);
                                                  }
                                                });
                                              }),
                                          DataColumn(
                                            label: const Text(
                                                'Department name (TH)'),
                                            onSort: (columnIndex, ascending) {
                                              setState(() {
                                                sort = !sort;
                                                sortColumnIndex = 1;
                                                if (state.onSearchData ==
                                                    true) {
                                                  onSortSearchColumn(
                                                      columnIndex, ascending);
                                                } else {
                                                  onSortColumn(
                                                      columnIndex, ascending);
                                                }
                                              });
                                            },
                                          ),
                                          DataColumn(
                                            label: const Text(
                                                'Department name (EN)'),
                                            onSort: (columnIndex, ascending) {
                                              setState(() {
                                                sort = !sort;
                                                sortColumnIndex = 2;
                                                if (state.onSearchData ==
                                                    true) {
                                                  onSortSearchColumn(
                                                      columnIndex, ascending);
                                                } else {
                                                  onSortColumn(
                                                      columnIndex, ascending);
                                                }
                                              });
                                            },
                                          ),
                                          const DataColumn(
                                              // numeric: true,
                                              label: Text('Status')),
                                          const DataColumn(
                                              // numeric: true,
                                              label: Text('Edit/Remove',
                                                  style:
                                                      TextStyle(fontSize: 16))),
                                        ],
                                        source: PersonDataTableSource(
                                            departmentData,
                                            context,
                                            fetchData,
                                            deleteData),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ).animate().fadeIn(),
                        ),
                      ).animate().fade(duration: 100.ms),
                    ));
            },
          );
  }
}

class PersonDataTableSource extends DataTableSource {
  final BuildContext context;
  final List<DepartmentDatum>? data;
  final Function fetchFunction;
  final Function delete;

  PersonDataTableSource(
      this.data, this.context, this.fetchFunction, this.delete);
  TextEditingController comment = TextEditingController();
  @override
  DataRow getRow(int index) {
    final departmentData = data![index];
    return DataRow(
        color:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          return index % 2 == 0 ? Colors.white : myrowscolors;
        }),
        cells: [
          DataCell(Text(departmentData.deptCode)),
          DataCell(Text(departmentData.deptNameTh)),
          DataCell(Text(departmentData.deptNameEn == 'No data'
              ? ' - '
              : departmentData.deptNameEn)),
          DataCell(
            Container(
                constraints: const BoxConstraints(
                    minWidth: 92, maxWidth: 92 // ความสูงขั้นต่ำที่ต้องการ
                    ),
                child: departmentData.deptStatus == "Inactive"
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
                        ))),
          ),
          DataCell(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              width: 40,
              height: 38,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[700],
                      padding: const EdgeInsets.all(1)),
                  onPressed: () {
                    showEditDialog(departmentData);
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
                    showdialogDeletePerson(departmentData.deptCode);
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
                              text: ' (Edit Department.)',
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
                height: 300,
                child: Column(
                  children: [
                    Expanded(
                        child:
                            EditDepartment(onEdit: true, departmenData: data)),
                  ],
                ),
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
              fetchFunction;
              Navigator.pop(context);
              comment.text = '';
            },
            controller: comment,
            onPressedOk: () {
              delete(id, comment.text);
              fetchFunction;
              Navigator.pop(context);
              comment.text = '';
            },
          );
        });
  }
}
