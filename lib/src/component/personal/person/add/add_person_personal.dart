import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hris_app_prototype/src/model/person/createperson_model.dart';
import 'package:hris_app_prototype/src/model/person/dropdown/bloodgroup_model.dart';
import 'package:hris_app_prototype/src/model/person/dropdown/gender_model.dart';
import 'package:hris_app_prototype/src/model/person/dropdown/maritalstatus_model.dart';
import 'package:hris_app_prototype/src/model/person/dropdown/national_model.dart';
import 'package:hris_app_prototype/src/model/person/dropdown/race_model.dart';
import 'package:hris_app_prototype/src/model/person/dropdown/religion.model.dart';
import 'package:hris_app_prototype/src/model/person/dropdown/title.dart';
import 'package:hris_app_prototype/src/services/api_web_service.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:validatorless/validatorless.dart';

class Addpersonal extends StatefulWidget {
  final String personId;
  const Addpersonal({super.key, required this.personId});

  @override
  State<Addpersonal> createState() => _AddpersonalState();
}

class _AddpersonalState extends State<Addpersonal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController personId = TextEditingController();
  TextEditingController firstNameTh = TextEditingController();
  TextEditingController midNameTh = TextEditingController();
  TextEditingController lastNameTh = TextEditingController();
  TextEditingController firstNameEn = TextEditingController();
  TextEditingController midNameEn = TextEditingController();
  TextEditingController lastNameEn = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController phoneNumber1 = TextEditingController();
  TextEditingController phoneNumber2 = TextEditingController();
