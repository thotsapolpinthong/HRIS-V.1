import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/personal_bloc/personal_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/person/createperson_model.dart';
import 'package:hris_app_prototype/src/model/person/dropdown/bloodgroup_model.dart';
import 'package:hris_app_prototype/src/model/person/dropdown/gender_model.dart';
import 'package:hris_app_prototype/src/model/person/dropdown/maritalstatus_model.dart';
import 'package:hris_app_prototype/src/model/person/dropdown/national_model.dart';
import 'package:hris_app_prototype/src/model/person/dropdown/race_model.dart';
import 'package:hris_app_prototype/src/model/person/dropdown/religion.model.dart';
import 'package:hris_app_prototype/src/model/person/dropdown/title.dart';
import 'package:hris_app_prototype/src/services/api_personal_service.dart';

import 'package:validatorless/validatorless.dart';

class Addpersonal extends StatefulWidget {
  final String personId;
  const Addpersonal({super.key, required this.personId});

  @override
  State<Addpersonal> createState() => _AddpersonalState();
}

class _AddpersonalState extends State<Addpersonal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PersonCreateModel? onpersoncreatedmodel;
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
  //dropdown search
  TextEditingController racestatusMenu = TextEditingController();
  TextEditingController nationalityMenu = TextEditingController();
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
  bool isIconChanged = false;
  @override
  void initState() {
    personId.text = widget.personId.toString();
    fetchPersonById();
    super.initState();
  }

  Future<void> fetchPersonById() async {
    TitleModel titledata = await ApiService.getTitle();
    GenderModel gender = await ApiService.getGender();
    BloodGroupModel blood = await ApiService.getBloodGroup();
    MaritalStatusModel marital = await ApiService.getMaritalStatus();
    RaceModel race = await ApiService.getRaceStatus();
    ReligionModel religion = await ApiService.getReligionStatus();
    NationalityModel nationality = await ApiService.getNationalityStatus();

    setState(() {
      titleList = titledata.titleNameData;
      genderList = gender.genderData;
      bloodgroupList = blood.bloodGroupData;
      maritalstatusList = marital.maritalStatusData;
      raceList = race.raceData;
      religionList = religion.religionData;
      nationalityList = nationality.nationalityData;
      isloading = false;

      raceList.sort((a, b) => a.raceTh.compareTo(b.raceTh));
      religionList.sort((a, b) => a.religionTh.compareTo(b.religionTh));
      nationalityList
          .sort((a, b) => a.nationalityEn.compareTo(b.nationalityEn));
    });
  }

  Future<void> _selectDate() async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 18 * 365)),
      firstDate: DateTime.now().subtract(const Duration(days: 70 * 365)),
      lastDate: DateTime.now().subtract(const Duration(days: 18 * 365)),
    );
    if (picker != null) {
      setState(() {
        dateOfBirth.text = picker.toString().split(" ")[0];
        onValidate();
      });
    }
  }

