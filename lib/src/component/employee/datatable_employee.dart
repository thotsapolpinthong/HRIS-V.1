// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/employee_bloc/employee_bloc.dart';
import 'package:hris_app_prototype/src/bloc/timeattendance_bloc/timeattendance_bloc.dart';
import 'package:hris_app_prototype/src/bloc/trip_bloc/trip_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee/employee_menu_layout.dart';
import 'package:hris_app_prototype/src/component/payroll/3_salary/create_update_salary.dart';
import 'package:hris_app_prototype/src/component/personal/datatable_personal.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';
import 'package:hris_app_prototype/src/model/organization/organization/dropdown/parent_org_dd_model.dart';
import 'package:hris_app_prototype/src/services/api_employee_service.dart';
import 'package:hris_app_prototype/src/services/api_org_service.dart';

class DatatableEmployee extends StatefulWidget {
  final bool isSelected;
  final bool isSelectedOne;
  final String? typeSelected;
  final Function()? fetchDataTemp;
  const DatatableEmployee({
    Key? key,
    required this.isSelected,
    required this.isSelectedOne,
    this.typeSelected,
    this.fetchDataTemp,
  }) : super(key: key);

  @override
  State<DatatableEmployee> createState() => _DatatableEmployeeState();
}

class _DatatableEmployeeState extends State<DatatableEmployee> {
  List<EmployeeDatum>? employeeData;
  List<EmployeeDatum>? filterData;

  List<EmployeeDatum> selectedemployeeData = [];
  TextEditingController search = TextEditingController();
  int rowIndex = 10;
  int? sortColumnIndex;
  bool sort = true;

  List<OrganizationDataam>? orgList;
  String? orgData;

