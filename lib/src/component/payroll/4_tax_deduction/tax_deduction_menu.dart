import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/payroll/4_tax_deduction/create_update_tax_deduction.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/payroll/tax_deduction/tax_deduction_all_model.dart';
import 'package:hris_app_prototype/src/services/api_payroll_service.dart';

class TaxDeductionManagement extends StatefulWidget {
  const TaxDeductionManagement({super.key});

  @override
  State<TaxDeductionManagement> createState() => _TaxDeductionManagementState();
}

class _TaxDeductionManagementState extends State<TaxDeductionManagement> {
  Timer? _timer;
//table
  bool isDataLoading = true;
  int rowIndex = 10;
  int? sortColumnIndex;
  bool sort = true;
  TextEditingController search = TextEditingController();
  bool onSearch = false;
  List<TaxDeductionDatum> filterData = [];
  // dropdown year
  final int currentYear = DateTime.now().year;
  List<int> yearList = [];
  String? yearId = DateTime.now().year.toString();
  //main data
  List<TaxDeductionDatum> taxDeductionData = [];

  Future fetchData() async {
    TaxDeductionModel? data =
        await ApiPayrollService.getTaxDeductionAll(yearId!);
    _timer = Timer.periodic(const Duration(microseconds: 1000), (timer) {
      //ตรวจสอบว่า widget ยังคงติดตั้งอยู่ก่อนเรียกใช้ setState()
      if (mounted) {
        setState(() {
          taxDeductionData = data?.taxDeductionData ?? [];
          filterData = taxDeductionData;
          isDataLoading = false;
        });
      }
    });
  }

  createFormTaxDeduction() {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 20),
            child: Card(
                color: mygreycolors,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Stack(
                  children: [
                    EditTaxDeduction(
                        onEdit: false, fetchData: fetchData, yearId: yearId!),
                    Positioned(
                        top: 5,
                        right: 5,
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
                )),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    yearList = [for (int i = currentYear - 20; i <= currentYear + 5; i++) i];
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  Widget floating() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // MyFloatingUpload(
        //   backgroundColor: Colors.green[500],
        //   onPressed: () {},
        // ),
        // const Gap(10),
        MyFloatingButton(
          icon: const Icon(Icons.add_rounded, size: 30),
          onPressed: () {
            createFormTaxDeduction();
          },
        ),
      ],
    );
  }

  Widget header() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          const Expanded(
              flex: 3,
              child: Text('Tax Deduction Management.',
                  style: TextStyle(fontWeight: FontWeight.w800))),
          Expanded(
              flex: 2,
              child: Row(
                children: [
                  if (yearId == null)
                    Tooltip(
                      message: "Please Select",
                      child: Icon(
                        Icons.error_outline_rounded,
                        color: myredcolors,
                      ),
                    ),
                  Expanded(
                    flex: 1,
                    child: DropdownGlobal(
                        labeltext: 'Year',
                        value: yearId,
                        items: yearList.map((e) {
                          return DropdownMenuItem<String>(
                            value: e.toString(),
                            child:
                                SizedBox(width: 50, child: Text(e.toString())),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            yearId = newValue.toString();
                            isDataLoading = true;
                            fetchData();
                          });
                        },
                        validator: null,
                        outlineColor: yearId == null ? myredcolors : null),
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
                            setState(() {
                              onSearch = false;
                              filterData = taxDeductionData;
                            });
                          } else {
                            setState(() {
                              onSearch = true;
                              filterData = taxDeductionData.where((e) {
                                final taxId = e.taxNumber
                                    .toString()
                                    .toLowerCase()
                                    .contains(value.toLowerCase());
                                final empId = e.employeeId
                                    .toLowerCase()
                                    .contains(value.toLowerCase());
                                final fName = e.firstName
                                    .toLowerCase()
                                    .contains(value.toLowerCase());
                                final lName = e.lastName
                                    .toLowerCase()
                                    .contains(value.toLowerCase());
                                return taxId || empId || fName || lName;
                              }).toList();
                            });
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

  @override
  Widget build(BuildContext context) {
    yearList;
    return isDataLoading
        ? myLoadingScreen
        : Padding(
            padding: const EdgeInsets.all(12.0),
            child: Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
              floatingActionButton: floating(),
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
                              DataColumn(label: Text("Year")),
                              DataColumn(label: Text("Tax identification")),
                              DataColumn(label: Text("Employee ID")),
                              DataColumn(label: Text("FirstName")),
                              DataColumn(label: Text("LastName")),
                              DataColumn(label: Text("Edit")),
                            ],
                            source: SubDataTableSource(
                                context, filterData, fetchData, yearId!),
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
}

class SubDataTableSource extends DataTableSource {
  final BuildContext context;
  final List<TaxDeductionDatum>? data;
  final Function()? fetchData;
  final String yearId;
  SubDataTableSource(this.context, this.data, this.fetchData, this.yearId);
  TextEditingController comment = TextEditingController();

  functionUpdate(var data) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 20),
            child: Card(
                color: mygreycolors,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Stack(
                  children: [
                    EditTaxDeduction(
                        onEdit: true,
                        data: data,
                        fetchData: fetchData!,
                        yearId: yearId),
                    Positioned(
                        top: 5,
                        right: 5,
                        child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () => Navigator.pop(context),
                            child: Transform.rotate(
                                angle: (45 * 22 / 7) / 180,
                                child: Icon(Icons.add_rounded,
                                    size: 32, color: Colors.grey[700])))),
                  ],
                )),
          );
        });
  }

  @override
  DataRow getRow(int index) {
    final d = data![index];
    return DataRow(cells: [
      DataCell(Text(d.year)),
      DataCell(Text(d.taxNumber)),
      DataCell(Text(d.employeeId)),
      DataCell(Text(d.firstName)),
      DataCell(Text(d.lastName)),
      DataCell(
        Row(
          children: [
            SizedBox(
              width: 40,
              height: 38,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[700],
                      padding: const EdgeInsets.all(1)),
                  onPressed: () {
                    functionUpdate(d);
                  },
                  child: const Icon(Icons.edit)),
            ),
            const Gap(5),
            SizedBox(
              width: 40,
              height: 38,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: mygreencolors,
                      padding: const EdgeInsets.all(1)),
                  onPressed: () {
                    functionUpdate(d);
                  },
                  child: const Icon(Icons.copy_rounded)),
            ),
          ],
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
