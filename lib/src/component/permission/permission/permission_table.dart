import 'package:flutter/material.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/permission/permission/create_update_permission.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/role_permission/permission/permission_model.dart';
import 'package:hris_app_prototype/src/services/api_role_permission.dart';

class PermissionTable extends StatefulWidget {
  const PermissionTable({super.key});

  @override
  State<PermissionTable> createState() => _PermissionTableState();
}

class _PermissionTableState extends State<PermissionTable> {
//table
  bool isDataLoading = true;
  int rowIndex = 10;
  int? sortColumnIndex;
  bool sort = true;
  TextEditingController search = TextEditingController();
  bool onSearch = false;
  List<PermissionDatum> filterData = [];
  List<PermissionDatum> mainData = [];

  Future fetchData() async {
    setState(() => isDataLoading = true);
    PermissionModel? data = await ApiRolesService.getPermissionData();
    setState(() {
      mainData = data?.permissionData ?? [];
      filterData = data?.permissionData ?? [];
      isDataLoading = false;
    });
  }

  createDialog() {
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
                  Container(
                    height: 300,
                    width: 400,
                    child: EditPermission(
                      onEdit: false,
                      fetchData: fetchData,
                    ),
                  ),
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
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return isDataLoading
        ? myLoadingScreen
        : Padding(
            padding: const EdgeInsets.fromLTRB(12, 5, 12, 12),
            child: Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
              floatingActionButton: MyFloatingButton(
                icon: const Icon(Icons.add_rounded, size: 30),
                onPressed: () => createDialog(),
              ),
              body: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SizedBox(
                            width: double.infinity,
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
                              header: const Text('Permissions Table.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w800)),
                              actions: [
                                SizedBox(
                                  width: 310,
                                  height: 42,
                                  child: TextFormFieldSearch(
                                      controller: search,
                                      enabled: true,
                                      onChanged: (value) {
                                        if (value == '') {
                                          setState(() {
                                            onSearch = false;
                                            // filterData = taxDeductionData;
                                          });
                                        } else {
                                          setState(() {
                                            // onSearch = true;
                                            // filterData = taxDeductionData.where((e) {
                                            //   final taxId = e.taxNumber
                                            //       .toString()
                                            //       .toLowerCase()
                                            //       .contains(value.toLowerCase());
                                            //   final empId = e.employeeId
                                            //       .toLowerCase()
                                            //       .contains(value.toLowerCase());
                                            //   final fName = e.firstName
                                            //       .toLowerCase()
                                            //       .contains(value.toLowerCase());
                                            //   final lName = e.lastName
                                            //       .toLowerCase()
                                            //       .contains(value.toLowerCase());
                                            //   return taxId || empId || fName || lName;
                                            // }).toList();
                                          });
                                        }
                                      }),
                                ),
                              ],
                              columns: const [
                                DataColumn(label: Text("Permission Id")),
                                DataColumn(label: Text("Permission Name")),
                              ],
                              source: SubDataTableSource(
                                  context, filterData, fetchData),
                            ),
                          ),
                        ),
                      ],
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
  final List<PermissionDatum>? data;
  final Function()? fetchData;
  SubDataTableSource(this.context, this.data, this.fetchData);

  EditDialog(PermissionDatum data) {
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
                  Container(
                    height: 300,
                    width: 400,
                    child: EditPermission(
                      onEdit: true,
                      fetchData: fetchData!,
                    ),
                  ),
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
  DataRow getRow(int index) {
    final d = data![index];
    return DataRow(
        color:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          return index % 2 == 0 ? Colors.white : Colors.green[50]!;
        }),
        cells: [
          DataCell(Text(d.permissionId)),
          DataCell(Text(d.permissionName)),
          // DataCell(
          //   SizedBox(
          //     width: 40,
          //     height: 38,
          //     child: ElevatedButton(
          //         style: ElevatedButton.styleFrom(
          //             backgroundColor: Colors.amber[700],
          //             padding: const EdgeInsets.all(1)),
          //         onPressed: () {
          //           EditDialog(d);
          //         },
          //         child: const Icon(Icons.edit)),
          //   ),
          // ),
        ]);
  }

  @override
  int get rowCount => data?.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