  @override
  void initState() {
    context.read<EmployeeBloc>().add(FetchDataTableEmployeeEvent());
    fetchData();
    super.initState();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future fetchData() async {
    //   GetEmployeeAllDataModel? data =
    //       await ApiEmployeeService.fetchDataTableEmployee("1");

    orgList = await ApiOrgService.getParentOrgDropdown();

    setState(() {
      orgList;
      // data;
      // employeeData = data?.employeeData;
      // filterData = data?.employeeData;
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
                  height: MediaQuery.of(context).size.height - 20,
                  child: const Column(
                    children: [
                      Expanded(
                          child: DataTablePerson(
                        employee: true,
                      )),
                    ],
                  ),
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeBloc, EmployeeState>(
      builder: (context, state) {
        if (state.onSearchData == false || employeeData == null) {
          employeeData = state.employeeAllDataModel?.employeeData;
          filterData = state.employeeAllDataModel?.employeeData;
        } else {}
        return state.isDataLoading == true && employeeData == null
            ? myLoadingScreen
            : SafeArea(
                child: Padding(
                  padding:
                      EdgeInsets.all(widget.isSelected == false ? 12.0 : 0),
                  child: Scaffold(
                      body: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SingleChildScrollView(
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: PaginatedDataTable(
                                  // onSelectAll: widget.isSelected == false
                                  //     ? null
                                  //     : (selected) {
                                  //         // // selected จะเป็น true ถ้าทุกแถวถูกเลือก, เป็น false ถ้าถูกยกเลิก
                                  //         // if (selected!) {
                                  //         //   // เลือกทุกแถว
                                  //         //   for (int i = 0;
                                  //         //       i < employeeData!.length;
                                  //         //       i++) {
                                  //         //     PersonDataTableSource
                                  //         //         .toggleRowSelection(i);
                                  //         //   }
                                  //         // } else {
                                  //         //   // ยกเลิกการเลือกทุกแถว
                                  //         //   PersonDataTableSource.clearSelection();
                                  //         // }
                                  //       },
                                  showCheckboxColumn: true,
                                  columnSpacing: 20,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Expanded(
                                            flex: 2,
                                            child: Text('Employee Management.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w800))),
                                        orgList == null
                                            ? const SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 3,
                                                ))
                                            : const Gap(3),
                                        if (widget.isSelected == true)
                                          const Icon(
                                              Icons.account_tree_rounded),
                                        const Gap(3),
                                        // if (widget.isSelected == true)
                                        Expanded(
                                          flex: 1,
                                          child: DropdownGlobal(
                                            labeltext: 'Department',
                                            value: orgData,
                                            items: orgList?.map((e) {
                                              return DropdownMenuItem<String>(
                                                value: e.organizationCode
                                                    .toString(),
                                                child: Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                            maxWidth: 190),
                                                    child: Text(
                                                        "${e.organizationCode.split('0')[0]} : ${e.organizationName}")),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              if (newValue == '') {
                                                context
                                                    .read<EmployeeBloc>()
                                                    .add(DissSearchEmpEvent());
                                              } else {
                                                setState(() {
                                                  orgData = newValue.toString();
                                                  context
                                                      .read<EmployeeBloc>()
                                                      .add(SearchEmpEvent());
                                                  employeeData = filterData!
                                                      .where((element) {
                                                    final organizationId =
                                                        element
                                                            .positionData
                                                            .organizationData
                                                            .organizationCode
                                                            .toLowerCase()
                                                            .contains(newValue
                                                                .toString()
                                                                .toLowerCase());
                                                    return organizationId;
                                                  }).toList();
                                                  employeeData;
                                                });
                                              }
                                            },
                                            suffixIcon: orgData == null
                                                ? null
                                                : IconButton(
                                                    splashRadius: 1,
                                                    onPressed: () =>
                                                        setState(() {
                                                      orgData = null;
                                                      context
                                                          .read<EmployeeBloc>()
                                                          .add(
                                                              DissSearchEmpEvent());
                                                    }),
                                                    icon: const Icon(
                                                        Icons.cancel_rounded),
                                                  ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: TextFormFieldSearch(
                                                  controller: search,
                                                  enabled: true,
                                                  onChanged: (value) {
                                                    if (value == '') {
                                                      context
                                                          .read<EmployeeBloc>()
                                                          .add(
                                                              DissSearchEmpEvent());
                                                    } else {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                EmployeeBloc>()
                                                            .add(
                                                                SearchEmpEvent());
                                                        employeeData =
                                                            filterData!.where(
                                                                (element) {
                                                          final employeeId = element
                                                              .employeeId
                                                              .toLowerCase()
                                                              .contains(value
                                                                  .toLowerCase());
                                                          final personId = element
                                                              .personData
                                                              .personId
                                                              .toLowerCase()
                                                              .contains(value
                                                                  .toLowerCase());
                                                          final fisrtNameTh = element
                                                              .personData
                                                              .fisrtNameTh
                                                              .toLowerCase()
                                                              .contains(value
                                                                  .toLowerCase());
                                                          final lastNameTh = element
                                                              .personData
                                                              .lastNameTh
                                                              .toLowerCase()
                                                              .contains(value
                                                                  .toLowerCase());
                                                          final description = element
                                                              .staffTypeData
                                                              .description
                                                              .toLowerCase()
                                                              .contains(value
                                                                  .toLowerCase());
                                                          final positionOrganizationId = element
                                                              .positionData
                                                              .positionOrganizationId
                                                              .toLowerCase()
                                                              .contains(value
                                                                  .toLowerCase());
                                                          final positionNameTh =
                                                              element
                                                                  .positionData
                                                                  .positionData
                                                                  .positionNameTh
                                                                  .toLowerCase()
                                                                  .contains(value
                                                                      .toLowerCase());

                                                          return employeeId ||
                                                              personId ||
                                                              fisrtNameTh ||
                                                              lastNameTh ||
                                                              description ||
                                                              positionOrganizationId ||
                                                              positionNameTh;
                                                        }).toList();
                                                      });
                                                    }
                                                  }),
                                            )),
                                      ],
                                    ),
                                  ),
                                  columns: [
                                    if (widget.isSelected == false)
                                      const DataColumn(
                                          label: Text("  Menu",
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    DataColumn(
                                        numeric: true,
                                        label: const Text("Employee Id"),
                                        onSort: (columnIndex, ascending) {
                                          setState(() {});
                                        }),
                                    DataColumn(
                                        label: const Text("Dept."),
                                        onSort: (columnIndex, ascending) {
                                          setState(() {});
                                        }),
                                    DataColumn(
                                        label: const Text("Firstname"),
                                        onSort: (columnIndex, ascending) {
                                          setState(() {});
                                        }),
                                    DataColumn(
                                        label: const Text("Lastname"),
                                        onSort: (columnIndex, ascending) {
                                          setState(() {});
                                        }),
                                    DataColumn(
                                        label: const Text("Type"),
                                        onSort: (columnIndex, ascending) {
                                          setState(() {});
                                        }),
                                    DataColumn(
                                        label: const Text("Position"),
                                        onSort: (columnIndex, ascending) {
                                          setState(() {});
                                        }),
                                    DataColumn(
                                        label: const Text("Startdate"),
                                        onSort: (columnIndex, ascending) {
                                          setState(() {});
                                        }),
                                    DataColumn(
                                        label: const Text("Enddate"),
                                        onSort: (columnIndex, ascending) {
                                          setState(() {});
                                        }),
                                    const DataColumn(
                                      label: Text('status'),
                                    ),
                                    if (widget.isSelected == true &&
                                        widget.isSelectedOne == true)
                                      const DataColumn(label: Text('')),
                                  ],
                                  source: PersonDataTableSource(
                                      context,
                                      employeeData,
                                      fetchData,
                                      widget.isSelected,
                                      widget.isSelectedOne,
                                      widget.typeSelected,
                                      widget.fetchDataTemp
                                      // deleteData,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      floatingActionButtonLocation: widget.isSelected == false
                          ? FloatingActionButtonLocation.endDocked
                          : FloatingActionButtonLocation.centerDocked,
                      floatingActionButton: widget.isSelected == false
                          ? Tooltip(
                              message: "Create Employee",
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(1),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12))),
                                    onPressed: () {
                                      showDialogSearch(null);
                                    },
                                    child: const Icon(
                                        Icons.person_add_alt_1_rounded,
                                        size: 30)),
                              ).animate().shake(),
                            )
                          : widget.isSelected == true &&
                                  widget.isSelectedOne == true
                              ? null
                              : SizedBox(
                                  height: 40,
                                  width: 100,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(1),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6))),
                                      onPressed: () {
                                        context
                                            .read<TimeattendanceBloc>()
                                            .add(SubmitSelectedEvent());

                                        Navigator.pop(context);
                                      },
                                      child: const Text("Submit")),
                                ).animate().shake()),
                ),
              );
      },
    );
  }
}

