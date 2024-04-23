// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/main.dart';
import 'package:hris_app_prototype/src/bloc/organization_bloc/position_org_bloc/position_org_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/organization/organization/get_org_all_model.dart';

import 'package:hris_app_prototype/src/model/organization/position/dropdown_position_model.dart';
import 'package:hris_app_prototype/src/model/organization/position/dropdown_position_type_model.dart';
import 'package:hris_app_prototype/src/model/organization/position_org/create_position_org_model.dart';
import 'package:hris_app_prototype/src/model/organization/position_org/dropdown_jobtitle_model.dart';
import 'package:hris_app_prototype/src/model/organization/position_org/dropdown_position_org_model.dart';
import 'package:hris_app_prototype/src/model/organization/position_org/get_position_org_by_org_id_model.dart';
import 'package:hris_app_prototype/src/model/organization/position_org/update_position_org_model.dart';
import 'package:hris_app_prototype/src/services/api_org_service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

import '../../../model/organization/position_org/dropdown_position_org_by_org_id_model.dart';

class EditPositionOrganization extends StatefulWidget {
  final PositionOrganizationDatum? positionOrgData;
  final OrganizationDatum? orgData;
  final bool onEdit;
  final bool ongraph;
  final bool firstNode;
  final PositionOrganizationDatum? positionOrgDataAddNode;
  const EditPositionOrganization(
      {Key? key,
      this.positionOrgData,
      this.orgData,
      required this.onEdit,
      required this.ongraph,
      required this.firstNode,
      this.positionOrgDataAddNode})
      : super(key: key);

  @override
  State<EditPositionOrganization> createState() =>
      _EditPositionOrganizationState();
}

