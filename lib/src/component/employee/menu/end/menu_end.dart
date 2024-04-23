// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/resign_menu_model/new_resign_model.dart';
import 'package:hris_app_prototype/src/services/api_employee_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EndofEmploymentMenu extends StatefulWidget {
  final EmployeeDatum employeeData;
  const EndofEmploymentMenu({
    Key? key,
    required this.employeeData,
  }) : super(key: key);

  @override
  State<EndofEmploymentMenu> createState() => _EndofEmploymentMenuState();
}

class _EndofEmploymentMenuState extends State<EndofEmploymentMenu> {
  bool isDataLoading = true;
  TextEditingController resignDate = TextEditingController();
  TextEditingController hrDate = TextEditingController();
  TextEditingController accDate = TextEditingController();

  Future<void> selectvalidFromDate(int type) async {
    DateTime? picker = await showDatePicker(
      // selectableDayPredicate: (DateTime val) => val.weekday == 7 ? false : true,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(9999),
    );
    if (picker != null) {
      setState(() {
        if (type == 0) {
          resignDate.text = picker.toString().split(" ")[0];
        } else if (type == 1) {
          hrDate.text = picker.toString().split(" ")[0];
        } else {
          accDate.text = picker.toString().split(" ")[0];
        }
      });
    }
  }

  alertDialogInfo() {
    AwesomeDialog(
            width: 400,
            context: context,
            animType: AnimType.topSlide,
            dialogType: DialogType.info,
            title: "INFO",
            desc:
                'สิ้นสุดการเป็นพนักงาน\n${widget.employeeData.personData.titleName.titleNameTh} ${widget.employeeData.personData.fisrtNameTh} ${widget.employeeData.personData.lastNameTh}',
            btnOkColor: Colors.red[700],
            btnOkText: "Accept",
            btnOkOnPress: () {
              newTransfer();
            },
            btnCancelOnPress: () {},
            btnCancelColor: Colors.greenAccent)
        .show();
  }

  newTransfer() async {
    String? employeeId;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId");
    NewResignModel newModel = NewResignModel(
        employeeId: widget.employeeData.employeeId,
        endDate: resignDate.text,
        hrEndDate: hrDate.text,
        accEndDate: accDate.text,
        createBy: employeeId.toString());

    bool success = await ApiEmployeeService.newResignEmployee(newModel);
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
                success == true ? 'Resign Success.' : 'Resign Fail.',
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
              "Resign",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child:
                  // isDataLoading == true
                  //     ? myLoadingScreen
                  //     :
                  Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Gap(20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TextThai(text: "ตำแหน่งปัจจุบัน"),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                      const TextThai(text: "สิ้นสุดการเป็นพนักงาน"),
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
                                  TextFormFieldDatepickGlobal(
                                      controller: resignDate,
                                      labelText:
                                          "วันที่สิ้นสุดเป็นพนักงาน (ตามข้อบังคับ)",
                                      validatorless: null,
                                      ontap: () {
                                        selectvalidFromDate(0);
                                      }),
                                  const Gap(10),
                                  TextFormFieldDatepickGlobal(
                                      controller: hrDate,
                                      labelText:
                                          "วันที่สิ้นสุดในระบบฝ่ายบุคคล (Hr.)",
                                      validatorless: null,
                                      ontap: () {
                                        selectvalidFromDate(1);
                                      }),
                                  const Gap(10),
                                  TextFormFieldDatepickGlobal(
                                      controller: accDate,
                                      labelText:
                                          "วันที่สิ้นสุดในระบบบัญชี (Accounting.)",
                                      validatorless: null,
                                      ontap: () {
                                        selectvalidFromDate(2);
                                      }),
                                  const Gap(10),
                                  Expanded(child: Container()),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        alertDialogInfo();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red[600]),
                                      child: const Text("Confirm"),
                                    ),
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
