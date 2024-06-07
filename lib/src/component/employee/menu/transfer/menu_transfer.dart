// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/employee/dropdown_stafftype_model.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/promote_menu_model/dropdown_promote_type_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/transfer_menu_model/new_transfer_model.dart';
import 'package:hris_app_prototype/src/model/organization/organization/dropdown/parent_org_dd_model.dart';
import 'package:hris_app_prototype/src/model/organization/position_org/get_position_org_by_org_id_model.dart';
import 'package:hris_app_prototype/src/services/api_employee_service.dart';
import 'package:hris_app_prototype/src/services/api_org_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class TransferMenu extends StatefulWidget {
  final EmployeeDatum employeeData;
  const TransferMenu({
    Key? key,
    required this.employeeData,
  }) : super(key: key);

  @override
  State<TransferMenu> createState() => _TransferMenuState();
}

class _TransferMenuState extends State<TransferMenu> {
  bool isDataLoading = true;
  TextEditingController transferStartDate = TextEditingController();
  TextEditingController transferSalary = TextEditingController();
  List<PositionOrganizationDatum> positionOrgList = [];
  String? positionOrgId;
  List<StaffTypeDatum> staffTypeList = [];
  String? staffTypeId;
  List<OrganizationDataam> orgDataList = [];
  String? orgId;
  List<PromoteTypeDatum> promoteTypeList = [];
  String? promoteTypeId;

  Future<void> selectvalidFromDate() async {
    DateTime? picker = await showDatePicker(
      // selectableDayPredicate: (DateTime val) => val.weekday == 7 ? false : true,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(9999),
    );
    if (picker != null) {
      setState(() {
        transferStartDate.text = picker.toString().split(" ")[0];
      });
    }
  }

  Future fetchDataDropdown() async {
    orgDataList = await ApiOrgService.getParentOrgDropdown();
    staffTypeList = await ApiEmployeeService.getStaffTypeDropdown();
    promoteTypeList = await ApiEmployeeService.getPromoteTypeDropdown();
    setState(() {
      orgDataList;
      staffTypeList;
      promoteTypeList;
      staffTypeId =
          widget.employeeData.positionData.positionTypeData.positionTypeId;
      isDataLoading = false;
    });
  }

  alertDialogInfo() {
    AwesomeDialog(
      width: 400,
      context: context,
      animType: AnimType.topSlide,
      dialogType: DialogType.info,
      title: "INFO",
      desc:
          'ต้องการย้ายพนักงาน\n${widget.employeeData.personData.titleName.titleNameTh} ${widget.employeeData.personData.fisrtNameTh} ${widget.employeeData.personData.lastNameTh}',
      btnOkText: "Accept",
      btnOkOnPress: () {
        newTransfer();
      },
      btnCancelOnPress: () {},
    ).show();
  }

  newTransfer() async {
    String? employeeId;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId");
    NewTransferModel newModel = NewTransferModel(
        staffTypeId: staffTypeId.toString(),
        positionOrganizationId: positionOrgId.toString(),
        employeeId: widget.employeeData.employeeId,
        baseSalary: transferSalary.text,
        startDate: transferStartDate.text,
        createBy: employeeId.toString());

    bool success = await ApiEmployeeService.newTransferEmployee(newModel);
    alertDialog(success);
  }