//

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

    bool isaddperson = await ApiService.addPersonalData(updatepersondata);
    setState(() {
      if (isaddperson == true) {
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

  void onValidate() {
    if (_formKey.currentState!.validate()) {
      // การตรวจสอบผ่านแล้ว
      // ทำสิ่งที่คุณต้องการเมื่อข้อมูลถูกกรอกถูกต้อง
      setState(() {
        onpersoncreatedmodel = PersonCreateModel(
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
        context
            .read<PersonalBloc>()
            .add(CreatedprofileEvent(personcreatedmodel: onpersoncreatedmodel));
      });
      context.read<PersonalBloc>().add(IsValidateProfileEvent());
      context.read<PersonalBloc>().add(ProfileValidateEvent());
      context.read<PersonalBloc>().add(ContinueEvent());
    } else {
      // การตรวจสอบไม่ผ่าน
      // ทำสิ่งที่คุณต้องการเมื่อข้อมูลไม่ถูกต้อง
      context.read<PersonalBloc>().add(IsNotValidateProfileEvent());
      context.read<PersonalBloc>().add(ProfileValidateEvent());

      context.read<PersonalBloc>().add(DissContinueEvent());
    }
  }

  void onnewvalue() {
    setState(() {
      onpersoncreatedmodel = PersonCreateModel(
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
      context
          .read<PersonalBloc>()
          .add(CreatedprofileEvent(personcreatedmodel: onpersoncreatedmodel));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Row(
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
                    child: Icon(
                      Icons.photo_camera_rounded,
                      color: Colors.grey[700],
                      size: 100,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(onPressed: () {}, child: const Text('Upload'))
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
                      color: mythemecolor,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(8))),
                      child: SizedBox(
                        height: 32,
                        width: 140,
                        child: Center(
                            child: Text('ข้อมูลส่วนตัว',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white))),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Card(
                    elevation: 4,
                    color: mygreycolors,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        height: 410,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: TextFormFieldGlobal(
                                    controller: personId,
                                    labelText: "PersonID : รหัสประจำตัว",
                                    enabled: false,
                                    readOnly: true,
                                  )),
                                  Expanded(
                                      child: DropdownGlobal(
                                          labeltext: 'Titlename : คำนำหน้า',
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
                                              // onnewvalue();
                                              onValidate();
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
                                          validator: Validatorless.required(
                                              "required"))),
                                ],
                              ),
                              const Gap(5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: TextFormFieldGlobal(
                                    controller: firstNameTh,
                                    labelText: "ชื่อ (TH)",
                                    enabled: true,
                                    onChanged: (newValue) {
                                      onValidate();
                                    },
                                    validatorless:
                                        Validatorless.required('required'),
                                  )),
                                  Expanded(
                                      child: TextFormFieldGlobal(
                                    controller: lastNameTh,
                                    labelText: "นามสกุล (TH)",
                                    enabled: true,
                                    onChanged: (newValue) {
                                      onValidate();
                                    },
                                    validatorless:
                                        Validatorless.required('required'),
                                  )),
                                ],
                              ),
                              const Gap(5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: TextFormFieldGlobal(
                                    controller: firstNameEn,
                                    labelText: "Firstname (EN)",
                                    enabled: true,
                                    onChanged: (newValue) {
                                      onValidate();
                                    },
                                    validatorless:
                                        Validatorless.required('required'),
                                  )),
                                  Expanded(
                                      child: TextFormFieldGlobal(
                                    controller: lastNameEn,
                                    labelText: "Lastname (EN)",
                                    enabled: true,
                                    onChanged: (newValue) {
                                      onValidate();
                                    },
                                    validatorless:
                                        Validatorless.required('required'),
                                  )),
                                ],
                              ),
                              const Gap(5),
                              TextFormFieldDatepickGlobal(
                                  controller: dateOfBirth,
                                  labelText: "Birthday (วันเกิด)",
                                  validatorless:
                                      Validatorless.required('required'),
                                  ontap: () {
                                    _selectDate();
                                  }),
                              const Gap(5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: TextFormFieldGlobal(
                                    controller: height,
                                    labelText: "ส่วนสูง",
                                    enabled: true,
                                    onChanged: (newValue) {
                                      onValidate();
                                    },
                                    suffixText: 'cm.',
                                    validatorless: Validatorless.multiple([
                                      Validatorless.min(
                                          3, 'กรอกข้อมูลให้ถูกต้อง'),
                                      Validatorless.max(
                                          3, 'กรอกข้อมูลให้ถูกต้อง'),
                                      Validatorless.required('required')
                                    ]),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(
                                          r'[0-9]')), // ใช้ input formatter เพื่อจำกัดให้เป็นตัวเลขเท่านั้น
                                    ],
                                  )),
                                  Expanded(
                                      child: TextFormFieldGlobal(
                                    controller: weight,
                                    labelText: "น้ำหนัก",
                                    enabled: true,
                                    onChanged: (newValue) {
                                      onValidate();
                                    },
                                    suffixText: "kg.",
                                    validatorless: Validatorless.multiple([
                                      Validatorless.min(
                                          2, 'กรอกข้อมูลให้ถูกต้อง'),
                                      Validatorless.max(
                                          3, 'กรอกข้อมูลให้ถูกต้อง'),
                                      Validatorless.required('กรุณากรอกข้อมูล')
                                    ]),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(
                                          r'[0-9]')), // ใช้ input formatter เพื่อจำกัดให้เป็นตัวเลขเท่านั้น
                                    ],
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<PersonalBloc, PersonalState>(
            builder: (context, state) {
              return Expanded(
                  flex: 5,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Card(
                            color: mythemecolor,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(8))),
                            child: const SizedBox(
                              height: 32,
                              width: 140,
                              child: Center(
                                  child: Text('ข้อมูลเพิ่มเติม',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white))),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Card(
                          elevation: 4,
                          color: mygreycolors,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SizedBox(
                              height: 410,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: DropdownGlobal(
                                              labeltext: 'Gender (เพศ)',
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
                                                  onValidate();
                                                });
                                              },
                                              validator: Validatorless.required(
                                                  "required"))),
                                      Expanded(
                                          child: DropdownGlobal(
                                              labeltext:
                                                  'Bloodtype (กรุ๊ปเลือด)',
                                              value: bloodgroup,
                                              items: bloodgroupList.map((e) {
                                                return DropdownMenuItem<String>(
                                                  value: e.bloodId,
                                                  child: SizedBox(
                                                    width: 80,
                                                    child: Text(
                                                        '${e.bloodGroupNameEn} : ${e.bloodGroupNameTh}'),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  bloodgroup =
                                                      newValue.toString();
                                                  onValidate();
                                                });
                                              },
                                              validator: Validatorless.required(
                                                  "required"))),
                                    ],
                                  ),
                                  const Gap(5),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: DropdownGlobal(
                                              labeltext: 'Status (สถานะ)',
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
                                                  onValidate();
                                                });
                                              },
                                              validator: Validatorless.required(
                                                  "required"))),
                                      Expanded(
                                          child: DropdownGlobal(
                                              labeltext: 'Religion (ศาสนา)',
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
                                                  onValidate();
                                                });
                                              },
                                              validator: Validatorless.required(
                                                  "required"))),
                                    ],
                                  ),
                                  const Gap(5),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: DropdownMenuGlobal(
                                            label: "Race (เชื้อชาติ)",
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width <=
                                                    1366
                                                ? 230
                                                : 265,
                                            controller: racestatusMenu,
                                            onSelected: (value) {
                                              setState(() {
                                                racestatus = value.toString();
                                                onValidate();
                                              });
                                            },
                                            dropdownMenuEntries:
                                                raceList.map((e) {
                                              return DropdownMenuEntry(
                                                value: e.raceId,
                                                label: e.raceTh,
                                              );
                                            }).toList()),
                                      ),
                                      Expanded(
                                        child: DropdownMenuGlobal(
                                            label: "Nationality (สัญชาติ)",
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width <=
                                                    1366
                                                ? 230
                                                : 265,
                                            controller: nationalityMenu,
                                            onSelected: (value) {
                                              setState(() {
                                                nationality = value.toString();
                                                onValidate();
                                              });
                                            },
                                            dropdownMenuEntries:
                                                nationalityList.map((e) {
                                              return DropdownMenuEntry(
                                                value: e.nationalityId,
                                                label:
                                                    '${e.nationalityEn} : ${e.nationalityTh}',
                                              );
                                            }).toList()),
                                      ),
                                    ],
                                  ),
                                  TextFormFieldGlobal(
                                    controller: email,
                                    labelText: "E-mail",
                                    enabled: true,
                                    onChanged: (newValue) {
                                      onValidate();
                                    },
                                    validatorless: Validatorless.multiple([
                                      Validatorless.email('admin@example.com'),
                                    ]),
                                  ),
                                  const Gap(5),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: TextFormFieldGlobal(
                                        controller: phoneNumber1,
                                        labelText:
                                            "Primary Number (เบอร์โทรศัพท์หลัก)",
                                        enabled: true,
                                        onChanged: (newValue) {
                                          onValidate();
                                        },
                                        validatorless: Validatorless.multiple([
                                          Validatorless.required('required'),
                                          Validatorless.number(
                                              'กรอกเฉพาะตัวเลข'),
                                          Validatorless.min(
                                              10, 'กรอกให้ครบ 10 หลัก'),
                                          Validatorless.max(10, 'เกิน 10 หลัก'),
                                        ]),
                                      )),
                                      Expanded(
                                          child: TextFormFieldGlobal(
                                        controller: phoneNumber2,
                                        labelText:
                                            "Secondary Number (เบอร์โทรศัพท์รอง)",
                                        enabled: true,
                                        onChanged: (newValue) {
                                          onValidate();
                                        },
                                        validatorless: null,
                                      )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
            },
          )
        ],
      ),
    );
  }
}