class PersonDataTableSource extends DataTableSource {
  final BuildContext context;
  List<EmployeeDatum>? data;
  final Function fetchFunction;
  final bool isSelected;
  final bool isSelectedOne;
  final String? typeSelected;
  final Function()? fetchDataTemp;

  PersonDataTableSource(
      this.context,
      this.data,
      this.fetchFunction,
      this.isSelected,
      this.isSelectedOne,
      this.typeSelected,
      this.fetchDataTemp);
  TextEditingController comment = TextEditingController();
  List<EmployeeDatum> selectedemployeeData = [];
  List<int> selectedRows = [];

  @override
  DataRow getRow(int index) {
    final employeeData = data![index];
    return DataRow(
        selected: getRowSelected(index),
        onSelectChanged: isSelected == false && isSelectedOne == false ||
                isSelected == true && isSelectedOne == true
            ? null
            : (isSelected) {
                final isAdding = isSelected != null && isSelected;

                // isAdding == true
                //     ? selectedemployeeData.add(employeeData)
                //     : selectedemployeeData.remove(employeeData);
                // selectedemployeeData;

                if (isAdding == true) {
                  selectedemployeeData.add(employeeData);
                } else {
                  selectedemployeeData.remove(employeeData);
                }
                context.read<TimeattendanceBloc>().add(OnSelectedTableEvent(
                    selectedemployeeData: selectedemployeeData));
                toggleRowSelection(index);
                notifyListeners();
              },
        cells: [
          if (isSelected == false)
            DataCell(ElevatedButton(
                onPressed: () {
                  editPositionOranization(employeeData);
                },
                child: const Icon(CupertinoIcons.square_list))),
          DataCell(Text(employeeData.employeeId)),
          DataCell(Text(employeeData
              .positionData.organizationData.departMentData.deptCode)),
          DataCell(Text(employeeData.personData.fisrtNameTh)),
          DataCell(Text(employeeData.personData.lastNameTh)),
          DataCell(Text(
              employeeData.positionData.positionTypeData.positionTypeNameTh ??
                  "")),

          DataCell(Text(employeeData.positionData.positionData.positionNameTh)),
          DataCell(Text(employeeData.startDate)),
          DataCell(Text(employeeData.endDate)),
          DataCell(Text(employeeData.staffStatusData.description)),
          // DataCell(Text(
          //     employeeData.positionData.organizationData.organizationCode)),
          if (isSelected == true && isSelectedOne == true)
            DataCell(ElevatedButton(
                onPressed: () {
                  if (typeSelected == "trip") {
                    context
                        .read<TripBloc>()
                        .add(SelectEmployeeEvent(employeeData: employeeData));
                    Navigator.pop(context);
                  } else if (typeSelected == "salary") {
                    context.read<EmployeeBloc>().add(
                        SelectOneEmployeeEvent(employeeData: employeeData));
                    Navigator.pop(context);
                    functionCreateSalary();
                  }
                  // else if (typeSelected == "tax") {
                  //   context.read<EmployeeBloc>().add(
                  //       SelectOneEmployeeEvent(employeeData: employeeData));
                  //   Navigator.pop(context);
                  // }
                  else {}
                },
                child: const Text("Select"))),
        ]);
  }

// // เมธอดตรวจสอบว่าแถวที่กำหนด index นั้นถูกเลือกหรือไม่
  bool getRowSelected(int index) {
    // ตรวจสอบว่าแถวที่กำหนด index นั้นถูกเลือกหรือไม่
    return selectedRows.contains(index);
  }