  alertDialog(bool success) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      width: 450,
      context: context,
      animType: AnimType.topSlide,
      dialogType: success == true ? DialogType.success : DialogType.error,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Column(
            children: [
              Text(
                success == true ? 'Transfer Success.' : 'Transfer Fail.',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              Text(
                success == true
                    ? 'บันทึกข้อมูล สำเร็จ'
                    : 'บันทึกข้อมูล ไม่สำเร็จ',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
      btnOkColor: success == true ? Colors.greenAccent : Colors.red,
      btnOkOnPress: () {
        if (success == true) {
          Navigator.pop(context);
        } else {}
      },
    ).show();
  }

  @override
  void initState() {
    super.initState();
    fetchDataDropdown();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const Text(
              "Transfer",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: isDataLoading == true
                  ? myLoadingScreen
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Gap(20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const TextThai(text: "ตำแหน่งเดิม"),
                            Card(
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)),
                                color: mygreycolors,
                                child: SizedBox(
                                  height: 500,
                                  width: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Gap(12),
                                        const Center(
                                          child: Icon(
                                            CupertinoIcons.person_alt_circle,
                                            size: 140,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const Gap(12),
                                        TextThai(
                                            text:
                                                "รหัสพนักงาน :  ${widget.employeeData.employeeId}"),
                                        const Gap(10),
                                        TextThai(
                                            text:
                                                "ชื่อ : ${widget.employeeData.personData.fisrtNameTh} ${widget.employeeData.personData.lastNameTh}"),
                                        const Gap(10),
                                        TextThai(
                                            text:
                                                "ประเภทพนักงาน : ${widget.employeeData.staffTypeData.description}"),
                                        const Gap(10),
                                        TextThai(
                                            text:
                                                "แผนก : ${widget.employeeData.positionData.organizationData.departMentData.deptNameTh}"),
                                        const Gap(10),
                                        TextThai(
                                            text:
                                                "ตำแหน่ง : ${widget.employeeData.positionData.positionData.positionNameTh}"),
                                        const Gap(10),
                                        TextThai(
                                            text:
                                                "กะการทำงาน : ${widget.employeeData.shiftData.shiftName}"),
                                        const Gap(10),
                                        TextThai(
                                            text:
                                                "เวลาทำงาน : ${widget.employeeData.shiftData.startTime} - ${widget.employeeData.shiftData.endTime}"),
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        Transform.flip(
                          flipX: true,
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 70,
                            color: Colors.grey[700],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const TextThai(text: "ย้ายตำแหน่งใหม่"),
                            Card(
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)),
                                color: mygreycolors,
                                child: SizedBox(
                                  height: 500,
                                  width: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        const Gap(12),
                                        DropdownGlobal(
                                            labeltext: 'ประเภทการปรับตำแหน่ง',
                                            value: promoteTypeId,
                                            items: promoteTypeList.map((e) {
                                              return DropdownMenuItem<String>(
                                                value:
                                                    e.promoteTypeId.toString(),
                                                child: Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                            minWidth: 150),
                                                    child: Text(
                                                        e.promoteTypeName)),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                promoteTypeId =
                                                    newValue.toString();
                                              });
                                            },
                                            validator: null),
                                        const Gap(10),
                                        DropdownGlobal(
                                            labeltext: 'ประเภทพนักงาน ( ใหม่ )',
                                            value: staffTypeId,
                                            items: staffTypeList.map((e) {
                                              return DropdownMenuItem<String>(
                                                value: e.staffTypeId.toString(),
                                                child: Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                            minWidth: 150),
                                                    child: Text(e.description)),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                staffTypeId =
                                                    newValue.toString();
                                              });
                                            },
                                            validator: null),
                                        const Gap(10),
                                        DropdownGlobal(
                                            labeltext: 'แผนก ( ใหม่ )',
                                            value: orgId,
                                            items: orgDataList.map((e) {
                                              return DropdownMenuItem<String>(
                                                value: e.organizationCode
                                                    .toString(),
                                                child: Container(
                                                    width: 180,
                                                    constraints:
                                                        const BoxConstraints(
                                                            maxHeight: 150,
                                                            minWidth: 180),
                                                    child: Text(
                                                        e.organizationName)),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) async {
                                              setState(() {
                                                orgId = newValue.toString();
                                                positionOrgList = [];
                                                positionOrgId = null;
                                              });
                                              GetPositionOrgByOrgIdModel?
                                                  position = await ApiOrgService
                                                      .fetchPositionOrgByOrgId(
                                                          orgId!);
                                              if (position != null) {
                                                setState(() {
                                                  positionOrgList = position
                                                      .positionOrganizationData
                                                      .where((element) =>
                                                          element.employeeData
                                                              .employeeId ==
                                                          "")
                                                      .toList();
                                                  ;
                                                });
                                              }
                                            },
                                            validator: null),
                                        const Gap(10),
                                        DropdownGlobal(
                                            labeltext: 'ตำแหน่งงาน ( ใหม่ )',
                                            value: positionOrgId,
                                            items: positionOrgList.map((e) {
                                              return DropdownMenuItem<String>(
                                                value: e.positionOrganizationId
                                                    .toString(),
                                                child: Container(
                                                    width: 180,
                                                    constraints:
                                                        const BoxConstraints(
                                                            minWidth: 150),
                                                    child: Text(e.employeeData
                                                                .employeeId ==
                                                            ""
                                                        ? e.positionData
                                                            .positionNameTh
                                                        : "ตำแหน่งงานไม่ว่าง")),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                positionOrgId =
                                                    newValue.toString();
                                              });
                                            },
                                            validator: null),
                                        const Gap(10),
                                        TextFormFieldDatepickGlobal(
                                            controller: transferStartDate,
                                            labelText: "วันที่เริ่มปรับตำแหน่ง",
                                            validatorless: null,
                                            ontap: () {
                                              selectvalidFromDate();
                                            }),
                                        const Gap(10),
                                        TextFormFieldGlobal(
                                            controller: transferSalary,
                                            labelText: "ฐานเงินเดือนใหม่",
                                            hintText: "",
                                            validatorless:
                                                Validatorless.required(
                                                    "โปรดระบุเงินเดือนใหม่"),
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9.0-9/]'))
                                            ],
                                            enabled: true),
                                        Expanded(child: Container()),
                                        MySaveButtons(
                                          text: "Confirm",
                                          onPressed: promoteTypeId == null ||
                                                  orgId == null ||
                                                  positionOrgId == null ||
                                                  transferStartDate.text == ""
                                              ? null
                                              : () {
                                                  setState(() {
                                                    alertDialogInfo();
                                                  });
                                                },
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        const Gap(20),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
