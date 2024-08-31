import 'package:flutter/material.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/permission/role_permission/role_permission_manage.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/role_permission/role_permission/role_permission_model.dart';
import 'package:hris_app_prototype/src/model/role_permission/roles/roles_model.dart';
import 'package:hris_app_prototype/src/services/api_role_permission.dart';

class RolePermissionTable extends StatefulWidget {
  const RolePermissionTable({super.key});

  @override
  State<RolePermissionTable> createState() => _RolePermissionTableState();
}

class _RolePermissionTableState extends State<RolePermissionTable> {
  //table
  bool isDataLoading = true;
  int rowIndex = 10;
  int? sortColumnIndex;
  bool sort = true;
  TextEditingController search = TextEditingController();
  bool onSearch = false;
  List<RoleDatum> filterData = [];
  List<RoleDatum> mainData = [];

  Future fetchData() async {
    setState(() => isDataLoading = true);
    RolesModel? data = await ApiRolesService.getRolesData();
    setState(() {
      mainData = data?.roleData ?? [];
      filterData = data?.roleData ?? [];
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
                  Container(height: 600, width: 900, child: Container()
                      //  RolePermissionManage(
                      //   roleId: "",
                      // ),
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
                              header: const Text('Roles Table.',
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
                                            filterData = mainData;
                                          });
                                        } else {
                                          setState(() {
                                            onSearch = true;
                                            filterData = mainData.where((e) {
                                              final Id = e.roleId
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(
                                                      value.toLowerCase());
                                              final Name = e.roleName
                                                  .toLowerCase()
                                                  .contains(
                                                      value.toLowerCase());
                                              return Id || Name;
                                            }).toList();
                                          });
                                        }
                                      }),
                                ),
                              ],
                              columns: const [
                                DataColumn(label: Text("Roles Name")),
                                DataColumn(label: Text("Role Permissions")),
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
  final List<RoleDatum>? data;
  final Function()? fetchData;
  SubDataTableSource(this.context, this.data, this.fetchData);

  EditDialog(RoleDatum data) {
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
                      height: 600,
                      width: 900,
                      child: Container() //RolePermissionManage(roleId: ""),
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

  List<RolePermissionDatum> _rolePermissionList = [];

  fetch(String roleId) async {
    RolePermissionsModel? rolePermissionData =
        await ApiRolesService.getRolePermissionData(roleId);
    _rolePermissionList = rolePermissionData?.rolePermissionData ?? [];
    notifyListeners();
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
          DataCell(Text(d.roleName)),
          DataCell(Text('')),
        ]);
  }

  @override
  int get rowCount => data?.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
