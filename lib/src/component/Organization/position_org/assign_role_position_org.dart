// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/organization_bloc/position_org_bloc/position_org_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/organization/position_org/get_position_org_by_org_id_model.dart';
import 'package:hris_app_prototype/src/model/organization/position_org/update_position_org_model.dart';
import 'package:hris_app_prototype/src/model/role_permission/roles/roles_model.dart';
import 'package:hris_app_prototype/src/services/api_org_service.dart';
import 'package:hris_app_prototype/src/services/api_role_permission.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class AssignRolePositionOrg extends StatefulWidget {
  final PositionOrganizationDatum data;
  final String organizationCode;
  const AssignRolePositionOrg({
    Key? key,
    required this.data,
    required this.organizationCode,
  }) : super(key: key);

  @override
  State<AssignRolePositionOrg> createState() => _AssignRolePositionOrgState();
}

class _AssignRolePositionOrgState extends State<AssignRolePositionOrg> {
  bool isDataLoading = true;
//role
  List<RoleDatum> _roleList = [];
  String? _roleId;
  TextEditingController _roleName = TextEditingController();
  TextEditingController _comment = TextEditingController();

  fetchRoleData() async {
    RolesModel? dataRole = await ApiRolesService.getRolesData();

    setState(() {
      _roleList = dataRole?.roleData ?? [];
      _roleId = widget.data.roleData.roleId;
      _roleName.text = widget.data.roleData.roleName;
      isDataLoading = false;
    });
  }

  Future onSave(PositionOrganizationDatum data) async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;

    UpdatePositionOrgModel updatePositionOrganizationModel =
        UpdatePositionOrgModel(
      positionOrganizationId: data.positionOrganizationId,
      positionId: data.positionData.positionId,
      organizationCode: data.organizationData.organizationCode,
      jobTitleId: data.jobTitleData.jobTitleId,
      positionTypeId: data.positionTypeData.positionTypeId,
      status: 'Active',
      parentPositionNodeId: data.parentPositionNodeId.positionOrganizationId,
      parentPositionBusinessNodeId:
          data.parentPositionBusinessNodeId.positionOrganizationId,
      roleId: _roleId.toString(),
      startingSalary: data.startingSalary,
      validFromDate: data.validFromDate,
      endDate: data.endDate,
      modifiedBy: employeeId,
      comment: _comment.text,
    );
    setState(() {});
    bool success =
        await ApiOrgService.updatedPositionOrg(updatePositionOrganizationModel);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: mygreencolors,
          content: const Text("Update RolePermissions Success")));
      context.read<PositionOrgBloc>().add(
          FetchDataPositionOrgEvent(organizationId: widget.organizationCode));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: myredcolors,
          content: const Text("Update RolePermissions Fail")));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRoleData();
  }

  @override
  Widget build(BuildContext context) {
    return isDataLoading
        ? myLoadingScreen
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(10),
              DropdownMenuGlobal(
                  label: "Role Permissions",
                  width: 380,
                  controller: _roleName,
                  onSelected: (value) {
                    setState(() {
                      _roleId = value.roleId;
                    });
                  },
                  dropdownMenuEntries: _roleList.map((RoleDatum e) {
                    return DropdownMenuEntry(
                        value: e,
                        label: e.roleName,
                        style: MenuItemButton.styleFrom());
                  }).toList()),
              SizedBox(
                width: 388,
                child: TextFormFieldGlobal(
                  controller: _comment,
                  labelText: "Comment",
                  enabled: true,
                  validatorless: Validatorless.required('required'),
                ),
              ),
              MySaveButtons(
                text: "Update",
                onPressed: () {
                  setState(() {
                    onSave(widget.data);
                  });
                },
              )
            ],
          );
  }
}
