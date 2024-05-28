import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/main.dart';
import 'package:hris_app_prototype/src/bloc/organization_bloc/organization_bloc/bloc/organization_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/organization/department/get_departmen_model.dart';
import 'package:hris_app_prototype/src/model/organization/organization/create_org_model.dart';
import 'package:hris_app_prototype/src/model/organization/organization/dropdown/org_type_dd_model.dart';
import 'package:hris_app_prototype/src/model/organization/organization/dropdown/parent_org_dd_model.dart';
import 'package:hris_app_prototype/src/model/organization/organization/get_org_all_model.dart';
import 'package:hris_app_prototype/src/model/organization/organization/update_org_model.dart';
import 'package:hris_app_prototype/src/services/api_org_service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class EditOrganization extends StatefulWidget {
  final bool onEdit;
  final bool ongraph;
  final OrganizationDatum? orgData;
  const EditOrganization(
      {super.key, required this.onEdit, this.orgData, required this.ongraph});

  @override
  State<EditOrganization> createState() => _EditOrganizationState();
}

class _EditOrganizationState extends State<EditOrganization> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController departmentId = TextEditingController();
  TextEditingController validFrom = TextEditingController();
  TextEditingController expFrom = TextEditingController();
  TextEditingController comment = TextEditingController();
  TextEditingController departmentMenu = TextEditingController();
  TextEditingController parentOrgMenu = TextEditingController();
  bool status = true;
  bool disableExp = false;

  List<OrganizationDataam> parentOrgList = [];
  String? parentOrg;

  List<OrganizationTypeDatum> orgTypeList = [];
  String? orgType;

  List<DepartmentDatum>? departmentList;
  String? department;

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
      CreateOrganizationModel createOrganization = CreateOrganizationModel(
        deparmentId: department.toString(),
        parentOrganizationNodeId: parentOrg.toString(),
        parentOrganizationBusinessNodeId: parentOrg.toString(),
        organizationTypeId: orgType.toString(),
        organizationStatus: 'Active',
        validFrom: validFrom.text,
        endDate: expFrom.text,
      );
      setState(() {});
      bool success =
          await ApiOrgService.createdOrganization(createOrganization);

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
              onSave(comment.text);
              Navigator.pop(context);
              comment.text = '';
            },
          );
        });
  }

  Future onSave(String comment) async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    if (_formKey.currentState!.validate()) {
      UpdateOrganizationByIdModel updateOrganization =
          UpdateOrganizationByIdModel(
        organizationId: widget.orgData!.organizationId,
        organizationCode: widget.orgData!.organizationCode,
        deparmentId: department.toString(),
        parentOrganizationNodeId: parentOrg.toString(),
        parentOrganizationBusinessNodeId: parentOrg.toString(),
        organizationTypeId: orgType.toString(),
        organizationStatus: status == true ? 'Active' : 'Inactive',
        validFrom: validFrom.text,
        endDate: expFrom.text,
        modifiedBy: employeeId,
        comment: comment.toString(),
      );
      setState(() {});
      bool success =
          await ApiOrgService.updatedOrganizationById(updateOrganization);
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
                        ? 'Created Node Success.'
                        : 'Edit Node Success.'
                    : widget.onEdit == false
                        ? 'Created Node Fail.'
                        : 'Edit Node Fail.',
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
        setState(() {
          context.read<OrganizationBloc>().add(FetchDataTableOrgEvent());
          Navigator.pop(context);
        });
      },
    ).show();
  }

  Future fetchdata() async {
    parentOrgList = await ApiOrgService.getParentOrgDropdown();
    if (parentOrgList == []) {
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

    orgTypeList = await ApiOrgService.getTypeOrgDropdown();
    departmentList = await ApiOrgService.getdepartmentDropdown();

    if (widget.onEdit == true) {
      if (widget.orgData?.departMentData.deptCode != '') {
        department = widget.orgData?.departMentData.deptCode;
        departmentMenu.text = widget.orgData!.departMentData.deptNameTh;
      }
      if (widget.orgData?.parentOrganizationNodeData.organizationId != null) {
        parentOrg = widget.orgData?.parentOrganizationNodeData.organizationCode;
        parentOrgMenu.text =
            widget.orgData!.parentOrganizationNodeData.organizationName;
      }
      if (widget.orgData?.organizationTypeData.organizationTypeId != null) {
        orgType = widget.orgData?.organizationTypeData.organizationTypeId;
      }

      status = widget.orgData?.organizationStatus == 'Active' ? true : false;
      validFrom.text = widget.orgData!.validFrom;
      expFrom.text = widget.orgData!.endDate;
    }
    if (widget.ongraph == true) {
      parentOrg = widget.orgData?.organizationCode;
      parentOrgMenu.text =
          widget.orgData!.parentOrganizationNodeData.organizationName;
    }
    setState(() {});
  }

  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return orgTypeList == [] || parentOrgList.isEmpty
        ? myLoadingScreen
        : Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(children: [
                        DropdownMenuGlobal(
                            label: "Department",
                            width: 442,
                            controller: departmentMenu,
                            onSelected: (value) {
                              setState(() {
                                department = value.toString();
                              });
                            },
                            dropdownMenuEntries: departmentList!.map((e) {
                              return DropdownMenuEntry(
                                  value: e.deptCode,
                                  label:
                                      "${e.deptNameEn} : ${e.deptNameTh == "NULL" ? '-' : e.deptNameTh}",
                                  style: MenuItemButton.styleFrom());
                            }).toList()),
                        // DropdownGlobal(
                        //   labeltext: 'Department',
                        //   value: department,
                        //   validator: Validatorless.required('*กรุณากรอกข้อมูล'),
                        //   items: departmentList?.map((e) {
                        //     return DropdownMenuItem<String>(
                        //       value: e.deptCode.toString(),
                        //       child: SizedBox(
                        //           width: 300,
                        //           child: Text(
                        //               '${e.deptNameEn} : ${e.deptNameTh == "NULL" ? '-' : e.deptNameTh}')),
                        //     );
                        //   }).toList(),
                        //   onChanged: (newValue) {
                        //     setState(() {
                        //       department = newValue.toString();
                        //     });
                        //   },
                        // ),
                        const Gap(5),
                        DropdownMenuGlobal(
                            label: "Parent Organization",
                            width: 442,
                            controller: parentOrgMenu,
                            onSelected: (value) {
                              setState(() {
                                parentOrg = value.toString();
                              });
                            },
                            dropdownMenuEntries: parentOrgList.map((e) {
                              return DropdownMenuEntry(
                                  value: e.organizationCode,
                                  label:
                                      "${e.organizationCode} : ${e.organizationName}",
                                  style: MenuItemButton.styleFrom());
                            }).toList()),
                        // DropdownGlobal(
                        //   labeltext: 'อยู่ภายใต้',
                        //   value: parentOrg,
                        //   validator: Validatorless.required('*กรุณากรอกข้อมูล'),
                        //   items: parentOrgList?.map((e) {
                        //     return DropdownMenuItem<String>(
                        //       value: e.organizationCode.toString(),
                        //       child: SizedBox(
                        //           width: 320,
                        //           child: Text(
                        //               '${e.organizationCode} : ${e.organizationName}')),
                        //     );
                        //   }).toList(),
                        //   onChanged: (newValue) {
                        //     setState(() {
                        //       parentOrg = newValue.toString();
                        //     });
                        //   },
                        // ),
                        const Gap(5),
                        DropdownGlobal(
                          labeltext: 'ประเภท',
                          value: orgType,
                          validator: Validatorless.required('*กรุณากรอกข้อมูล'),
                          items: orgTypeList.map((e) {
                            return DropdownMenuItem<String>(
                              value: e.organizationTypeId.toString(),
                              child: SizedBox(
                                  width: 100,
                                  child: Text(e.organizationTypeName)),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              orgType = newValue.toString();
                            });
                          },
                        ),
                        const Gap(5),
                        TextFormFieldDatepickGlobal(
                            controller: validFrom,
                            labelText: 'มีผลตั้งแต่',
                            validatorless:
                                Validatorless.required('*กรุณากรอกข้อมูล'),
                            ontap: () {
                              selectvalidFromDate();
                            }),
                        const Gap(5),
                        TextFormFieldDatepickGlobal(
                            controller: expFrom,
                            labelText: 'สิ้นสุดเมื่อ',
                            validatorless:
                                Validatorless.required('*กรุณากรอกข้อมูล'),
                            ontap: () {
                              selectexpDate();
                            }),
                      ]),
                    ),
                  ),
                  if (widget.onEdit == false)
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: BlocBuilder<OrganizationBloc, OrganizationState>(
                          builder: (context, state) {
                            return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.greenAccent,
                                ),
                                onPressed:
                                    department == null || parentOrg == null
                                        ? null
                                        : () {
                                            onAdd();
                                          },
                                child: const Text(
                                  "Add",
                                  style: TextStyle(color: Colors.black87),
                                ));
                          },
                        ),
                      ),
                    )
                  else
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: BlocBuilder<OrganizationBloc, OrganizationState>(
                          builder: (context, state) {
                            return Row(
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
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .horizontal(
                                                              left: Radius
                                                                  .circular(
                                                                      8))),
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
                                              style: TextStyle(
                                                  color: Colors.black87),
                                            )),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation:
                                                  status == false ? 2 : 0,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .horizontal(
                                                              right: Radius
                                                                  .circular(
                                                                      8))),
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
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.greenAccent,
                                    ),
                                    onPressed:
                                        department == null || parentOrg == null
                                            ? null
                                            : () {
                                                showdialogEdit();
                                              },
                                    child: const Text(
                                      "Save",
                                      style: TextStyle(color: Colors.black87),
                                    )),
                              ],
                            );
                          },
                        ),
                      ),
                    )
                ],
              ),
            ),
          );
  }
}
