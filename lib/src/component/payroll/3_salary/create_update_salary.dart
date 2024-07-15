// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/employee_bloc/employee_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/payroll/employee_salary/create_salary_model.dart';
import 'package:hris_app_prototype/src/model/payroll/employee_salary/get_salary_all.dart';
import 'package:hris_app_prototype/src/model/payroll/employee_salary/update_salary_model.dart';
import 'package:hris_app_prototype/src/services/api_payroll_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class EditEmployeeSalary extends StatefulWidget {
  final bool onEdit;
  final Function() fetchData;
  final EmployeeSalaryDatum? data;
  const EditEmployeeSalary({
    Key? key,
    required this.onEdit,
    required this.fetchData,
    this.data,
  }) : super(key: key);

  @override
  State<EditEmployeeSalary> createState() => _EditEmployeeSalaryState();
}

class _EditEmployeeSalaryState extends State<EditEmployeeSalary> {
  TextEditingController employeeId = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController typeName = TextEditingController();
  TextEditingController bookBank = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController wage = TextEditingController();
  TextEditingController comment = TextEditingController();
  bool? dataStatus;
  String? typeId;

  Future createSalary() async {
    String userEmployeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userEmployeeId = preferences.getString("employeeId")!;
    CreateEmployeeSalaryModel createModel = CreateEmployeeSalaryModel(
        employeeId: employeeId.text,
        employeeTypeId: int.parse(typeId!),
        bankNumber: bookBank.text,
        salary: int.parse(salary.text == "" ? "0" : salary.text),
        wage: int.parse(wage.text == "" ? "0" : wage.text),
        createBy: userEmployeeId);
    bool success = await ApiPayrollService.createSalary(createModel);
    alertDialog(success);
    if (success) {
      widget.fetchData();
    }
  }

  Future updateSalary() async {
    String userEmployeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userEmployeeId = preferences.getString("employeeId")!;
    UpdateEmployeeSalaryModel updateModel = UpdateEmployeeSalaryModel(
        id: widget.data!.id,
        employeeId: employeeId.text,
        employeeTypeId: int.parse(typeId!),
        bankNumber: bookBank.text,
        salary: double.parse(salary.text == "" ? "0" : salary.text),
        wage: int.parse(wage.text == "" ? "0" : wage.text),
        status: dataStatus! ? "active" : "inactive",
        modifyBy: userEmployeeId,
        comment: comment.text);
    bool success = await ApiPayrollService.updateSalary(updateModel);
    alertDialog(success);
    if (success) {
      widget.fetchData();
    }
  }

  alertDialog(bool success) {
    MyDialogSuccess.alertDialog(
        context, success, widget.onEdit, "Employee Salary");
  }

  @override
  void initState() {
    super.initState();
    if (widget.onEdit) {
      employeeId.text = widget.data!.employeeId;
      name.text = "${widget.data!.firstName} ${widget.data!.lastName}";
      typeId = "${widget.data!.employeeTypeId}";
      typeName.text = widget.data!.employeeTypeName;
      bookBank.text = widget.data!.bankNumber;
      salary.text = "${widget.data!.salary}";
      wage.text = "${widget.data!.wage}";
      dataStatus = widget.data!.status == "active" ? true : false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: SingleChildScrollView(
          child: BlocBuilder<EmployeeBloc, EmployeeState>(
            builder: (context, state) {
              if (!widget.onEdit && employeeId.text == "") {
                employeeId.text = state.employeeData?.employeeId ?? "";
                name.text =
                    "${state.employeeData?.personData.titleName.titleNameTh} ${state.employeeData?.personData.fisrtNameTh} ${state.employeeData?.personData.lastNameTh}";
                typeId = state
                    .employeeData?.positionData.positionTypeData.positionTypeId;
                typeName.text = state.employeeData?.positionData
                        .positionTypeData.positionTypeNameTh ??
                    "";
              }
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormFieldGlobal(
                            controller: employeeId,
                            labelText: "Employee Id",
                            enabled: false),
                      ),
                      Expanded(
                        child: TextFormFieldGlobal(
                            controller: typeName,
                            labelText: "Position Type",
                            enabled: false),
                      ),
                    ],
                  ),
                  const Gap(4),
                  TextFormFieldGlobal(
                      controller: name,
                      labelText: "Employee Name",
                      enabled: false),
                  const Gap(4),
                  TextFormFieldGlobal(
                    controller: bookBank,
                    labelText: "Bank account",
                    enabled: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                    ],
                    validatorless: Validatorless.multiple([
                      Validatorless.required("required"),
                      Validatorless.min(10, "required Specify 10 digits")
                    ]),
                  ),
                  const Gap(4),
                  typeId == "1"
                      ? TextFormFieldGlobal(
                          controller: salary,
                          labelText: "Salary",
                          enabled: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                          ],
                          validatorless: Validatorless.required("required"),
                        )
                      : TextFormFieldGlobal(
                          controller: wage,
                          labelText: "Wage",
                          enabled: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                          ],
                          validatorless: Validatorless.required("required"),
                        ),
                  if (widget.onEdit)
                    TextFormFieldGlobal(
                      controller: comment,
                      labelText: "Comment",
                      enabled: true,
                      validatorless: Validatorless.required("required"),
                    ),
                ],
              );
            },
          ),
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.onEdit
                ? Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: dataStatus == true ? 2 : 0,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(8))),
                                backgroundColor: dataStatus == true
                                    ? Colors.greenAccent
                                    : Colors.grey[300],
                              ),
                              onPressed: () {
                                setState(() {
                                  dataStatus = true;
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
                                elevation: dataStatus == false ? 2 : 0,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(8))),
                                backgroundColor: dataStatus == false
                                    ? Colors.redAccent
                                    : Colors.grey[300],
                              ),
                              onPressed: () {
                                setState(() {
                                  dataStatus = false;
                                });
                              },
                              child: const Text(
                                "Inactive",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  )
                : Container(),
            MySaveButtons(
              text: widget.onEdit ? "Update" : "Create",
              onPressed: () {
                if (widget.onEdit) {
                  updateSalary();
                } else {
                  createSalary();
                }
              },
            )
          ],
        )
      ],
    );
  }
}
