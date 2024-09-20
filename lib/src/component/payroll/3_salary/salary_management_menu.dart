// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee/datatable_employee.dart';
import 'package:hris_app_prototype/src/component/payroll/3_salary/create_update_salary.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/payroll/employee_salary/get_salary_all.dart';
import 'package:hris_app_prototype/src/services/api_payroll_service.dart';

class SalaryManagement extends StatefulWidget {
  const SalaryManagement({super.key});

  @override
  State<SalaryManagement> createState() => _SalaryManagementState();
}

class _SalaryManagementState extends State<SalaryManagement> {
  //table
  bool isDataLoading = false;
  int rowIndex = 10;
  int? sortColumnIndex;
  bool sort = true;
  TextEditingController search = TextEditingController();
  bool onSearch = false;
  List<EmployeeSalaryDatum> filterData = [];
  //data
  List<EmployeeSalaryDatum> salaryData = [];
  String roleType = "admin";
  List<Item> staffType = [
    Item(id: 1, name: "พนักงานประจำ"),
    Item(id: 2, name: "พนักงานรายวัน"),
  ];
  String? staffId;

  String? filePath;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );

    if (result != null) {
      setState(() {
        filePath = result.files.single.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Future fetchData() async {
    isDataLoading = true;
    EmployeeSalaryModel? data =
        await ApiPayrollService.getEmpSalaryAll(int.parse(staffId!));
    setState(() {
      salaryData = data?.employeeSalaryData ?? [];
      filterData = salaryData;
      isDataLoading = false;
    });
  }

  showDialogCreate() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(8),
              backgroundColor: mygreycolors,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Stack(
                children: [
                  SizedBox(
                      width: 1200,
                      height: MediaQuery.of(context).size.height - 20,
                      child: DatatableEmployee(
                        isSelected: true,
                        isSelectedOne: true,
                        typeSelected: "salary",
                        fetchDataTemp: fetchData,
                      )),
                  Positioned(
                      right: -5,
                      top: -5,
                      child: InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () => Navigator.pop(context),
                          child: Transform.rotate(
                              angle: (45 * 22 / 7) / 180,
                              child: Icon(
                                Icons.add_rounded,
                                size: 40,
                                color: myredcolors,
                              )))),
                ],
              ));
        });
  }

  Widget header() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: Row(
        children: [
          const Expanded(
              flex: 1,
              child: Text('Employee Salary Management.',
                  style: TextStyle(fontWeight: FontWeight.w800))),
          const Text(
            "Upload : ",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Image.asset('assets/xls.png', width: 30),
          const Gap(3),
          UploadButton(
              width: 200,
              height: 32,
              text: "ไฟล์ โบนัส / ปรับเงินเดือน",
              isUploaded: false,
              onPressed: () => _pickFile()),
          const Gap(10),
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: DropdownGlobal(
                        labeltext: 'Employee Type',
                        value: staffId,
                        items: staffType.map((e) {
                          return DropdownMenuItem<String>(
                            value: e.id.toString(),
                            child: SizedBox(width: 100, child: Text(e.name)),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            staffId = newValue.toString();
                            fetchData();
                          });
                        },
                        validator: null,
                        outlineColor: staffId == null ? myredcolors : null),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormFieldSearch(
                          controller: search,
                          enabled: true,
                          onChanged: (value) {
                            if (value == '') {
                              setState(() {
                                onSearch = true;
                                filterData = salaryData;
                              });
                            } else {
                              setState(() {
                                filterData = salaryData.where((e) {
                                  final eId = e.employeeId
                                      .toLowerCase()
                                      .contains(value.toLowerCase());
                                  final type = e.employeeTypeName
                                      .toLowerCase()
                                      .contains(value.toLowerCase());
                                  final fname = e.firstName
                                      .toLowerCase()
                                      .contains(value.toLowerCase());
                                  final lname = e.lastName
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

                                  return eId ||
                                      salary ||
                                      fname ||
                                      lname ||
                                      wage ||
                                      type;
                                }).toList();
                              });
                            }
                          }),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget floating() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // MyFloatingUpload(
        //   // backgroundColor: Colors.green[500],
        //   onPressed: () {
        //     _pickFile();
        //   },
        // ),
        // const Gap(10),
        // _filePath != null ? Text('File path: $_filePath') : const Text(""),
        MyFloatingButton(
          icon: const Icon(Icons.add_rounded, size: 30),
          onPressed: () => showDialogCreate(),
        ),
      ],
    );
  }

  onSortColumn(int columnIndex, bool ascending) {
    setState(() {
      sort = !sort;
      sortColumnIndex = columnIndex;
      switch (columnIndex) {
        case 0:
          if (sort) {
            filterData.sort((a, b) => a.employeeId.compareTo(b.employeeId));
          } else {
            filterData.sort((a, b) => b.employeeId.compareTo(a.employeeId));
          }
          break;
        case 1:
          if (sort) {
            filterData.sort(
                (a, b) => a.employeeTypeName.compareTo(b.employeeTypeName));
          } else {
            filterData.sort(
                (a, b) => b.employeeTypeName.compareTo(a.employeeTypeName));
          }
          break;
        case 2:
          if (sort) {
            filterData.sort((a, b) => a.firstName.compareTo(b.firstName));
          } else {
            filterData.sort((a, b) => b.firstName.compareTo(a.firstName));
          }
          break;
        case 3:
          if (sort) {
            filterData.sort((a, b) => a.salary.compareTo(b.salary));
          } else {
            filterData.sort((a, b) => b.salary.compareTo(a.salary));
          }
          break;
        case 4:
          if (sort) {
            filterData.sort((a, b) => a.wage.compareTo(b.wage));
          } else {
            filterData.sort((a, b) => b.wage.compareTo(a.wage));
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isDataLoading
        ? myLoadingScreen
        : Padding(
            padding: const EdgeInsets.all(12.0),
            child: Scaffold(
              body: SizedBox(
                height: double.infinity,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
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
                              header: header(),
                              actions: [floating()],
                              columns: [
                                DataColumn(
                                    label: Text("Employee ID"),
                                    onSort: (columnIndex, ascending) =>
                                        onSortColumn(columnIndex, ascending)),
                                DataColumn(
                                    label: Text("Type"),
                                    onSort: (columnIndex, ascending) =>
                                        onSortColumn(columnIndex, ascending)),
                                DataColumn(
                                    label: Text("Name"),
                                    onSort: (columnIndex, ascending) =>
                                        onSortColumn(columnIndex, ascending)),
                                DataColumn(
                                    label: Text("Salary (THB)"),
                                    onSort: (columnIndex, ascending) =>
                                        onSortColumn(columnIndex, ascending)),
                                DataColumn(
                                    label: Text("wage (THB)"),
                                    onSort: (columnIndex, ascending) =>
                                        onSortColumn(columnIndex, ascending)),
                                DataColumn(label: Text("Status")),
                                DataColumn(label: Text("Edit")),
                              ],
                              source: SubDataTableSource(
                                  context, filterData, fetchData),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}

class SubDataTableSource extends DataTableSource {
  final BuildContext context;
  final List<EmployeeSalaryDatum>? data;
  final Function()? fetchData;

  SubDataTableSource(
    this.context,
    this.data,
    this.fetchData,
  );
  TextEditingController comment = TextEditingController();

  functionUpdate(var data) {
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
                height: 380,
                child: EditEmployeeSalary(
                  fetchData: fetchData!,
                  onEdit: true,
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
          DataCell(Text(d.employeeTypeName)),
          DataCell(Text('${d.firstName} ${d.lastName}')),
          DataCell(Text(d.salary.toString())),
          DataCell(Text(d.wage.toString())),
          DataCell(SizedBox(
              width: 92,
              child: Card(
                  elevation: 2,
                  color: d.status != "active"
                      ? Colors.redAccent
                      : Colors.greenAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          d.status != "active"
                              ? Icons.cancel
                              : Icons.check_circle,
                          color: Colors.white,
                          size: 18,
                        ),
                        Text(
                          d.status != "active" ? 'Inactive' : 'Active',
                          style: TextStyle(
                              color: d.status != "active"
                                  ? Colors.white
                                  : Colors.grey[800]),
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
                      backgroundColor: myambercolors,
                      padding: const EdgeInsets.all(1)),
                  onPressed: () {
                    functionUpdate(d);
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

class Item {
  final int id;
  final String name;

  Item({required this.id, required this.name});
}
