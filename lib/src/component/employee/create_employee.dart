import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/employee_bloc/employee_bloc.dart';
import 'package:hris_app_prototype/src/bloc/organization_bloc/position_org_bloc/position_org_bloc.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_address.dart';
import 'package:hris_app_prototype/src/model/employee/create_employee_model.dart';
import 'package:hris_app_prototype/src/model/employee/dropdown_staffstatus_model.dart';
import 'package:hris_app_prototype/src/model/employee/dropdown_stafftype_model.dart';
import 'package:hris_app_prototype/src/model/employee/get_shift_model.dart';
import 'package:hris_app_prototype/src/model/organization/organization/get_org_all_model.dart';
import 'package:hris_app_prototype/src/model/organization/position_org/get_position_org_by_org_id_model.dart';
import 'package:hris_app_prototype/src/model/person/allperson_model.dart';
import 'package:hris_app_prototype/src/services/api_employee_service.dart';
import 'package:hris_app_prototype/src/services/api_org_service.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

class CreateEmployee extends StatefulWidget {
  final PersonDatum? person;
  final bool onEdit;
  final PositionOrganizationDatum? positionOrg;
  const CreateEmployee(
      {super.key,
      required this.person,
      required this.onEdit,
      this.positionOrg});

  @override
  State<CreateEmployee> createState() => _CreateEmployeeState();
}

