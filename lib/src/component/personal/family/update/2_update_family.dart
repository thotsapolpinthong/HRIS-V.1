import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hris_app_prototype/src/model/family_member/dropdown/family_type_model.dart';
import 'package:hris_app_prototype/src/model/family_member/dropdown/vital_status_model.dart';
import 'package:hris_app_prototype/src/model/family_member/get_family_by_id_model.dart';
import 'package:hris_app_prototype/src/model/family_member/update/update_family.dart';
import 'package:hris_app_prototype/src/model/person/dropdown/title.dart';
import 'package:hris_app_prototype/src/services/api_personal_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class UpdateFamily extends StatefulWidget {
  final String personId;
  final FamilyMemberDatum familydata;
  const UpdateFamily(
      {super.key, required this.personId, required this.familydata});

  @override
  State<UpdateFamily> createState() => _UpdateFamilyState();
}

class _UpdateFamilyState extends State<UpdateFamily> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isloading = false;
  bool disableExp = false;

  List<FamilyMembersTypeDatum>? familymemberList = [];
  String? familymember;

  List<VitalStatusDatum>? vitalStatusList = [];
  String? vitalStatus;

  List<TitleNameDatum>? titlenameList = [];
  String? titlename;

  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController midname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController comment = TextEditingController();

  @override
  initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    familymemberList = await ApiService.getFamilyTypeDropdown();
    vitalStatusList = await ApiService.getVitalStatusDropdown();
    TitleModel title = await ApiService.getTitle();
    setState(() {
      titlenameList = title.titleNameData;
      familymember = widget.familydata.familyMemberTypeData.familyMemberTypeId;
      vitalStatus = widget.familydata.vitalStatusData.vitalStatusId;
      titlename = widget.familydata.titleNameData.titleNameId;
      dateOfBirth.text = widget.familydata.dateOfBirth;
      firstname.text = widget.familydata.firstName;
      midname.text = widget.familydata.midName;
      lastname.text = widget.familydata.lastName;

      if (midname.text == 'ไม่ระบุข้อมูล') {
        midname.text = '';
      }
    });
  }

  Future<void> _selectDate() async {
    DateTime? _picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 18 * 365)),
      firstDate: DateTime.now().subtract(const Duration(days: 70 * 365)),
      lastDate: DateTime.now().subtract(const Duration(days: 18 * 365)),
    );
    if (_picker != null) {
      setState(() {
        dateOfBirth.text = _picker.toString().split(" ")[0];
      });
    }
  }

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
                width: 100,
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: Text('หมายเหตุ (โปรดระบุ)')),
                    Card(
                      elevation: 2,
                      child: TextFormField(
                        controller: comment,
                        decoration: const InputDecoration(
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            filled: true,
                            fillColor: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                onUpdate();
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

  onUpdate() async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    UpdateFamilyModel updateFamilyModel = UpdateFamilyModel(
      familyMemberId: widget.familydata.familyMemberId,
      personId: widget.personId,
      familyMemberTypeId: familymember.toString(),
      titleNameId: titlename.toString(),
      firstName: firstname.text,
      midName: midname.text,
      lastName: lastname.text,
      dateOfBirth: dateOfBirth.text,
      vitalStatusId: vitalStatus.toString(),
      modifiedBy: employeeId,
      comment: comment.text,
    );
    bool success = await ApiService.updateFamilyById(updateFamilyModel);

    setState(() {
      if (success == true) {
        AwesomeDialog(
          dismissOnTouchOutside: false,
          width: 500,
          context: context,
          animType: AnimType.topSlide,
          dialogType: DialogType.success,
          body: const Center(
            child: Column(
              children: [
                Text(
                  'Edit Family Member Information Success.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'แก้ไขข้อมูลครอบครัว สำเร็จ',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          btnOkOnPress: () {
            setState(() {});
          },
        ).show();
      } else {
        AwesomeDialog(
          dismissOnTouchOutside: false,
          width: 500,
          context: context,
          animType: AnimType.topSlide,
          dialogType: DialogType.error,
          body: const Center(
            child: Column(
              children: [
                Text(
                  'Edit Family Member Information Fail.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'แก้ไขข้อมูลครอบครัว ไม่สำเร็จ',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          btnOkColor: Colors.red,
          btnOkOnPress: () {
            setState(() {});
          },
        ).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isloading == true
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              color: Colors.grey[100],
              child: Column(
                children: [
                  Expanded(
                      flex: 12,
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 2, 2, 8),
                                        child: DropdownButtonFormField(
                                          decoration: const InputDecoration(
                                              labelText:
                                                  'Relationship : ความสัมพันธ์',
                                              labelStyle: TextStyle(
                                                  color: Colors.black87),
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: Colors.white),
                                          autovalidateMode:
                                              AutovalidateMode.always,
                                          validator: Validatorless.required(
                                              'กรุณากรอกข้อมูล'),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          value: familymember,
                                          items: familymemberList?.map((e) {
                                            return DropdownMenuItem<String>(
                                              value: e.familyMemberTypeId
                                                  .toString(),
                                              child: SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                      e.familyMemberTypeName)),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              familymember =
                                                  newValue.toString();
                                              if (familymember == '1') {
                                                titlename = '1';
                                              } else if (familymember == '2') {
                                                titlename = '2';
                                              } else {
                                                titlename = null;
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            2, 2, 0, 8),
                                        child: DropdownButtonFormField(
                                          decoration: const InputDecoration(
                                              labelText: 'Status : สถานะ',
                                              labelStyle: TextStyle(
                                                  color: Colors.black87),
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          autovalidateMode:
                                              AutovalidateMode.always,
                                          validator: Validatorless.required(
                                              'กรุณากรอกข้อมูล'),
                                          value: vitalStatus,
                                          items: vitalStatusList?.map((e) {
                                            return DropdownMenuItem<String>(
                                              value: e.vitalStatusId.toString(),
                                              child: SizedBox(
                                                  width: 100,
                                                  child:
                                                      Text(e.vitalStatusName)),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              vitalStatus = newValue.toString();
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            2, 2, 0, 8),
                                        child: DropdownButtonFormField(
                                          decoration: const InputDecoration(
                                              labelText: 'Title : คำนำหน้า',
                                              labelStyle: TextStyle(
                                                  color: Colors.black87),
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          autovalidateMode:
                                              AutovalidateMode.always,
                                          validator: Validatorless.required(
                                              'กรุณากรอกข้อมูล'),
                                          value: titlename,
                                          items: titlenameList?.map((e) {
                                            return DropdownMenuItem<String>(
                                              value: e.titleNameId.toString(),
                                              child: SizedBox(
                                                  width: 150,
                                                  child: Text(
                                                      '${e.titleNameEn} : ${e.titleNameTh}')),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              titlename = newValue.toString();
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            2, 2, 0, 8),
                                        child: TextFormField(
                                          autovalidateMode:
                                              AutovalidateMode.always,
                                          validator: Validatorless.required(
                                              'กรุณากรอกข้อมูล'),
                                          controller: dateOfBirth,
                                          decoration: const InputDecoration(
                                              labelText: 'Birthday : วันเกิด',
                                              labelStyle: TextStyle(
                                                  color: Colors.black),
                                              filled: true,
                                              fillColor: Colors.white,
                                              suffixIcon: Icon(
                                                Icons.calendar_today,
                                              ),
                                              border: OutlineInputBorder()),
                                          readOnly: true,
                                          onTap: () {
                                            _selectDate();
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                  child: TextFormField(
                                    autovalidateMode: AutovalidateMode.always,
                                    validator: Validatorless.multiple([
                                      Validatorless.required('กรุณากรอกข้อมูล'),
                                    ]),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[a-zA-Zก-๙]')),
                                    ],
                                    controller: firstname,
                                    decoration: const InputDecoration(
                                        labelText: 'Firstname : ชื่อ',
                                        labelStyle:
                                            TextStyle(color: Colors.black87),
                                        border: OutlineInputBorder(),
                                        filled: true,
                                        fillColor: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                  child: TextFormField(
                                    autovalidateMode: AutovalidateMode.always,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[a-zA-Zก-๙]')),
                                    ],
                                    controller: midname,
                                    decoration: const InputDecoration(
                                        hintText: '(ถ้ามี)',
                                        labelText: 'Midname : ชื่อกลาง',
                                        labelStyle:
                                            TextStyle(color: Colors.black87),
                                        border: OutlineInputBorder(),
                                        filled: true,
                                        fillColor: Colors.white),
                                  ),
                                ),
                                TextFormField(
                                  autovalidateMode: AutovalidateMode.always,
                                  validator: Validatorless.multiple([
                                    Validatorless.required('กรุณากรอกข้อมูล'),
                                  ]),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[a-zA-Zก-๙]')),
                                  ],
                                  controller: lastname,
                                  decoration: const InputDecoration(
                                      labelText: 'Lastname : นามสกุล',
                                      labelStyle:
                                          TextStyle(color: Colors.black87),
                                      border: OutlineInputBorder(),
                                      filled: true,
                                      fillColor: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.greenAccent, // Background color
                          // Text Color (Foreground color)
                        ),
                        child: Text('Save',
                            style: TextStyle(
                              color: Colors.grey[800],
                            )),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // การตรวจสอบผ่านแล้ว
                            // ทำสิ่งที่คุณต้องการเมื่อข้อมูลถูกกรอกถูกต้อง
                            showdialogEdit();
                          } else {
                            // การตรวจสอบไม่ผ่าน
                            // ทำสิ่งที่คุณต้องการเมื่อข้อมูลไม่ถูกต้อง
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
