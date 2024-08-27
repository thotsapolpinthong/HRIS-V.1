// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/role_permission/create_permission_model.dart';
import 'package:hris_app_prototype/src/services/api_role_permission.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class EditPermission extends StatefulWidget {
  final bool onEdit;
  final Function() fetchData;
  const EditPermission({
    Key? key,
    required this.onEdit,
    required this.fetchData,
  }) : super(key: key);

  @override
  State<EditPermission> createState() => _EditPermissionState();
}

class _EditPermissionState extends State<EditPermission> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _id = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _comment = TextEditingController();

  Future onCreate() async {
    String userEmployeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userEmployeeId = preferences.getString("employeeId")!;
    CreatePermissionModel createModel = CreatePermissionModel(
        permissionName: _name.text, createBy: userEmployeeId);
    bool success = await ApiRolesService.createPermission(createModel);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: mygreencolors,
          content: const Text("Create Permission Success")));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: myredcolors,
          content: const Text("Create Permission Fail")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        Text(widget.onEdit ? 'Edit Permission' : 'Create Permission'),
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
                  onCreate();
                },
        )
      ]),
    );
  }
}