class _EditPositionOrganizationState extends State<EditPositionOrganization> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController validFrom = TextEditingController();
  TextEditingController expFrom = TextEditingController();
  TextEditingController comment = TextEditingController();
  TextEditingController salary = TextEditingController();
  bool disableExp = false;

  List<PositionDatum>? positionList;
  String? positionData;
  List<JobTitleDatum>? jobTitleList;
  String? jobTitleData;
  List<PositionTypeDatum>? positionTypeList;
  String? positionTypeData;
  List<PositionOrganizationDatumDropdown>? bussinessParentList;
  String? bussinessParentData;
  List<PositionOrganizationDatumById>? parentPositionOrgList;
  String? parentPositionOrgData;

  Future fetchdata() async {
    positionList = await ApiOrgService.getPositionDropdown();
    if (positionList == null) {
      setState(() {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: const Text("Token หมดอายุ กรุณา Login ใหม่อีกครั้ง"),
                icon: IconButton(
                  color: Colors.red[700],
                  icon: const Icon(
                    Icons.cancel,
                  ),
                  onPressed: () {
                    Navigator.of(navigatorState.currentContext!)
                        .popUntil((route) => route.isFirst);
                  },
                ),
              );
            });
      });
    }

    jobTitleList = await ApiOrgService.getJobtitleDropdown();
    positionTypeList = await ApiOrgService.getPositionTypeDropdown();
    widget.firstNode;
    parentPositionOrgList = await ApiOrgService.getPositionOrgByIdDropdown(
        widget.orgData!.organizationCode);
    bussinessParentList = await ApiOrgService.getPositionOrgDropdown();

    if (widget.onEdit == true) {
      if (widget.positionOrgData?.positionData.positionId != '') {
        positionData = widget.positionOrgData?.positionData.positionId;
      }
      if (widget.positionOrgData?.jobTitleData.jobTitleId != '') {
        jobTitleData = widget.positionOrgData!.jobTitleData.jobTitleId;
      }
      if (widget.positionOrgData?.positionTypeData.positionTypeId != '') {
        positionTypeData =
            widget.positionOrgData?.positionTypeData.positionTypeId;
      }
      if (widget.positionOrgData?.parentPositionBusinessNodeId
              .positionOrganizationId !=
          null) {
        bussinessParentData = widget.positionOrgData
            ?.parentPositionBusinessNodeId.positionOrganizationId;
      }
      if (widget.positionOrgData?.parentPositionNodeId.positionOrganizationId !=
          null) {
        parentPositionOrgData =
            widget.positionOrgData?.parentPositionNodeId.positionOrganizationId;
      }
      if (widget.positionOrgData?.startingSalary != null) {
        salary.text = widget.positionOrgData!.startingSalary;
      }

      validFrom.text = widget.positionOrgData!.validFromDate;
      expFrom.text = widget.positionOrgData!.endDate;
    }
    //เงื่อนไข add node
    if (widget.ongraph == true &&
        widget.onEdit == false &&
        widget.firstNode == false) {
      parentPositionOrgData =
          widget.positionOrgDataAddNode?.positionOrganizationId;
    }
    setState(() {});
  }

  Future<void> selectvalidFromDate() async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(9999),
    );
    if (picker != null) {
      setState(() {
        validFrom.text = picker.toString().split(" ")[0];
        disableExp = true;
        expFrom.text = "";
        // onValidate();
      });
    }
  }

  Future<void> selectexpDate() async {
    DateFormat format = DateFormat('yyyy-MM-dd');
    DateTime dateTime = format.parse(validFrom.text);
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime(9999, 12, 31),
      firstDate: dateTime,
      lastDate: DateTime(9999, 12, 31),
    );
    if (picker != null) {
      setState(() {
        expFrom.text = picker.toString().split(" ")[0];
      });
    }
  }

  Future onAdd() async {
    if (_formKey.currentState!.validate()) {
      CreatePositionOrganizationModel createPositionOrganizationModel =
          CreatePositionOrganizationModel(
        positionId: positionData.toString(),
        organizationCode: widget.orgData!.organizationCode,
        jobTitleId: jobTitleData.toString(),
        positionTypeId: positionTypeData.toString(),
        parentPositionNodeId:
            widget.firstNode == true ? "" : parentPositionOrgData.toString(),
        parentPositionBusinessNodeId:
            widget.firstNode == true ? "" : bussinessParentData.toString(),
        startingSalary: salary.text,
        validFromDate: validFrom.text,
        endDate: expFrom.text,
      );
      setState(() {});
      bool success = await ApiOrgService.createPositionOrg(
          createPositionOrganizationModel);

      alertDialog(success);
    } else {}
  }

  showdialogEdit() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return MyDeleteBox(
            onPressedCancel: () {
              Navigator.pop(context);
              comment.text = '';
            },
            controller: comment,
            onPressedOk: () {
              onSave();
              Navigator.pop(context);
            },
          );
        });
  }

  Future onSave() async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    if (_formKey.currentState!.validate()) {
      UpdatePositionOrgModel updatePositionOrganizationModel =
          UpdatePositionOrgModel(
        positionOrganizationId: widget.positionOrgData!.positionOrganizationId,
        positionId: positionData.toString(),
        organizationCode:
            widget.positionOrgData!.organizationData.organizationCode,
        jobTitleId: jobTitleData.toString(),
        positionTypeId: positionTypeData.toString(),
        status: 'Active',
        parentPositionNodeId: parentPositionOrgData.toString(),
        parentPositionBusinessNodeId: bussinessParentData.toString(),
        startingSalary: salary.text,
        validFromDate: validFrom.text,
        endDate: expFrom.text,
        modifiedBy: employeeId,
        comment: comment.text,
      );
      setState(() {});
      bool success = await ApiOrgService.updatedPositionOrg(
          updatePositionOrganizationModel);

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
                        ? 'Created Position Organization Success.'
                        : 'Edit Position Organization Success.'
                    : widget.onEdit == false
                        ? 'Created Position Organization Fail.'
                        : 'Edit Position Organization Fail.',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              Text(
                success == true
                    ? widget.onEdit == false
                        ? 'บันทึกข้อมูล สำเร็จ'
                        : 'แก้ไขข้อมูล สำเร็จ'
                    : widget.onEdit == false
                        ? 'บันทึกข้อมูล ไม่สำเร็จ'
                        : 'แก้ไขข้อมูล ไม่สำเร็จ',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
      btnOkColor: success == true ? Colors.greenAccent : Colors.red,
      btnOkOnPress: () {
        setState(() {
          context.read<PositionOrgBloc>().add(FetchDataPositionOrgEvent(
              organizationId: widget.orgData!.organizationCode));
          if (success == true) {
            Navigator.pop(context);
          }
        });
      },
    ).show();
  }

  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return positionList == null
        ? myLoadingScreen
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Expanded(
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: _formKey,
                          child: Column(
                            children: [
                              DropdownGlobal(
                                  labeltext: "Position",
                                  value: positionData,
                                  validator: Validatorless.required(
                                      '*กรุณากรอกข้อมูล'),
                                  items: positionList?.map((e) {
                                    return DropdownMenuItem<String>(
                                      value: e.positionId.toString(),
                                      child: Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 350, minWidth: 120),
                                          child: Text(e.positionNameTh == "NULL"
                                              ? '-'
                                              : "${e.positionId} : ${e.positionNameTh}")),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    positionData = newValue.toString();
                                  }),
                              const Gap(2),
                              DropdownGlobal(
                                  labeltext: "Jobtitle",
                                  value: jobTitleData,
                                  validator: Validatorless.required(
                                      '*กรุณากรอกข้อมูล'),
                                  items: jobTitleList?.map((e) {
                                    return DropdownMenuItem<String>(
                                      value: e.jobTitleId.toString(),
                                      child: Container(
                                          constraints: const BoxConstraints(
                                            minWidth: 100,
                                          ),
                                          child: Text(e.jobTitleName == "NULL"
                                              ? '-'
                                              : e.jobTitleName)),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    jobTitleData = newValue.toString();
                                  }),
                              const Gap(2),
                              DropdownGlobal(
                                  labeltext: "Position Type",
                                  value: positionTypeData,
                                  validator: Validatorless.required(
                                      '*กรุณากรอกข้อมูล'),
                                  items: positionTypeList?.map((e) {
                                    return DropdownMenuItem<String>(
                                      value: e.positionTypeId.toString(),
                                      child: Container(
                                          constraints: const BoxConstraints(
                                            minWidth: 100,
                                          ),
                                          child: Text(
                                              e.positionTypeNameTh == "NULL"
                                                  ? '-'
                                                  : e.positionTypeNameTh)),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    positionTypeData = newValue.toString();
                                  }),
                              const Gap(2),
                              if (widget.firstNode ==
                                  false) //------------------
                                DropdownGlobal(
                                    labeltext: "Parent Position Organization",
                                    value: parentPositionOrgData,
                                    validator: Validatorless.required(
                                        '*กรุณากรอกข้อมูล'),
                                    items: parentPositionOrgList?.map((e) {
                                      return DropdownMenuItem<String>(
                                        value:
                                            e.positionOrganizationId.toString(),
                                        child: Container(
                                            constraints: const BoxConstraints(
                                              minWidth: 100,
                                            ),
                                            child: Text(e.positionData
                                                        .positionNameTh ==
                                                    "NULL"
                                                ? "${e.positionData.positionId} : '-'"
                                                : "${e.positionData.positionId} : ${e.positionData.positionNameTh}")),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      parentPositionOrgData =
                                          newValue.toString();
                                    }),
                              const Gap(2),
                              if (widget.firstNode == false)
                                DropdownGlobal(
                                    labeltext:
                                        "Bussiness Parent Position Organization",
                                    value: bussinessParentData,
                                    validator: Validatorless.required(
                                        '*กรุณากรอกข้อมูล'),
                                    items: bussinessParentList?.map((e) {
                                      return DropdownMenuItem<String>(
                                        value:
                                            e.positionOrganizationId.toString(),
                                        child: Container(
                                            constraints: const BoxConstraints(
                                              minWidth: 100,
                                            ),
                                            child: Text(e.positionData
                                                        .positionNameTh ==
                                                    "NULL"
                                                ? '-'
                                                : "${e.positionData.positionId} : ${e.positionData.positionNameTh}")),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      bussinessParentData = newValue.toString();
                                    }),
                              const Gap(2),
                              TextFormFieldNumber(
                                controller: salary,
                                labelText: "Salary",
                                hintText: "ฐานเงินเดือนประจำตำแหน่ง*",
                                validatorless:
                                    Validatorless.required('*กรุณากรอกข้อมูล'),
                              ),
                              const Gap(2),
                              Card(
                                child: TextFormField(
                                  controller: validFrom,
                                  autovalidateMode: AutovalidateMode.always,
                                  validator: Validatorless.required(
                                      '*กรุณากรอกข้อมูล'),
                                  decoration: const InputDecoration(
                                    labelText: 'มีผลตั้งแต่',
                                    labelStyle: TextStyle(color: Colors.black),
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon: Icon(
                                      Icons.calendar_today,
                                    ),
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black54),
                                    ),
                                  ),
                                  readOnly: true,
                                  onTap: () {
                                    selectvalidFromDate();
                                  },
                                ),
                              ),
                              const Gap(2),
                              Card(
                                child: TextFormField(
                                  controller: expFrom,
                                  autovalidateMode: AutovalidateMode.always,
                                  validator: Validatorless.required(
                                      '*กรุณากรอกข้อมูล'),
                                  decoration: InputDecoration(
                                    labelText: 'สิ้นสุดเมื่อ',
                                    labelStyle: TextStyle(
                                        color: disableExp == true
                                            ? Colors.black
                                            : Colors.grey),
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon: const Icon(
                                      Icons.calendar_today,
                                    ),
                                    disabledBorder: InputBorder.none,
                                    border: const OutlineInputBorder(),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black54),
                                    ),
                                  ),
                                  readOnly: true,
                                  enabled: disableExp,
                                  onTap: () {
                                    selectexpDate();
                                  },
                                ),
                              ),
                            ],
                          ),
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
                            ))),
                  ),
                if (widget.onEdit == true)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.greenAccent,
                            ),
                            onPressed: () {
                              showdialogEdit();
                            },
                            child: const Text(
                              "Save",
                              style: TextStyle(color: Colors.black87),
                            ))),
                  )
              ],
            ),
          );
  }
}