class _CreateEmployeeState extends State<CreateEmployee> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController test = TextEditingController();
  TextEditingController fingerscan = TextEditingController();
  TextEditingController validFrom = TextEditingController();
  TextEditingController expFrom = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController note = TextEditingController();
  bool disableExp = false;
  bool disablePo = false;

  List<StaffStatusDatum>? staffStatusList;
  String staffStatus = "1";

  List<StaffTypeDatum>? staffTypeList;
  String? staffType;

  List<ShiftDatum>? shiftDataList;
  String? shiftData;

  List<OrganizationDatum> ogList = [];
  String? ogData;

  List<PositionOrganizationDatum>? poList;
  String? poData;

  Future<void> selectvalidFromDate() async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(9999, 12, 31),
    );
    if (picker != null) {
      setState(() {
        validFrom.text = picker.toString().split(" ")[0];
        disableExp = true;
        expFrom.text = "";
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

  Future<void> fetchData() async {
    staffStatusList = await ApiEmployeeService.getStaffStatueDropdown();
    staffTypeList = await ApiEmployeeService.getStaffTypeDropdown();
    shiftDataList = await ApiEmployeeService.getShiftData();
    GetOrganizationAllModel? og =
        await ApiOrgService.fetchDataTableOrganization();
    if (widget.positionOrg != null) {
      ogData = widget.positionOrg!.organizationData.organizationCode;
      GetPositionOrgByOrgIdModel? po =
          await ApiOrgService.fetchPositionOrgByOrgId(ogData.toString());
      poList = po?.positionOrganizationData;
    }
    setState(() {
      ogList = og!.organizationData;
      if (widget.positionOrg != null) {
        poData = widget.positionOrg!.positionOrganizationId;
      }
    });
  }

  fetchDataPo() async {
    GetPositionOrgByOrgIdModel? po =
        await ApiOrgService.fetchPositionOrgByOrgId(ogData.toString());
    setState(() {
      poList = po?.positionOrganizationData;
    });
  }

  Future onAdd() async {
    if (_formKey.currentState!.validate()) {
      CreateEmployeeModel createModel = CreateEmployeeModel(
        personId: widget.person!.personId,
        fingerScanId: fingerscan.text,
        startDate: validFrom.text,
        endDate: expFrom.text,
        noted: note.text,
        email: email.text,
        deptCode: "",
        staffStatus: staffStatus.toString(),
        staffType: staffType.toString(),
        shiftId: shiftData.toString(),
        positionOrganizationId: poData.toString(),
      );
      setState(() {});
      bool success = await ApiEmployeeService.createEmployee(createModel);
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
                        ? 'Created Employee Success.'
                        : 'Edit Employee Success.'
                    : widget.onEdit == false
                        ? 'Created Employee Fail.'
                        : 'Edit Employee Fail.',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              Text(
                success == true
                    ? widget.onEdit == false
                        ? 'เพิ่มพนักงาน สำเร็จ'
                        : 'แก้ไขพนักงาน สำเร็จ'
                    : widget.onEdit == false
                        ? 'เพิ่มพนักงาน ไม่สำเร็จ'
                        : 'แก้ไขพนักงาน ไม่สำเร็จ',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
      btnOkColor: success == true ? Colors.greenAccent : Colors.red,
      btnOkOnPress: () {
        if (success == true) {
          setState(() {
            context.read<EmployeeBloc>().add(FetchDataTableEmployeeEvent());
            context.read<PositionOrgBloc>().add(FetchDataPositionOrgEvent(
                organizationId:
                    widget.positionOrg!.organizationData.organizationCode));
          });
        }
      },
    ).show();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Expanded(
              child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: TextFormFieldNumber(
                              controller: fingerscan,
                              labelText: "Fingerscan",
                              hintText: "ลายนิ้วมือ*",
                              validatorless:
                                  Validatorless.required('*กรุณากรอกข้อมูล'),
                            )),
                            Expanded(
                              child: DropdownOrg(
                                labeltext: 'Shift.',
                                value: shiftData,
                                validator:
                                    Validatorless.required('*กรุณากรอกข้อมูล'),
                                items: shiftDataList?.map((e) {
                                  return DropdownMenuItem<String>(
                                    value: e.shiftId.toString(),
                                    child: Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 140),
                                        child: Text(e.shiftName)),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    shiftData = newValue.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const Gap(2),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Card(
                                child: TextFormField(
                                  controller: validFrom,
                                  autovalidateMode: AutovalidateMode.always,
                                  validator: Validatorless.required(
                                      '*กรุณากรอกข้อมูล'),
                                  decoration: const InputDecoration(
                                    labelText: 'วันที่เริ่มงาน',
                                    labelStyle: TextStyle(color: Colors.black),
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon: Icon(
                                      Icons.calendar_today,
                                    ),
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black38),
                                    ),
                                  ),
                                  readOnly: true,
                                  onTap: () {
                                    selectvalidFromDate();
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Card(
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
                                          BorderSide(color: Colors.black38),
                                    ),
                                  ),
                                  readOnly: true,
                                  enabled: disableExp,
                                  onTap: () {
                                    selectexpDate();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(2),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: DropdownOrg(
                                labeltext: 'Staff status.',
                                value: staffStatus,
                                validator:
                                    Validatorless.required('*กรุณากรอกข้อมูล'),
                                items: staffStatusList?.map((e) {
                                  return DropdownMenuItem<String>(
                                    value: e.staffStatusId.toString(),
                                    child: Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 120),
                                        child: Text(e.description)),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    staffStatus = newValue.toString();
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: DropdownOrg(
                                labeltext: 'Staff type.',
                                value: staffType,
                                validator:
                                    Validatorless.required('*กรุณากรอกข้อมูล'),
                                items: staffTypeList?.map((e) {
                                  return DropdownMenuItem<String>(
                                    value: e.staffTypeId.toString(),
                                    child: Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 140),
                                        child: Text(e.description)),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    staffType = newValue.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const Gap(2),
                        TextFormFieldPosition(
                          controller: email,
                          labelText: "Email",
                          hintText: "ถ้ามี*",
                          validatorless:
                              Validatorless.email("admin@example.com"),
                        ),
                        TextFormFieldPositionDescription(
                          controller: note,
                          labelText: "หมายเหตุ",
                          hintText: "เพิ่มคำอธิบาย*",
                          validatorless: null,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: DropdownOrg(
                                labeltext: 'Organization.',
                                value: ogData,
                                validator:
                                    Validatorless.required('*กรุณากรอกข้อมูล'),
                                items: ogList.map((e) {
                                  return DropdownMenuItem<String>(
                                    value: e.organizationCode.toString(),
                                    child: Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 180),
                                        child: Text(
                                            "${e.departMentData.deptCode} : ${e.departMentData.deptNameTh}")),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    ogData = newValue.toString();
                                    fetchDataPo();
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: DropdownOrg(
                                labeltext: 'Position Organization',
                                value: poData,
                                validator:
                                    Validatorless.required('*กรุณากรอกข้อมูล'),
                                items: poList?.map((e) {
                                  return DropdownMenuItem<String>(
                                    value: e.positionOrganizationId.toString(),
                                    child: Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 197),
                                        child: Text(
                                            "${e.positionData.positionId} : ${e.positionData.positionNameTh}")),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    poData = newValue.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          )),
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
                      "Create",
                      style: TextStyle(color: Colors.black87),
                    ))),
          )
        ],
      ),
    );
  }
}
