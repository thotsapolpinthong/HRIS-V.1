import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_app_prototype/src/bloc/organization_bloc/department_bloc/bloc/department_bloc.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_address.dart';
import 'package:hris_app_prototype/src/model/organization/department/create_department_model.dart';
import 'package:hris_app_prototype/src/model/organization/department/get_departmen_model.dart';
import 'package:hris_app_prototype/src/model/organization/department/update_department_model.dart';
import 'package:hris_app_prototype/src/services/api_org_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class EditDepartment extends StatefulWidget {
  final bool onEdit;
  final DepartmentDatum? departmenData;
  const EditDepartment({super.key, required this.onEdit, this.departmenData});

  @override
  State<EditDepartment> createState() => _EditDepartmentState();
}

class _EditDepartmentState extends State<EditDepartment> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameTH = TextEditingController();
  TextEditingController nameEN = TextEditingController();
  TextEditingController deptCode = TextEditingController();
  TextEditingController comment = TextEditingController();
  bool status = true;

  showdialogEdit() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              icon: IconButton(
                color: Colors.red[600],
                icon: const Icon(
                  Icons.cancel,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              content: SizedBox(
                width: 300,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(flex: 2, child: Text('หมายเหตุ (โปรดระบุ)')),
                    Expanded(
                      flex: 11,
                      child: Center(
                        child: Card(
                          elevation: 2,
                          child: TextFormField(
                            controller: comment,
                            minLines: 1,
                            maxLines: 5,
                            decoration: const InputDecoration(
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                filled: true,
                                fillColor: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                onSave();
                                Navigator.pop(context);
                              },
                              child: const Text("OK"))
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
  }

  Future onSave() async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    if (_formKey.currentState!.validate()) {
      UpdateDepartmentModel updatedDepartment = UpdateDepartmentModel(
        deptCode: deptCode.text,
        deptNameEn: nameEN.text,
        deptNameTh: nameTH.text,
        deptStatus: status == true ? 'Active' : 'Inactive',
        modifiedBy: employeeId,
        comment: comment.text,
      );
      setState(() {});
      bool success =
          await ApiOrgService.updatedDepartmentById(updatedDepartment);
      alertDialog(success);
      comment.text = '';
    } else {}
  }

  Future onAdd() async {
    if (_formKey.currentState!.validate()) {
      CreateDepartmentModel createDepartment = CreateDepartmentModel(
        deptCode: deptCode.text,
        deptNameEn: nameEN.text,
        deptNameTh: nameTH.text,
      );
      setState(() {});
      bool success = await ApiOrgService.createdDepartment(createDepartment);
      alertDialog(success);
    } else {}
  }

  alertDialog(bool success) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      width: 500,
      context: context,
      animType: AnimType.topSlide,
      dialogType: success == true ? DialogType.success : DialogType.error,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Column(
            children: [
              Text(
                success == true
                    ? widget.onEdit == false
                        ? 'Created Department Success.'
                        : 'Edit Department Success.'
                    : widget.onEdit == false
                        ? 'Created Department Fail.'
                        : 'Edit Department Fail.',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              Text(
                success == true
                    ? widget.onEdit == false
                        ? 'เพิ่มแผนก สำเร็จ'
                        : 'แก้ไขแผนก สำเร็จ'
                    : widget.onEdit == false
                        ? 'เพิ่มแผนก ไม่สำเร็จ'
                        : 'แก้ไขแผนก ไม่สำเร็จ',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
      btnOkColor: success == true ? Colors.greenAccent : Colors.red,
      btnOkOnPress: () {
        setState(() {
          context.read<DepartmentBloc>().add(FetchDataEvent());
        });
      },
    ).show();
  }

  @override
  void initState() {
    if (widget.onEdit == true) {
      deptCode.text = widget.departmenData!.deptCode;
      nameTH.text = widget.departmenData!.deptNameTh;
      nameEN.text = widget.departmenData!.deptNameEn;
      status = widget.departmenData!.deptStatus == 'Active' ? true : false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: SizedBox(
                  width: 400,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(children: [
                        TextFormFieldPositionDescription(
                            controller: deptCode,
                            labelText: 'Department Code',
                            hintText: 'กรอกรหัสแผนกที่ต้องการ 2-3 ตำแหน่ง',
                            validatorless: Validatorless.multiple([
                              Validatorless.max(3, '*สูงสุด 3 ตำแหน่ง'),
                              Validatorless.min(2, '*กรอกให้ครบ 2 ตำแหน่ง'),
                              Validatorless.required('*กรุณากรอกข้อมูล')
                            ])),
                        TextFormFieldPosition(
                          controller: nameTH,
                          labelText: 'Department name (TH)',
                          hintText: 'Name (TH)',
                          validatorless:
                              Validatorless.required('*กรุณากรอกข้อมูล'),
                        ),
                        TextFormFieldPosition(
                          controller: nameEN,
                          labelText: 'Department Name (EN)',
                          hintText: 'Name (EN)',
                          validatorless:
                              Validatorless.required('*กรุณากรอกข้อมูล'),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            if (widget.onEdit == false)
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                      ),
                      onPressed: () {
                        onAdd();
                      },
                      child: const Text(
                        "Add",
                        style: TextStyle(color: Colors.black87),
                      )),
                ),
              )
            else
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: status == true ? 2 : 0,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(8))),
                                    backgroundColor: status == true
                                        ? Colors.greenAccent
                                        : Colors.grey[300],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      status = true;
                                    });
                                  },
                                  child: const Text(
                                    "Active",
                                    style: TextStyle(color: Colors.black87),
                                  )),
                            ),
                            SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: status == false ? 2 : 0,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.horizontal(
                                            right: Radius.circular(8))),
                                    backgroundColor: status == false
                                        ? Colors.redAccent
                                        : Colors.grey[300],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      status = false;
                                    });
                                  },
                                  child: const Text(
                                    "InActive",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                          ),
                          onPressed: () {
                            showdialogEdit();
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(color: Colors.black87),
                          )),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
