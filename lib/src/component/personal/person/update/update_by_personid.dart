import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hris_app_prototype/main.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/model/person/dropdown/bloodgroup_model.dart';
import 'package:hris_app_prototype/src/model/person/dropdown/gender_model.dart';
import 'package:hris_app_prototype/src/model/person/dropdown/maritalstatus_model.dart';
import 'package:hris_app_prototype/src/model/person/dropdown/national_model.dart';
import 'package:hris_app_prototype/src/model/person/dropdown/race_model.dart';
import 'package:hris_app_prototype/src/model/person/dropdown/religion.model.dart';
import 'package:hris_app_prototype/src/model/person/dropdown/title.dart';
import 'package:hris_app_prototype/src/model/person/personbyId_model.dart';
import 'package:hris_app_prototype/src/model/person/update_person_model.dart';
import 'package:hris_app_prototype/src/services/api_web_service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class UpdatePersonbyId extends StatefulWidget {
  final String personid;
  const UpdatePersonbyId({super.key, required this.personid});

  @override
  State<UpdatePersonbyId> createState() => _UpdatePersonbyIdState();
}

class _UpdatePersonbyIdState extends State<UpdatePersonbyId> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isUpdatePerson = false;
  PersonByIdData? _person;

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
  TextEditingController comment = TextEditingController();
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

  //end dropdown----------------------------------------------------------------
  @override
  void initState() {
    fetchPersonById();
    super.initState();
  }

  Future<void> fetchPersonById() async {
    PersonByIdModel? data =
        await ApiService.fetchPersonById(widget.personid.toString());
    if (data == null) {
      setState(() {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: const Text("Token หมดอายุ กรุณา Login ใหม่อีกครั้ง"),
                icon: IconButton(
                  color: Colors.red[600],
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
    } else {
      _person = data.personData;
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

        personId.text = widget.personid.toString();
        titles = _person!.titleName.titleNameId.toString();
        firstNameTh.text = _person!.fisrtNameTh!.toString();
        lastNameTh.text = _person!.lastNameTh!.toString();
        firstNameEn.text = _person!.firstNameEn!.toString();
        midNameTh.text = _person!.midNameTh.toString();
        midNameEn.text = _person!.midNameEn.toString();
        lastNameEn.text = _person!.lastNameEn!.toString();
        email.text = _person!.email!.toString();
        dateOfBirth.text = _person!.dateOfBirth!.toString();
        genders = _person!.gender.genderId.toString();
        height.text = _person!.height!.toString();
        weight.text = _person!.weight!.toString();
        bloodgroup = _person!.bloodGroup.bloodId.toString();
        maritalstatus = _person!.maritalStatus.maritalStatusId.toString();
        nationality = _person!.nationality.nationalityId.toString();
        racestatus = _person!.race.raceId.toString();
        religion = _person!.religion.religionId.toString();
        phoneNumber1.text = _person!.phoneNumber1.toString();
        phoneNumber2.text = _person!.phoneNumber2.toString();
        isloading = false;
      });
    }
  }

  Future<void> updateonbutton() async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    PersonUpdateModel updatepersondata = PersonUpdateModel(
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
      comment: comment.text,
      modifiedBy: employeeId,
    );

    isUpdatePerson = await ApiService.updatePersonbyId(updatepersondata);
    setState(() {
      if (isUpdatePerson == true) {
        AwesomeDialog(
          width: 500,
          context: context,
          animType: AnimType.topSlide,
          dialogType: DialogType.success,
          body: const Center(
            child: Text(
              'Update Success',
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
              'Update Error',
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
  }

  Future<void> _selectDate() async {
    DateTime now = DateTime.now();
    Duration eighteenYears = Duration(days: 18 * 365);
    DateTime resultDateTime = now.subtract(eighteenYears);
    DateFormat format = DateFormat('yyyy-MM-dd');
    DateTime dateTime = format.parse(dateOfBirth.text);
    DateTime? _picker = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1950),
      lastDate: resultDateTime,
    );
    if (_picker != null) {
      setState(() {
        dateOfBirth.text = _picker.toString().split(" ")[0];
      });
    }
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
            child: Column(
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.person_rounded,
                      size: 100,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(children: [
                        Card(
                          elevation: 2,
                          child: TextFormField(
                            controller: personId,
                            enabled: false,
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "PersonID : รหัสประจำตัว",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                            readOnly: true,
                          ),
                        ),
                        Card(
                          elevation: 2,
                          child: TextFormField(
                            controller: firstNameTh,
                            validator:
                                RequiredValidator(errorText: 'กรุณากรอกข้อมูล'),
                            decoration: const InputDecoration(
                                labelText: 'ชื่อ (TH)',
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                filled: true,
                                fillColor: Colors.white),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          child: TextFormField(
                            controller: firstNameEn,
                            validator:
                                RequiredValidator(errorText: 'กรุณากรอกข้อมูล'),
                            decoration: const InputDecoration(
                                labelText: 'Name (EN)',
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                filled: true,
                                fillColor: Colors.white),
                          ),
                        ),
                      ]),
                    ),
                    Expanded(
                      child: Column(children: [
                        Card(
                          elevation: 2,
                          child: SizedBox(
                            height: 53,
                            child: DropdownButtonFormField(
                              focusColor: Colors.white,
                              hint: const Text("TitleName"),
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
                                });
                              },
                              dropdownColor: Colors.white,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: "Titlename : คำนำหน้า",
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          child: TextFormField(
                            controller: lastNameTh,
                            validator:
                                RequiredValidator(errorText: 'กรุณากรอกข้อมูล'),
                            decoration: const InputDecoration(
                                labelText: 'นามสกุล (TH)',
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                filled: true,
                                fillColor: Colors.white),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          child: TextFormField(
                            controller: lastNameEn,
                            validator:
                                RequiredValidator(errorText: 'กรุณากรอกข้อมูล'),
                            decoration: const InputDecoration(
                                labelText: 'Lastname (EN)',
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                filled: true,
                                fillColor: Colors.white),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 2,
                        child: TextFormField(
                          controller: dateOfBirth,
                          decoration: const InputDecoration(
                            labelText: 'Date of birth',
                            labelStyle: TextStyle(color: Colors.black),
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: Icon(
                              Icons.calendar_today,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          readOnly: true,
                          onTap: () {
                            _selectDate();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Card(
                          elevation: 1,
                          child: TextFormField(
                            controller: height,
                            validator: Validatorless.number('Only number.'),
                            decoration: const InputDecoration(
                                labelText: 'ส่วนสูง (cm.)',
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                filled: true,
                                fillColor: Colors.white),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          child: SizedBox(
                            height: 53,
                            child: DropdownButtonFormField(
                              validator: Validatorless.number('Only number.'),
                              focusColor: Colors.white,
                              hint: const Text("Gender (เพศ)"),
                              value: genders,
                              items: genderList.map((e) {
                                return DropdownMenuItem<String>(
                                  value: e.genderId,
                                  child: Text('${e.genderEn} : ${e.genderTh}'),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  genders = newValue.toString();
                                });
                              },
                              dropdownColor: Colors.white,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: "Gender (เพศ)",
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          child: SizedBox(
                            height: 53,
                            child: DropdownButtonFormField(
                              focusColor: Colors.white,
                              hint: const Text("Status (สถานะ)"),
                              value: maritalstatus,
                              items: maritalstatusList.map((e) {
                                return DropdownMenuItem<String>(
                                  value: e.maritalStatusId,
                                  child: Text(e.maritalStatusName),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  maritalstatus = newValue.toString();
                                });
                              },
                              dropdownColor: Colors.white,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: "Status (สถานะ)",
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        Card(
                          child: TextFormField(
                            controller: weight,
                            validator:
                                RequiredValidator(errorText: 'กรุณากรอกข้อมูล'),
                            decoration: const InputDecoration(
                                labelText: 'น้ำหนัก (kg.)',
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                filled: true,
                                fillColor: Colors.white),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          child: Container(
                            height: 53,
                            child: DropdownButtonFormField(
                              focusColor: Colors.white,
                              hint: const Text("Bloodtype (กรุ๊ปเลือด)"),
                              value: bloodgroup,
                              items: bloodgroupList.map((e) {
                                return DropdownMenuItem<String>(
                                  value: e.bloodId,
                                  child: SizedBox(
                                    width: 60,
                                    child: Text(
                                        '${e.bloodGroupNameEn} : ${e.bloodGroupNameTh}'),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  bloodgroup = newValue.toString();
                                });
                              },
                              dropdownColor: Colors.white,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: "Bloodtype (กรุ๊ปเลือด)",
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          child: SizedBox(
                            height: 53,
                            child: DropdownButtonFormField(
                              focusColor: Colors.white,
                              hint: const Text("Religion (ศาสนา)"),
                              value: religion,
                              items: religionList.map((e) {
                                return DropdownMenuItem<String>(
                                  value: e.religionId,
                                  child: Text(e.religionTh),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  religion = newValue.toString();
                                });
                              },
                              dropdownColor: Colors.white,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: "Religion (ศาสนา)",
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
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
                            focusColor: Colors.white,
                            hint: const Text("Race (เชื้อชาติ)"),
                            value: racestatus,
                            items: raceList.map((e) {
                              return DropdownMenuItem<String>(
                                value: e.raceId,
                                child: Text(e.raceTh),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                racestatus = newValue.toString();
                              });
                            },
                            dropdownColor: Colors.white,
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "Race (เชื้อชาติ)",
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
                            focusColor: Colors.white,
                            hint: const Text("Nationality (สัญชาติ)"),
                            value: nationality,
                            items: nationalityList.map((e) {
                              return DropdownMenuItem<String>(
                                value: e.nationalityId,
                                child: Text(
                                    '${e.nationalityEn} : ${e.nationalityTh}'),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                nationality = newValue.toString();
                              });
                            },
                            dropdownColor: Colors.white,
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "Nationality (สัญชาติ)",
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 2,
                        child: TextFormField(
                          controller: email,
                          validator: Validatorless.multiple([
                            Validatorless.email('admin@example.com'),
                            Validatorless.required("กรุณากรอกข้อมูล")
                          ]),
                          decoration: const InputDecoration(
                              hintText: 'E-mail',
                              labelText: 'E-mail',
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
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 2,
                        child: TextFormField(
                          controller: phoneNumber1,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(
                                r'[0-9]')), // ใช้ input formatter เพื่อจำกัดให้เป็นตัวเลขเท่านั้น
                          ],
                          decoration: const InputDecoration(
                              hintText: 'เบอร์โทรศัพท์หลัก',
                              labelText: 'Primary Phonenumber.',
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
                    ),
                    Expanded(
                      child: Card(
                        elevation: 2,
                        child: TextFormField(
                          controller: phoneNumber2,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(
                                r'[0-9]')), // ใช้ input formatter เพื่อจำกัดให้เป็นตัวเลขเท่านั้น
                          ],
                          decoration: const InputDecoration(
                              hintText: 'เบอร์โทรศัพท์รอง',
                              labelText: 'Secondary Phonenumber.',
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
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.greenAccent, // Background color
                          // Text Color (Foreground color)
                        ),
                        child: const Text(
                          'Update',
                          style:
                              TextStyle(color: Color.fromARGB(189, 32, 32, 32)),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // การตรวจสอบผ่านแล้ว
                            // ทำสิ่งที่คุณต้องการเมื่อข้อมูลถูกกรอกถูกต้อง
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      backgroundColor: mygreycolors,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Expanded(
                                                child: Text(
                                                    'หมายเหตุ (โปรดระบุ)')),
                                            Card(
                                              elevation: 2,
                                              child: TextFormField(
                                                validator: RequiredValidator(
                                                    errorText:
                                                        'กรุณากรอกข้อมูล'),
                                                controller: comment,
                                                decoration:
                                                    const InputDecoration(
                                                        labelStyle: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        border: OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white)),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        filled: true,
                                                        fillColor:
                                                            Colors.white),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        updateonbutton();
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

                            // updateonbutton();
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
