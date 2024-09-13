// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/role_permission/permission/permission_model.dart';
import 'package:hris_app_prototype/src/model/role_permission/role_permission/assign_role_permission_model.dart';
import 'package:hris_app_prototype/src/model/role_permission/role_permission/edit_role_permission.dart';
import 'package:hris_app_prototype/src/model/role_permission/role_permission/role_permission_model.dart';
import 'package:hris_app_prototype/src/model/role_permission/roles/roles_model.dart';
import 'package:hris_app_prototype/src/services/api_role_permission.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class RolePermissionManage extends StatefulWidget {
  const RolePermissionManage({super.key});

  @override
  State<RolePermissionManage> createState() => _RolePermissionManageState();
}

class _RolePermissionManageState extends State<RolePermissionManage> {
  bool _isDataLoading = true;
  bool _isPermissionLoading = true;

  int? _selectedIndex;
  bool onEdit = true;
  bool onSendData = true;
  //permission
  List<PermissionDatum> _permissionData = [];
  // List<CheckBoxData> _checkBoxData = [];
  List<RolePermissionAssing> _permissionsAssign = [];
  List<String> _permissionsName = [];
  //roles
  List<RoleDatum> _rolesData = [];
  String? _rolesSelectedName;
  String? _rolesSelectedId;
  //role permissions
  List<RolePermissionDatum> _rolePermissionList = [];
  List<RolePermissionEdit> _rolePermissionsEdit = [];
  TextEditingController _comment = TextEditingController();

  Future fetchData() async {
    setState(() => _isDataLoading = true);
    RolesModel? roles = await ApiRolesService.getRolesData();
    PermissionModel? permission = await ApiRolesService.getPermissionData();
    setState(() {
      _rolesData = roles?.roleData ?? [];
      _permissionData = permission?.permissionData ?? [];
      _selectedIndex = 0;
      fetchRolePermission(_rolesData[0].roleId);
      _isDataLoading = false;
    });
  }

  Future fetchRolePermission(String roleId) async {
    RolePermissionsModel? rolePermissionData;
    setState(() {
      _rolePermissionsEdit = [];
      _permissionsName = [];
      _permissionsAssign = [];
      _rolePermissionList = [];
      _isPermissionLoading = true;
    });
    rolePermissionData = await ApiRolesService.getRolePermissionData(roleId);
    _rolePermissionList = rolePermissionData?.rolePermissionData ?? [];
    setState(() {
      if (rolePermissionData == null) {
        onEdit = false;
        for (var d in _permissionData) {
          _permissionsAssign.add(RolePermissionAssing(
              permissionId: d.permissionId,
              canRead: false,
              canWrite: false,
              canDelete: false));
          _permissionsName.add(d.permissionName);
        }
      } else {
        onEdit = true;

        // Create a map for quick lookup of existing permissions by permissionId
        final Map<String, RolePermissionDatum> rolePermissionMap = {
          for (var e in _rolePermissionList) e.permissionData.permissionId: e
        };

        for (var element in _permissionData) {
          var rolePermission = rolePermissionMap[element.permissionId];
          if (rolePermission != null) {
            // Update existing role permission
            _rolePermissionsEdit.add(RolePermissionEdit(
                rolePermissionId: rolePermission.rolePermissionId,
                permissionId: rolePermission.permissionData.permissionId,
                canRead: rolePermission.canRead,
                canWrite: rolePermission.canWrite,
                canDelete: rolePermission.canDelete));
          } else {
            // Add new role permission with default values
            _rolePermissionsEdit.add(RolePermissionEdit(
                rolePermissionId: '',
                permissionId: element.permissionId,
                canRead: false,
                canWrite: false,
                canDelete: false));
          }
          _permissionsName.add(element.permissionName);
        }
      }
      _isPermissionLoading = false;
    });
  }