//dropdown ----------------------------------------------------------------
  List<TitleNameDatum> titleList = [];
  String? titles;
  List<GenderDatum> genderList = [];
  String? genders;
  List<BloodGroupDatum> bloodgroupList = [];
  String? bloodgroup;
  List<MaritalStatusDatum> maritalstatusList = [];
  String? maritalstatus;
  List<RaceDatum> raceList = [];
  String? racestatus;
  List<ReligionDatum> religionList = [];
  String? religion;
  List<NationalityDatum> nationalityList = [];
  String? nationality;

  bool isloading = true;

  @override
  void initState() {
    personId.text = widget.personId.toString();
    fetchPersonById();
    super.initState();
  }

  Future<void> fetchPersonById() async {
    TitleModel _titledata = await ApiService.getTitle();
    GenderModel _gender = await ApiService.getGender();
    BloodGroupModel _blood = await ApiService.getBloodGroup();
    MaritalStatusModel _marital = await ApiService.getMaritalStatus();
    RaceModel _race = await ApiService.getRaceStatus();
    ReligionModel _religion = await ApiService.getReligionStatus();
    NationalityModel _nationality = await ApiService.getNationalityStatus();

    setState(() {
      titleList = _titledata.titleNameData;
      genderList = _gender.genderData;
      bloodgroupList = _blood.bloodGroupData;
      maritalstatusList = _marital.maritalStatusData;
      raceList = _race.raceData;
      religionList = _religion.religionData;
      nationalityList = _nationality.nationalityData;
      isloading = false;
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

  Future<void> onSave() async {
    PersonCreateModel updatepersondata = PersonCreateModel(
      personId: personId.text,
      titleNameId: titles.toString(),
      firstNameTh: firstNameTh.text,
      firstNameEn: firstNameEn.text,
      midNameTh: midNameTh.text,
      midNameEn: midNameEn.text,
      lastNameTh: lastNameTh.text,
      lastNameEn: lastNameEn.text,
      email: email.text,
      dateOfBirth: dateOfBirth.text,
      height: height.text,
      weight: weight.text,
      bloodGroupId: bloodgroup.toString(),
      genderId: genders.toString(),
      maritalStatusId: maritalstatus.toString(),
      nationalityId: nationality.toString(),
      raceId: racestatus.toString(),
      religionId: religion.toString(),
      phoneNumber1: phoneNumber1.text,
      phoneNumber2: phoneNumber2.text,
    );

    bool _isaddperson = await ApiService.addPersonalData(updatepersondata);
    setState(() {
      if (_isaddperson == true) {
        AwesomeDialog(
          width: 500,
          context: context,
          animType: AnimType.topSlide,
          dialogType: DialogType.success,
          body: const Center(
            child: Text(
              'Add Person Success.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          btnOkOnPress: () {
            setState(() {
              fetchPersonById();
            });
          },
        ).show();
      } else {
        AwesomeDialog(
          width: 500,
          context: context,
          animType: AnimType.topSlide,
          dialogType: DialogType.error,
          body: const Center(
            child: Text(
              'Add Person Fail',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          btnOkColor: Colors.red,
          btnOkOnPress: () {
            setState(() {});
          },
        ).show();
      }
    });

    // Handle erroe
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Card(
                        elevation: 4,
                        color: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Expanded(
                            child: Icon(
                          Icons.photo_camera_rounded,
                          color: Colors.grey[700],
                          size: 100,
                        )),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {}, child: const Text('Upload'))
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Card(
                          color: Colors.grey[200],
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(8))),
                          child: const SizedBox(
                            height: 32,
                            width: 140,
                            child: Center(
                                child: Text('ข้อมูลส่วนตัว',
                                    style: TextStyle(fontSize: 16))),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SizedBox(
                            height: 405,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Card(
                                        elevation: 2,
                                        child: TextField(
                                          controller: personId,
                                          enabled: false,
                                          decoration: const InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              labelText:
                                                  "PersonID : รหัสประจำตัว",
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black26),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white))),
                                          readOnly: true,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Card(
                                        child: SizedBox(
                                          height: 53,
                                          child: DropdownButtonFormField(
                                            autovalidateMode:
                                                AutovalidateMode.always,
                                            validator: (newValue) {
                                              if (newValue == '0') {
                                                return 'โปรดเลือกข้อมูล';
                                              }
                                              return null; // ไม่มีข้อผิดพลาด
                                            },
                                            focusColor: Colors.white,
                                            hint: const Text("TitleName*",
                                                style: TextStyle(
                                                    color: Colors.red)),
                                            value: titles,
                                            items: titleList.map((e) {
                                              return DropdownMenuItem<String>(
                                                value: e.titleNameId,
                                                child: Text(
                                                    '${e.titleNameEn} : ${e.titleNameTh}'),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                titles = newValue.toString();
                                                if (titles == '1') {
                                                  genders = '1';
                                                } else if (titles == '2' ||
                                                    titles == '3') {
                                                  genders = '2';
                                                } else {
                                                  genders = '0';
                                                }
                                              });
                                            },
                                            dropdownColor: Colors.white,
                                            decoration: const InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              labelText: "Titlename : คำนำหน้า",
                                              labelStyle: TextStyle(
                                                  color: Colors.black),
                                              border: OutlineInputBorder(),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black26),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Card(
                                        child: TextFormField(
                                          autovalidateMode:
                                              AutovalidateMode.always,
                                          keyboardType: TextInputType.text,
                                          validator: RequiredValidator(
                                              errorText: 'กรุณากรอกข้อมูล'),
                                          controller: firstNameTh,
                                          decoration: const InputDecoration(
                                              labelText: 'ชื่อ (TH)',
                                              labelStyle: TextStyle(
                                                  color: Colors.black),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black26),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Card(
                                        child: TextFormField(
                                          autovalidateMode:
                                              AutovalidateMode.always,
                                          keyboardType: TextInputType.text,
                                          validator: RequiredValidator(
                                              errorText: 'กรุณากรอกข้อมูล'),
                                          controller: lastNameTh,
                                          decoration: const InputDecoration(
                                              labelText: 'นามสกุล (TH)',
                                              labelStyle: TextStyle(
                                                  color: Colors.black),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black26),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Card(
                                        child: TextFormField(
                                          autovalidateMode:
                                              AutovalidateMode.always,
                                          keyboardType: TextInputType.text,
                                          validator: RequiredValidator(
                                              errorText: 'กรุณากรอกข้อมูล'),
                                          controller: firstNameEn,
                                          decoration: const InputDecoration(
                                              labelText: 'Name (EN)',
                                              labelStyle: TextStyle(
                                                  color: Colors.black),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black26),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Card(
                                        child: TextFormField(
                                          autovalidateMode:
                                              AutovalidateMode.always,
                                          keyboardType: TextInputType.text,
                                          validator: RequiredValidator(
                                              errorText: 'กรุณากรอกข้อมูล'),
                                          controller: lastNameEn,
                                          decoration: const InputDecoration(
                                              labelText: 'Lastname (EN)',
                                              labelStyle: TextStyle(
                                                  color: Colors.black),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black26),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Card(
                                  child: TextFormField(
                                    autovalidateMode: AutovalidateMode.always,
                                    validator: RequiredValidator(
                                        errorText: 'กรุณากรอกข้อมูล'),
                                    controller: dateOfBirth,
                                    decoration: const InputDecoration(
                                      labelText: 'Date of birth',
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      filled: true,
                                      fillColor: Colors.white,
                                      suffixIcon: Icon(
                                        Icons.calendar_today,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black26),
                                      ),
                                    ),
                                    readOnly: true,
                                    onTap: () {
                                      _selectDate();
                                    },
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Card(
                                        elevation: 1,
                                        child: TextFormField(
                                          autovalidateMode:
                                              AutovalidateMode.always,
                                          keyboardType: TextInputType.number,
                                          validator: Validatorless.multiple([
                                            Validatorless.min(
                                                3, 'กรอกข้อมูลให้ถูกต้อง'),
                                            Validatorless.max(
                                                3, 'กรอกข้อมูลให้ถูกต้อง'),
                                            Validatorless.required(
                                                'กรุณากรอกข้อมูล')
                                          ]),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(
                                                    r'[0-9]')), // ใช้ input formatter เพื่อจำกัดให้เป็นตัวเลขเท่านั้น
                                          ],
                                          controller: height,
                                          decoration: const InputDecoration(
                                              labelText: 'ส่วนสูง (cm.)',
                                              labelStyle: TextStyle(
                                                  color: Colors.black),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black26),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Card(
                                        child: TextFormField(
                                          autovalidateMode:
                                              AutovalidateMode.always,
                                          validator: Validatorless.multiple([
                                            Validatorless.min(
                                                2, 'กรอกข้อมูลให้ถูกต้อง'),
                                            Validatorless.max(
                                                3, 'กรอกข้อมูลให้ถูกต้อง'),
                                            Validatorless.required(
                                                'กรุณากรอกข้อมูล')
                                          ]),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(
                                                    r'[0-9]')), // ใช้ input formatter เพื่อจำกัดให้เป็นตัวเลขเท่านั้น
                                          ],
                                          controller: weight,
                                          decoration: const InputDecoration(
                                              labelText: 'น้ำหนัก (kg.)',
                                              labelStyle: TextStyle(
                                                  color: Colors.black),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black26),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 5,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Card(
                            color: Colors.grey[200],
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(8))),
                            child: const SizedBox(
                              height: 32,
                              width: 140,
                              child: Center(
                                  child: Text('ข้อมูลเพิ่มเติม',
                                      style: TextStyle(fontSize: 16))),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SizedBox(
                              height: 405,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Card(
                                          elevation: 2,
                                          child: SizedBox(
                                            height: 53,
                                            child: DropdownButtonFormField(
                                              autovalidateMode:
                                                  AutovalidateMode.always,
                                              validator: (newValue) {
                                                if (newValue == '0') {
                                                  return 'โปรดเลือกข้อมูล';
                                                }
                                                return null; // ไม่มีข้อผิดพลาด
                                              },
                                              focusColor: Colors.white,
                                              value: genders,
                                              items: genderList.map((e) {
                                                return DropdownMenuItem<String>(
                                                  value: e.genderId,
                                                  child: Text(
                                                      '${e.genderEn} : ${e.genderTh}'),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  genders = newValue.toString();
                                                });
                                              },
                                              hint: const Text("Gender (เพศ)*",
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                              dropdownColor: Colors.white,
                                              decoration: const InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                labelText: "Gender (เพศ)",
                                                labelStyle: TextStyle(
                                                    color: Colors.black),
                                                border: OutlineInputBorder(),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black26),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Card(
                                          elevation: 2,
                                          child: Container(
                                            height: 53,
                                            child: DropdownButtonFormField(
                                              autovalidateMode:
                                                  AutovalidateMode.always,
                                              focusColor: Colors.white,
                                              hint: const Text(
                                                  "Bloodtype (กรุ๊ปเลือด)*",
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                              value: bloodgroup,
                                              items: bloodgroupList.map((e) {
                                                return DropdownMenuItem<String>(
                                                  value: e.bloodId,
                                                  child: SizedBox(
                                                    width: 100,
                                                    child: Text(
                                                        '${e.bloodGroupNameEn} : ${e.bloodGroupNameTh}'),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  bloodgroup =
                                                      newValue.toString();
                                                });
                                              },
                                              validator: (newValue) {
                                                if (newValue ==
                                                    'Not specified') {
                                                  return 'โปรดเลือกข้อมูล';
                                                }
                                                return null; // ไม่มีข้อผิดพลาด
                                              },
                                              dropdownColor: Colors.white,
                                              decoration: const InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                labelText:
                                                    "Bloodtype (กรุ๊ปเลือด)",
                                                labelStyle: TextStyle(
                                                    color: Colors.black),
                                                border: OutlineInputBorder(),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black26),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Card(
                                          elevation: 2,
                                          child: SizedBox(
                                            height: 53,
                                            child: DropdownButtonFormField(
                                              autovalidateMode:
                                                  AutovalidateMode.always,
                                              validator: (newValue) {
                                                if (newValue == 'M000') {
                                                  return 'โปรดเลือกข้อมูล';
                                                }
                                                return null; // ไม่มีข้อผิดพลาด
                                              },
                                              focusColor: Colors.white,
                                              hint: const Text(
                                                  "Status (สถานะ)*",
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                              value: maritalstatus,
                                              items: maritalstatusList.map((e) {
                                                return DropdownMenuItem<String>(
                                                  value: e.maritalStatusId,
                                                  child:
                                                      Text(e.maritalStatusName),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  maritalstatus =
                                                      newValue.toString();
                                                });
                                              },
                                              dropdownColor: Colors.white,
                                              decoration: const InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                labelText: "Status (สถานะ)",
                                                labelStyle: TextStyle(
                                                    color: Colors.black),
                                                border: OutlineInputBorder(),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black26),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Card(
                                          elevation: 2,
                                          child: SizedBox(
                                            height: 53,
                                            child: DropdownButtonFormField(
                                              autovalidateMode:
                                                  AutovalidateMode.always,
                                              focusColor: Colors.white,
                                              hint: const Text(
                                                  "Religion (ศาสนา)*",
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                              value: religion,
                                              items: religionList.map((e) {
                                                return DropdownMenuItem<String>(
                                                  value: e.religionId,
                                                  child: Text(e.religionTh),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  religion =
                                                      newValue.toString();
                                                });
                                              },
                                              validator: (newValue) {
                                                if (newValue == '##') {
                                                  return 'โปรดเลือกข้อมูล';
                                                }
                                                return null; // ไม่มีข้อผิดพลาด
                                              },
                                              dropdownColor: Colors.white,
                                              decoration: const InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                labelText: "Religion (ศาสนา)",
                                                labelStyle: TextStyle(
                                                    color: Colors.black),
                                                border: OutlineInputBorder(),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black26),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Card(
                                          elevation: 2,
                                          child: SizedBox(
                                            height: 53,
                                            child: DropdownButtonFormField(
                                              autovalidateMode:
                                                  AutovalidateMode.always,
                                              focusColor: Colors.white,
                                              hint: const Text(
                                                  "Race (เชื้อชาติ)*",
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                              value: racestatus,
                                              items: raceList.map((e) {
                                                return DropdownMenuItem<String>(
                                                  value: e.raceId,
                                                  child: SizedBox(
                                                      width: 100,
                                                      child: Text(e.raceTh)),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  racestatus =
                                                      newValue.toString();
                                                });
                                              },
                                              validator: (newValue) {
                                                if (newValue == '000') {
                                                  return 'โปรดเลือกข้อมูล';
                                                }
                                                return null; // ไม่มีข้อผิดพลาด
                                              },
                                              dropdownColor: Colors.white,
                                              decoration: const InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                labelText: "Race (เชื้อชาติ)",
                                                labelStyle: TextStyle(
                                                    color: Colors.black),
                                                border: OutlineInputBorder(),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black26),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Card(
                                          elevation: 2,
                                          child: SizedBox(
                                            height: 53,
                                            child: DropdownButtonFormField(
                                              autovalidateMode:
                                                  AutovalidateMode.always,
                                              focusColor: Colors.white,
                                              hint: const Text(
                                                  "Nationality (สัญชาติ)*",
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                              value: nationality,
                                              items: nationalityList.map((e) {
                                                return DropdownMenuItem<String>(
                                                  value: e.nationalityId,
                                                  child: SizedBox(
                                                    width: 140,
                                                    child: Text(
                                                        '${e.nationalityEn} : ${e.nationalityTh}'),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  nationality =
                                                      newValue.toString();
                                                });
                                              },
                                              validator: (newValue) {
                                                if (newValue == 'NSPEC') {
                                                  return 'โปรดเลือกข้อมูล';
                                                }
                                                return null; // ไม่มีข้อผิดพลาด
                                              },
                                              dropdownColor: Colors.white,
                                              decoration: const InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                labelText:
                                                    "Nationality (สัญชาติ)",
                                                labelStyle: TextStyle(
                                                    color: Colors.black),
                                                border: OutlineInputBorder(),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black26),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Card(
                                    elevation: 2,
                                    child: TextFormField(
                                      validator: Validatorless.multiple([
                                        Validatorless.email(
                                            'admin@example.com'),
                                      ]),
                                      controller: email,
                                      decoration: const InputDecoration(
                                          hintText: 'E-mail',
                                          labelText: 'E-mail',
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black26),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Card(
                                          elevation: 2,
                                          child: TextFormField(
                                            autovalidateMode:
                                                AutovalidateMode.always,
                                            validator: Validatorless.multiple([
                                              Validatorless.required(
                                                  'กรอกตัวเลข 10 หลัก'),
                                              Validatorless.number(
                                                  'กรอกเฉพาะตัวเลข'),
                                              Validatorless.min(
                                                  10, 'กรอกให้ครบ 10 หลัก'),
                                              Validatorless.max(
                                                  10, 'เกิน 10 หลัก'),
                                            ]),
                                            controller: phoneNumber1,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(
                                                      r'[0-9]')), // ใช้ input formatter เพื่อจำกัดให้เป็นตัวเลขเท่านั้น
                                            ],
                                            decoration: const InputDecoration(
                                                hintText: 'เบอร์โทรศัพท์หลัก',
                                                labelText:
                                                    'Primary Phonenumber.',
                                                labelStyle: TextStyle(
                                                    color: Colors.black),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black26),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Card(
                                          elevation: 2,
                                          child: TextFormField(
                                            controller: phoneNumber2,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(
                                                      r'[0-9]')), // ใช้ input formatter เพื่อจำกัดให้เป็นตัวเลขเท่านั้น
                                            ],
                                            decoration: const InputDecoration(
                                                hintText:
                                                    'เบอร์โทรศัพท์รอง (ถ้ามี)',
                                                labelText:
                                                    'Secondary Phonenumber.',
                                                labelStyle: TextStyle(
                                                    color: Colors.black),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black26),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent, // Background color
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
                      onSave();
                    } else {
                      // การตรวจสอบไม่ผ่าน
                      // ทำสิ่งที่คุณต้องการเมื่อข้อมูลไม่ถูกต้อง
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
