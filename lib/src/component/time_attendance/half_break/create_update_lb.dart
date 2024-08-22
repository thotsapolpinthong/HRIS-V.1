// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/timeattendance_bloc/timeattendance_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee/datatable_employee.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';
import 'package:hris_app_prototype/src/model/organization/organization/dropdown/parent_org_dd_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/lunch_break_half/create_lbh_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/lunch_break_half/get_lbh_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/lunch_break_half/update_lbh_model.dart';
import 'package:hris_app_prototype/src/services/api_org_service.dart';
import 'package:hris_app_prototype/src/services/api_time_attendance_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class EditLunchBreak extends StatefulWidget {
  final bool onEdit;
  final String startDate;
  final String endDate;
  final HalfHourLunchBreakDatum? data;
  const EditLunchBreak({
    Key? key,
    required this.onEdit,
    required this.startDate,
    required this.endDate,
    this.data,
  }) : super(key: key);

  @override
  State<EditLunchBreak> createState() => _EditLunchBreakState();
}

class _EditLunchBreakState extends State<EditLunchBreak> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isMenu = true;
  TextEditingController employee = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController comment = TextEditingController();
  bool? dataStatus;

  List<OrganizationDataam> orgList = [];
  String? orgCode;

  List<EmployeeDatum> employeeList = [];
  List<String> tempEmployee = [];
  @override
  void initState() {
    super.initState();
    fetchData();
    if (widget.onEdit) {
      employee.text = widget.data!.employeeId;
      startDate.text = widget.data!.startDate.split('T')[0];
      endDate.text = widget.data!.endDate.split('T')[0];
      dataStatus = widget.data!.status;
      isMenu = false;
    }
  }

  Future fetchData() async {
    orgList = await ApiOrgService.getParentOrgDropdown();
    setState(() {
      orgList;
    });
  }

  Future<void> selectDate(bool start) async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: start ? DateTime.now() : DateTime.parse(startDate.text),
      firstDate: start ? DateTime(1950) : DateTime.parse(startDate.text),
      lastDate: DateTime(9999),
    );
    if (picker != null) {
      setState(() {
        if (start) {
          startDate.text = picker.toString().split(" ")[0];
          endDate.text = "";
        } else {
          endDate.text = picker.toString().split(" ")[0];
        }
      });
    }
  }

  showDialogCreate() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: mygreycolors,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: SafeArea(
                child: SizedBox(
                    width: 1200,
                    height: MediaQuery.of(context).size.height - 20,
                    child: const DatatableEmployee(
                      isSelected: true,
                      isSelectedOne: false,
                    )),
              ));
        });
  }

  Future onCreate() async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    CreateLunchBreakModel createModel = CreateLunchBreakModel(
        startDate: startDate.text,
        endDate: endDate.text,
        employeeId: !isMenu ? tempEmployee : [],
        organizationCode: isMenu ? orgCode! : "",
        createBy: employeeId);
    createModel;
    bool success = await ApiTimeAtendanceService.createLbh(createModel);
    alertDialog(success);
  }

  Future onUpdate() async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    UpdateLunchBreakModel updateModel = UpdateLunchBreakModel(
        id: widget.data!.id,
        startDate: startDate.text,
        endDate: endDate.text,
        employeeId: employeeId,
        status: dataStatus!,
        modifyBy: employeeId,
        comment: comment.text);
    bool success = await ApiTimeAtendanceService.updateLbh(updateModel);
    alertDialog(success);
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
                        ? 'Created Lunch Break Half  Success.'
                        : 'Edit Lunch Break Half  Success.'
                    : widget.onEdit == false
                        ? 'Created Lunch Break Half  Fail.'
                        : 'Edit Lunch Break Half  Fail.',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              Text(
                success == true
                    ? widget.onEdit == false
                        ? 'เพิ่ม สำเร็จ'
                        : 'แก้ไข สำเร็จ'
                    : widget.onEdit == false
                        ? 'เพิ่ม ไม่สำเร็จ'
                        : 'แก้ไข ไม่สำเร็จ',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
      btnOkColor: success == true ? Colors.greenAccent : Colors.red,
      btnOkOnPress: () {
        if (success) {
          setState(() {
            context.read<TimeattendanceBloc>().add(FetchLunchBreakHalfEvent(
                startDate: startDate.text, endDate: endDate.text));
            Navigator.pop(context);
          });
        }
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    height: 36,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isMenu ? Colors.white : Colors.grey[300],
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(12)))),
                        onPressed: widget.onEdit
                            ? null
                            : () {
                                setState(() {
                                  if (isMenu) {
                                  } else {
                                    isMenu = !isMenu;
                                    employeeList = [];
                                  }
                                });
                              },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Department",
                                style: TextStyle(
                                    color:
                                        isMenu ? mythemecolor : Colors.black45,
                                    fontWeight: isMenu
                                        ? FontWeight.bold
                                        : FontWeight.w200)),
                            Icon(
                              Icons.account_tree_rounded,
                              color: isMenu ? mythemecolor : Colors.black45,
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 200,
                    height: 36,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                !isMenu ? Colors.white : Colors.grey[300],
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(12)))),
                        onPressed: () {
                          setState(() {
                            if (!isMenu) {
                            } else {
                              isMenu = !isMenu;
                            }
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Employee",
                                style: TextStyle(
                                    color:
                                        !isMenu ? mythemecolor : Colors.black45,
                                    fontWeight: !isMenu
                                        ? FontWeight.bold
                                        : FontWeight.w200)),
                            Icon(
                              Icons.group_rounded,
                              color: !isMenu ? mythemecolor : Colors.black45,
                            )
                          ],
                        )),
                  ),
                ],
              ),
              Expanded(
                  child: BlocBuilder<TimeattendanceBloc, TimeattendanceState>(
                builder: (context, state) {
                  tempEmployee = [];
                  if (employeeList.isNotEmpty) {
                    employeeList = [];
                    employeeList = state.selectedemployeeData ?? [];
                    for (var e in employeeList) {
                      tempEmployee.add(e.employeeId);
                      employee.text = tempEmployee.toString();
                    }
                  } else {
                    employeeList = state.selectedemployeeData ?? [];
                    for (var e in employeeList) {
                      tempEmployee.add(e.employeeId);
                      employee.text = tempEmployee.toString();
                    }
                  }
                  return Form(
                    key: _formKey,
                    child: Card(
                      elevation: 2,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(12))),
                      margin: const EdgeInsets.all(0),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const Gap(5),
                              isMenu
                                  ? DropdownGlobal(
                                      labeltext: 'Department',
                                      value: orgCode,
                                      validator: null,
                                      items: orgList.map((e) {
                                        return DropdownMenuItem<String>(
                                          value: e.organizationCode.toString(),
                                          child: Container(
                                              constraints: const BoxConstraints(
                                                  maxWidth: 300),
                                              child: Text(
                                                  "${e.organizationCode.split('0')[0]} : ${e.organizationName}")),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          orgCode = newValue.toString();
                                        });
                                      },
                                    )
                                  : TextFormFieldGlobal(
                                      controller: employee,
                                      labelText: "Employee",
                                      enabled: true,
                                      suffixIcon: employee.text == ""
                                          ? null
                                          : IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  employee.text = "";
                                                  tempEmployee = [];
                                                  context
                                                      .read<
                                                          TimeattendanceBloc>()
                                                      .add(DissSelectedEvent());
                                                });
                                              },
                                              icon: const Icon(Icons.cancel)),
                                      onTap: () {
                                        showDialogCreate();
                                      },
                                    ),
                              const Gap(5),
                              TextFormFieldDatepickGlobal(
                                  controller: startDate,
                                  labelText: "Start Date",
                                  validatorless: null,
                                  ontap: () {
                                    selectDate(true);
                                  }),
                              const Gap(5),
                              TextFormFieldDatepickGlobal(
                                  controller: endDate,
                                  labelText: "End Date",
                                  validatorless: null,
                                  enabled: startDate.text == "" ? false : true,
                                  ontap: () {
                                    selectDate(false);
                                  }),
                              if (widget.onEdit)
                                TextFormFieldGlobal(
                                  controller: comment,
                                  labelText: "Comment",
                                  enabled: true,
                                  validatorless:
                                      Validatorless.required("required"),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ))
            ],
          ),
        ),
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
                                "InActive",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  )
                : Container(),
            widget.onEdit
                ? MySaveButtons(
                    text: "Update",
                    onPressed: endDate.text == ""
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                onUpdate();
                              });
                            } else {}
                          },
                  )
                : MySaveButtons(
                    text: "Create",
                    onPressed: endDate.text == ""
                        ? null
                        : () {
                            setState(() {
                              onCreate();
                            });
                          },
                  )
          ],
        )
      ],
    );
  }
}
