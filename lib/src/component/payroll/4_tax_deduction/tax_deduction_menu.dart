import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/payroll_bloc/bloc/payroll_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/payroll/4_tax_deduction/create_update_tax_deduction.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/payroll/tax_deduction/copy_data_tax_model.dart';
import 'package:hris_app_prototype/src/model/payroll/tax_deduction/tax_deduction_all_model.dart';
import 'package:hris_app_prototype/src/services/api_payroll_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaxDeductionManagement extends StatefulWidget {
  const TaxDeductionManagement({super.key});

  @override
  State<TaxDeductionManagement> createState() => _TaxDeductionManagementState();
}

class _TaxDeductionManagementState extends State<TaxDeductionManagement> {
  // Timer? _timer;
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
  List<int>? taxDeductionList = [];
  Future fetchData() async {
    TaxDeductionModel? data =
        await ApiPayrollService.getTaxDeductionAll(yearId!);
    setState(() {
      taxDeductionData = data?.taxDeductionData ?? [];
      filterData = taxDeductionData;
      isDataLoading = false;
    });
    // _timer = Timer.periodic(const Duration(microseconds: 1000), (timer) {
    //   //ตรวจสอบว่า widget ยังคงติดตั้งอยู่ก่อนเรียกใช้ setState()
    //   if (mounted) {

    //   }
    // });
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

  showDialogCopy() {
    String? _yearId = yearId;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(8),
              backgroundColor: mygreycolors,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: StatefulBuilder(builder: (context, setState) {
                return Stack(
                  children: [
                    SizedBox(
                        width: 260,
                        height: 180,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Gap(15),
                              DropdownGlobal(
                                  labeltext: 'Year',
                                  value: _yearId,
                                  items: yearList.map((e) {
                                    return DropdownMenuItem<String>(
                                      value: e.toString(),
                                      child: SizedBox(
                                          width: 50, child: Text(e.toString())),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _yearId = newValue.toString();
                                    });
                                  },
                                  validator: null,
                                  outlineColor: mythemecolor),
                              const Gap(5),
                              MySaveButtons(
                                text: "Submit",
                                onPressed: _yearId == null
                                    ? null
                                    : () async {
                                        String userEmployeeId = "";
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        userEmployeeId = preferences
                                            .getString("employeeId")!;
                                        try {
                                          CopyDataTaxModel updateModel =
                                              CopyDataTaxModel(
                                                  year: _yearId!,
                                                  id: taxDeductionList ?? [],
                                                  coppyBy: userEmployeeId);
                                          bool success = await ApiPayrollService
                                              .copyDataTax(updateModel);
                                          if (success) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        mygreencolors,
                                                    content: const Text(
                                                        "Copy Data complete")));
                                            Navigator.pop(context);
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        myredcolors,
                                                    content: const Text(
                                                        "Copy Data Fail")));
                                          }
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: myredcolors,
                                                  content: const Text(
                                                      "Copy Data Fail")));
                                        }
                                      },
                              )
                            ],
                          ),
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
                    const Positioned(
                        left: 15, top: 0, child: Text('Transfer Data')),
                  ],
                );
              }));
        });
  }

  @override
  void initState() {
    super.initState();
    yearList = [for (int i = currentYear - 20; i <= currentYear + 5; i++) i];
    fetchData();
  }

  @override
  void deactivate() {
    super.deactivate();
    context
        .read<PayrollBloc>()
        .add(SelectTaxDeductionListEvent(taxDeductionList: const []));
  }

  @override
  void dispose() {
    super.dispose();

    // _timer?.cancel();
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
          const Text('Tax Deduction Management.',
              style: TextStyle(fontWeight: FontWeight.w800)),
          const Gap(10),
          SizedBox(
            width: 110,
            child: DropdownGlobal(
                labeltext: 'Year',
                value: yearId,
                items: yearList.map((e) {
                  return DropdownMenuItem<String>(
                    value: e.toString(),
                    child: SizedBox(width: 50, child: Text(e.toString())),
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
                outlineColor: mythemecolor),
          ),
          Expanded(child: Container()),
          Expanded(
              flex: 2,
              child: Row(
                children: [
                  BlocBuilder<PayrollBloc, PayrollState>(
                    builder: (context, state) {
                      taxDeductionList = state.taxDeductionList ?? [];
                      return UploadButton(
                          width: 110,
                          height: 32,
                          text: "Copy data",
                          isUploaded: false,
                          backgroundColor: mygreencolors,
                          icon: Icons.copy,
                          iconColor: taxDeductionList!.isEmpty
                              ? Colors.grey[500]
                              : mygreycolors,
                          textColor: taxDeductionList!.isEmpty
                              ? Colors.grey[600]
                              : mygreycolors,
                          onPressed: taxDeductionList!.isEmpty
                              ? null
                              : () => showDialogCopy());
                    },
                  ),
                  const Gap(5),
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
                            checkboxHorizontalMargin: 0,
                            showCheckboxColumn: true,
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
  List<int> selectedRows = [];

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

  // เมธอดตรวจสอบว่าแถวที่กำหนด index นั้นถูกเลือกหรือไม่
  bool getRowSelected(int index) {
    // ตรวจสอบว่าแถวที่กำหนด index นั้นถูกเลือกหรือไม่
    return selectedRows.contains(index);
  }

  // เมธอดที่ใช้ในการเลือก/ยกเลิกการเลือกแถว
  toggleRowSelection(int index) {
    if (selectedRows.contains(index)) {
      selectedRows.remove(index);
    } else {
      selectedRows.add(index);
    }
  }

  List<int> taxDeductionList = [];
  @override
  DataRow getRow(int index) {
    final d = data![index];
    return DataRow(
        selected: getRowSelected(index),
        onSelectChanged: (isSelected) {
          final isAdding = isSelected != null && isSelected;
          if (isAdding == true) {
            //
            // print("add");
            taxDeductionList.add(d.id);
            //
          } else {
            // print("del");
            taxDeductionList.remove(d.id);
          }
          toggleRowSelection(index);
          context.read<PayrollBloc>().add(
              SelectTaxDeductionListEvent(taxDeductionList: taxDeductionList));
          notifyListeners();
        },
        cells: [
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
                // const Gap(5),
                // SizedBox(
                //   width: 40,
                //   height: 38,
                //   child: ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //           backgroundColor: mygreencolors,
                //           padding: const EdgeInsets.all(1)),
                //       onPressed: () {
                //         functionUpdate(d);
                //       },
                //       child: const Icon(Icons.copy_rounded)),
                // ),
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