  Widget roles() {
    return Column(
      children: [
        Text('Roles',
            style: TextStyle(fontWeight: FontWeight.bold, color: mythemecolor)),
        Expanded(
            child: ListView.builder(
                itemCount: _rolesData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: AnimatedContainer(
                      decoration: BoxDecoration(
                          color: index == _selectedIndex
                              ? myambercolors
                              : mygreycolors,
                          borderRadius: BorderRadius.circular(12)),
                      duration: Duration(milliseconds: 200),
                      padding: EdgeInsets.all(2),
                      child: RadioListTile(
                        activeColor: mythemecolor,
                        value: index,
                        groupValue: _selectedIndex,
                        title: Text(_rolesData[index].roleName),
                        onChanged: (int? value) {
                          setState(() {
                            _selectedIndex = value;
                            _rolesSelectedName = _rolesData[index].roleName;
                            _rolesSelectedId = _rolesData[index].roleId;

                            fetchRolePermission(_rolesSelectedId!);
                          });
                        },
                      ),
                    ),
                  );
                })),
      ],
    );
  }

  Widget permissions() {
    return _isPermissionLoading
        ? myLoadingScreen
        : Column(
            children: [
              Text('Permissions',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: mythemecolor)),
              Expanded(
                  child: ListView.builder(
                      itemCount: onEdit
                          ? _rolePermissionsEdit.length
                          : _permissionsAssign.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: ListTile(
                            title: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  _permissionsName[index],
                                )),
                                Tooltip(
                                  message: 'Can Read',
                                  child: Checkbox(
                                      activeColor: mythemecolor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      value: onEdit
                                          ? _rolePermissionsEdit[index].canRead
                                          : _permissionsAssign[index].canRead,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (onEdit) {
                                            _rolePermissionsEdit[index]
                                                .canRead = value!;
                                          } else {
                                            _permissionsAssign[index].canRead =
                                                value!;
                                          }
                                        });
                                      }),
                                ),
                                Text('Read', style: TextStyle(fontSize: 13)),
                                Tooltip(
                                  message: 'Can Write',
                                  child: Checkbox(
                                      activeColor: mythemecolor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      value: onEdit
                                          ? _rolePermissionsEdit[index].canWrite
                                          : _permissionsAssign[index].canWrite,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (onEdit) {
                                            _rolePermissionsEdit[index]
                                                .canWrite = value!;
                                          } else {
                                            _permissionsAssign[index].canWrite =
                                                value!;
                                          }
                                          // _permissionsAssign[index].canWrite = value!;
                                        });
                                      }),
                                ),
                                Text('Write', style: TextStyle(fontSize: 13)),
                                Tooltip(
                                  message: 'Can Delete',
                                  child: Checkbox(
                                      activeColor: mythemecolor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      value: onEdit
                                          ? _rolePermissionsEdit[index]
                                              .canDelete
                                          : _permissionsAssign[index].canDelete,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (onEdit) {
                                            _rolePermissionsEdit[index]
                                                .canDelete = value!;
                                          } else {
                                            _permissionsAssign[index]
                                                .canDelete = value!;
                                          }
                                          // _permissionsAssign[index].canDelete =
                                          //     value!;
                                        });
                                      }),
                                ),
                                Text('Delete', style: TextStyle(fontSize: 13)),
                              ],
                            ),
                          ),
                        );
                      })),
            ],
          );
  }

  Widget summarize() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('- Summarize Role Permissions -'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                Text('Roles : ', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(_rolesSelectedName ?? '')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Text('Permissions : ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                ...List.generate(
                    _permissionsAssign.length,
                    (index) => Row(
                          children: [
                            Text(_permissionsName[index]),
                            const Gap(2),
                            Text('R ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _permissionsAssign[index].canRead
                                        ? mygreencolors
                                        : myredcolors)),
                            Text('W ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _permissionsAssign[index].canWrite
                                        ? mygreencolors
                                        : myredcolors)),
                            Text('D',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _permissionsAssign[index].canDelete
                                        ? mygreencolors
                                        : myredcolors)),
                            if (index != _permissionsAssign.length - 1)
                              const Text(' , ')
                          ],
                        )),
                if (_permissionsAssign.isNotEmpty)
                  IconButton(
                      splashRadius: 2,
                      onPressed: () {
                        setState(() {
                          _permissionsName = [];
                          _permissionsAssign = [];
                        });
                      },
                      icon: Icon(
                        Icons.cancel_rounded,
                        color: myredcolors,
                      ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Future onCreate() async {
    String userEmployeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userEmployeeId = preferences.getString("employeeId")!;
    AssignRolePermissionsModel createModel = AssignRolePermissionsModel(
        roleId: _rolesSelectedId!,
        rolePermissionAssing: _permissionsAssign,
        createBy: userEmployeeId);
    bool success = await ApiRolesService.createRolePermissions(createModel);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: mygreencolors,
          content: const Text("Create Role Permissions Success")));

      fetchRolePermission(_rolesSelectedId!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: myredcolors,
          content: const Text("Create Role Permissions Fail")));
    }
  }

  Future onUpdate() async {
    String userEmployeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userEmployeeId = preferences.getString("employeeId")!;
    EditRolePermissionsModel updateModel = EditRolePermissionsModel(
        roleId: _rolesSelectedId!,
        rolePermissionAssing: _rolePermissionsEdit,
        modifiedBy: userEmployeeId,
        comment: _comment.text);
    bool success = await ApiRolesService.EditRolePermissions(updateModel);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: mygreencolors,
          content: const Text("Edit Role Permissions Success")));
      fetchRolePermission(_rolesSelectedId!);
      _comment.text = '';
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: myredcolors,
          content: const Text("Edit Role Permissions Fail")));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return _isDataLoading
        ? myLoadingScreen
        : Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // color: myambercolors,
                    child: Column(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      // color: mybluecolors,
                                      child: roles(),
                                    )),
                                VerticalDivider(
                                  thickness: 2.5,
                                  // color: mythemecolor,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      // color: myredcolors,
                                      child: permissions(),
                                    )),
                              ],
                            )),
                        // Expanded(
                        //     flex: 1,
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           borderRadius: BorderRadius.circular(12)),
                        //       child: summarize(),
                        //     )),
                        const Gap(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (onEdit)
                              SizedBox(
                                width: 300,
                                child: TextFormFieldGlobal(
                                    controller: _comment,
                                    labelText: "Comment",
                                    validatorless:
                                        Validatorless.required('required'),
                                    enabled: true),
                              ),
                            MySaveButtons(
                              height: 48,
                              text: onEdit ? "Update" : "Submit",
                              onPressed: _rolesSelectedId == null
                                  ? null
                                  : () {
                                      setState(() {
                                        onEdit ? onUpdate() : onCreate();
                                      });
                                    },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ))
              ],
            ),
          );
  }
}

class CheckBoxData {
  bool canRead;
  bool canWrite;
  bool canDelete;

  CheckBoxData({
    this.canRead = false,
    this.canWrite = false,
    this.canDelete = false,
  });
}