  // เมธอดที่ใช้ในการเลือก/ยกเลิกการเลือกแถว
  void toggleRowSelection(int index) {
    if (selectedRows.contains(index)) {
      selectedRows.remove(index);
    } else {
      selectedRows.add(index);
    }
    notifyListeners(); // แจ้งเตือนการเปลี่ยนแปลง
  }

  // เมธอดปรับปรุงข้อมูลเมื่อมีการเปลี่ยนแปลง
  void updateData(List<EmployeeDatum> newData) {
    // ปรับปรุงข้อมูลใน DataTableSource
    data = newData;
    notifyListeners(); // แจ้งเตือนการเปลี่ยนแปลง
  }

// เมธอดที่ใช้ในการยกเลิกการเลือกทั้งหมด
  void clearSelection() {
    selectedRows.clear();
    notifyListeners(); // แจ้งเตือนการเปลี่ยนแปลง
  }

  @override
  int get rowCount => data!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;

  editPositionOranization(EmployeeDatum employeeData) {
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
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
            child: Card(
                color: mygreycolors,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: EmployeeMenuLayout(employeeData: employeeData))),
          );
        });
  }

  functionCreateSalary() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: mygreycolors,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: TitleDialog(
              title: "Create Employee Salary.",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            content: SizedBox(
                width: 400,
                height: 350,
                child: EditEmployeeSalary(
                  fetchData: fetchDataTemp!,
                  onEdit: false,
                )),
          );
        });
  }
}
