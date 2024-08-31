// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/role_permission/roles/create_roles_model.dart';
import 'package:hris_app_prototype/src/model/role_permission/roles/roles_model.dart';
import 'package:hris_app_prototype/src/model/role_permission/roles/update_roles_model.dart';
import 'package:hris_app_prototype/src/services/api_role_permission.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class EditRoles extends StatefulWidget {
  final bool onEdit;
  final Function() fetchData;
  final RoleDatum? roleData;
  const EditRoles({
    Key? key,
    required this.onEdit,
    required this.fetchData,
    this.roleData,
  }) : super(key: key);

  @override
  State<EditRoles> createState() => _EditRolesState();
}

class _EditRolesState extends State<EditRoles> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _id = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _comment = TextEditingController();

  Future onCreate() async {
    String userEmployeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userEmployeeId = preferences.getString("employeeId")!;
    CreateRolesModel createModel =
        CreateRolesModel(roleName: _name.text, createBy: userEmployeeId);
    bool success = await ApiRolesService.createRoles(createModel);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: mygreencolors,
          content: const Text("Create Permission Success")));
      widget.fetchData();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: myredcolors,
          content: const Text("Create Permission Fail")));
    }
  }

  Future onEdit() async {
    String userEmployeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userEmployeeId = preferences.getString("employeeId")!;
    UpdateRolesModel updateModel = UpdateRolesModel(
        roleId: _id.text,
        roleName: _name.text,
        modifyBy: userEmployeeId,
        comment: _comment.text);
    bool success = await ApiRolesService.updateRoles(updateModel);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: mygreencolors,
          content: const Text("Edit Permission Success")));
      widget.fetchData();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: myredcolors,
          content: const Text("Edit Permission Fail")));
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.onEdit) {
      _id.text = widget.roleData!.roleId;
      _name.text = widget.roleData!.roleName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        Text(widget.onEdit ? 'Edit Roles' : 'Create Roles'),
        const Gap(12),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (widget.onEdit)
                TextFormFieldGlobal(
                    controller: _id, labelText: "ID", enabled: false),
              TextFormFieldGlobal(
                controller: _name,
                labelText: "Name",
                enabled: true,
                onChanged: (p0) => setState(() {}),
                validatorless: Validatorless.required('required'),
              ),
              if (widget.onEdit)
                TextFormFieldGlobal(
                  controller: _comment,
                  labelText: "Comment",
                  enabled: true,
                  onChanged: (p0) => setState(() {}),
                  validatorless: Validatorless.required('required'),
                ),
            ],
          ),
        )),
        MySaveButtons(
          text: "Submit",
          onPressed: _formKey.currentState?.validate() != true
              ? null
              : () {
                  if (widget.onEdit) {
                    onEdit();
                  } else {
                    onCreate();
                  }
                },
        )
      ]),
    );
  }
}
