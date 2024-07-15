// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  //data
  List<EmployeeSalaryDatum> salaryData = [];
  String roleType = "admin";
  List<Item> staffType = [
    Item(id: 1, name: "พนักงานประจำ"),
    Item(id: 2, name: "พนักงานรายวัน"),
  ];
  String? staffId;

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
                      right: 0,
                      top: -5,
                      child: InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () => Navigator.pop(context),
                          child: Transform.rotate(
                              angle: (45 * 22 / 7) / 180,
                              child: Icon(
                                Icons.add_rounded,
                                size: 32,
                                color: Colors.grey[700],
                              )))),
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return isDataLoading
        ? myLoadingScreen
        : Padding(
            padding: const EdgeInsets.all(12.0),
            child: Scaffold(
              floatingActionButton: floating(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
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
                            columns: const [
                              DataColumn(label: Text("Employee ID")),
                              DataColumn(label: Text("Type")),
                              DataColumn(label: Text("FirstName")),
                              DataColumn(label: Text("LastName")),
                              DataColumn(label: Text("Salary (THB)")),
                              DataColumn(label: Text("wage (THB)")),
                              DataColumn(label: Text("Status")),
                              DataColumn(label: Text("Edit")),
                            ],
                            source: SubDataTableSource(
                                context, salaryData, fetchData),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget header() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          const Expanded(
              flex: 1,
              child: Text('Employee Salary Menegement.',
                  style: TextStyle(fontWeight: FontWeight.w800))),
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  if (staffId == null)
                    Tooltip(
                      message: "Please Select",
                      child: Icon(
                        Icons.error_outline_rounded,
                        color: myredcolors,
                      ),
                    ),
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
                  const Icon(Icons.search_rounded),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: search,
                        onChanged: (value) {
                          if (value == '') {
                          } else {
                            setState(() {});
                          }
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            hintText: 'Search (EN/TH)',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8))),
                      ),
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
        MyFloatingUpload(
          backgroundColor: Colors.green[500],
          onPressed: () {},
        ),
        const Gap(10),
        MyFloatingButton(
          icon: const Icon(Icons.add_rounded, size: 30),
          onPressed: () => showDialogCreate(),
        ),
      ],
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
    return DataRow(cells: [
      DataCell(Text(d.employeeId)),
      DataCell(Text(d.employeeTypeName)),
      DataCell(Text(d.firstName)),
      DataCell(Text(d.lastName)),
      DataCell(Text(d.salary.toString())),
      DataCell(Text(d.wage.toString())),
      DataCell(SizedBox(
          width: 92,
          child: Card(
              elevation: 2,
              color:
                  d.status != "active" ? Colors.redAccent : Colors.greenAccent,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      d.status != "active" ? Icons.cancel : Icons.check_circle,
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
