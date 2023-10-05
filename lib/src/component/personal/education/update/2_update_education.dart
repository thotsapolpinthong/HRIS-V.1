import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hris_app_prototype/src/model/address/dropdown/country_model.dart';
import 'package:hris_app_prototype/src/model/education/dropdown/education_level_model.dart';
import 'package:hris_app_prototype/src/model/education/dropdown/education_qualification_model.dart';
import 'package:hris_app_prototype/src/model/education/dropdown/institute_model.dart';
import 'package:hris_app_prototype/src/model/education/dropdown/major_madel.dart';
import 'package:hris_app_prototype/src/model/education/getdata_education_model.dart';
import 'package:hris_app_prototype/src/model/education/update/update_education_model.dart';
import 'package:hris_app_prototype/src/services/api_web_service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class UpdateEducation extends StatefulWidget {
  final String personId;
  final EducationDatum educationData;

  const UpdateEducation(
      {super.key, required this.personId, required this.educationData});

  @override
  State<UpdateEducation> createState() => _UpdateEducationState();
}

class _UpdateEducationState extends State<UpdateEducation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isloading = false;
  bool disableExp = false;

  List<CountryDatum>? countryList = [];
  String? countryId;

  List<EducationLevelDatum>? educationlevelList = [];
  String? educationlevel;

  List<EducationQualificationDatum>? qualificationList = [];
  String? qualification;

  List<InstituteDatum>? instituteList = [];
  String? institute;

  List<MajorDatum>? majorlList = [];
  String? major;

  TextEditingController admissionDate = TextEditingController();
  TextEditingController graduatedDate = TextEditingController();
  TextEditingController gpa = TextEditingController();
  TextEditingController comment = TextEditingController();
  @override
  initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    educationlevelList = await ApiService.getEducationLevelDropdown();
    qualificationList = await ApiService.getEducationQualificationDropdown();
    instituteList = await ApiService.getInstitueDropdown();
    majorlList = await ApiService.getMajorDropdown();
    CountryDataModel countryDataModel = await ApiService.getCountry();

    setState(() {
      countryList = countryDataModel.countryData;
      countryId = widget.educationData.country.countryId;
      educationlevel = widget.educationData.educationLevel.educationLevelId;
      qualification =
          widget.educationData.educationQualification.educationQualificationId;
      institute = widget.educationData.institute.instituteId;
      major = widget.educationData.major.majorId;
      admissionDate.text = widget.educationData.admissionDate.toString();
      graduatedDate.text = widget.educationData.graduatedDate.toString();
      gpa.text = widget.educationData.gpa.toString();
    });
  }

  Future<void> _selectadmissionDate() async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(3000),
    );
    if (picker != null) {
      setState(() {
        admissionDate.text = picker.toString().split(" ")[0];
        disableExp = true;
        graduatedDate.text = "";
      });
    }
  }

  Future<void> _selectgraduatedDate() async {
    DateFormat format = DateFormat('yyyy-MM-dd');
    DateTime dateTime = format.parse(admissionDate.text);
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: dateTime,
      lastDate: DateTime(3000),
    );
    if (picker != null) {
      setState(() {
        graduatedDate.text = picker.toString().split(" ")[0];
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
    UpdateEducationModel updateEducation = UpdateEducationModel(
        educationId: widget.educationData.educaationId,
        educationLevelId: educationlevel.toString(),
        personId: widget.personId,
        educationQualificationId: qualification.toString(),
        institueId: institute.toString(),
        countryId: countryId.toString(),
        admissionDate: admissionDate.text,
        graduatedDate: graduatedDate.text,
        gpa: gpa.text,
        majorId: major.toString(),
        modifiedBy: employeeId,
        comment: comment.text);

    bool success = await ApiService.updateEducation(updateEducation);

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
                  'Edit Education Information Success.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'แก้ไขข้อมูลประวัติการศึกษา สำเร็จ',
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
                  'Edit Education Information Fail.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'แก้ไขข้อมูลประวัติการศึกษา ไม่สำเร็จ',
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Card(
                                      elevation: 2,
                                      child: DropdownButtonFormField(
                                        decoration: const InputDecoration(
                                            labelText:
                                                'Educationlevel : ระดับการศึกษา',
                                            labelStyle: TextStyle(
                                                color: Colors.black87),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white),
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        validator: Validatorless.required(
                                            'กรุณากรอกข้อมูล'),
                                        borderRadius: BorderRadius.circular(8),
                                        value: educationlevel,
                                        items: educationlevelList?.map((e) {
                                          return DropdownMenuItem<String>(
                                            value:
                                                e.educationLevelId.toString(),
                                            child: SizedBox(
                                                width: 300,
                                                child:
                                                    Text(e.educationLevelTh)),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            educationlevel =
                                                newValue.toString();
                                          });
                                        },
                                      ),
                                    ),
                                    Card(
                                      elevation: 2,
                                      child: DropdownButtonFormField(
                                        decoration: const InputDecoration(
                                            labelText:
                                                'Country : ประเทศที่สำเร็จการศึกษา',
                                            labelStyle: TextStyle(
                                                color: Colors.black87),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white),
                                        borderRadius: BorderRadius.circular(8),
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        validator: Validatorless.required(
                                            'กรุณากรอกข้อมูล'),
                                        value: countryId,
                                        items: countryList?.map((e) {
                                          return DropdownMenuItem<String>(
                                            value: e.countryId.toString(),
                                            child: Text(e.countryNameTh),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            countryId = newValue.toString();
                                          });
                                        },
                                      ),
                                    ),
                                    Card(
                                      elevation: 2,
                                      child: DropdownButtonFormField(
                                        decoration: const InputDecoration(
                                            labelText:
                                                'Qualification : วุฒิการศึกษา',
                                            labelStyle: TextStyle(
                                                color: Colors.black87),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white),
                                        borderRadius: BorderRadius.circular(8),
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        validator: Validatorless.required(
                                            'กรุณากรอกข้อมูล'),
                                        value: qualification,
                                        items: qualificationList?.map((e) {
                                          return DropdownMenuItem<String>(
                                            value: e.educationQualificationId
                                                .toString(),
                                            child:
                                                Text(e.educationQualificaionTh),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            qualification = newValue.toString();
                                          });
                                        },
                                      ),
                                    ),
                                    Card(
                                      elevation: 2,
                                      child: DropdownButtonFormField(
                                        decoration: const InputDecoration(
                                            labelText: 'Institute : สถาบัน',
                                            labelStyle: TextStyle(
                                                color: Colors.black87),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white),
                                        borderRadius: BorderRadius.circular(8),
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        validator: Validatorless.required(
                                            'กรุณากรอกข้อมูล'),
                                        value: institute,
                                        items: instituteList?.map((e) {
                                          return DropdownMenuItem<String>(
                                            value: e.instituteId.toString(),
                                            child: SizedBox(
                                                width: 300,
                                                child: Text(e.instituteNameTh)),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            institute = newValue.toString();
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Card(
                                      elevation: 2,
                                      child: DropdownButtonFormField(
                                        decoration: const InputDecoration(
                                            labelText: 'Major : วิชาหลัก',
                                            labelStyle: TextStyle(
                                                color: Colors.black87),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white),
                                        borderRadius: BorderRadius.circular(8),
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        validator: Validatorless.required(
                                            'กรุณากรอกข้อมูล'),
                                        value: major,
                                        items: majorlList?.map((e) {
                                          return DropdownMenuItem<String>(
                                            value: e.majorId.toString(),
                                            child: Text(e.majorTh),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            major = newValue.toString();
                                          });
                                        },
                                      ),
                                    ),
                                    Card(
                                      elevation: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: TextFormField(
                                          autovalidateMode:
                                              AutovalidateMode.always,
                                          validator: Validatorless.required(
                                              'กรุณากรอกข้อมูล'),
                                          controller: admissionDate,
                                          decoration: const InputDecoration(
                                            labelText:
                                                'AdmissionDate : วันที่เข้ารับการศึกษา',
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            filled: true,
                                            fillColor: Colors.white,
                                            suffixIcon: Icon(
                                              Icons.calendar_today,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          readOnly: true,
                                          onTap: () {
                                            _selectadmissionDate();
                                          },
                                        ),
                                      ),
                                    ),
                                    Card(
                                      elevation: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: TextFormField(
                                          autovalidateMode:
                                              AutovalidateMode.always,
                                          validator: Validatorless.required(
                                              'กรุณากรอกข้อมูล'),
                                          controller: graduatedDate,
                                          decoration: const InputDecoration(
                                            labelText:
                                                'GraduatedDate : วันที่สำเร็จการศึกษา',
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            filled: true,
                                            fillColor: Colors.white,
                                            suffixIcon: Icon(
                                              Icons.calendar_today,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          readOnly: true,
                                          enabled: disableExp,
                                          onTap: () {
                                            _selectgraduatedDate();
                                          },
                                        ),
                                      ),
                                    ),
                                    Card(
                                      elevation: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextFormField(
                                          autovalidateMode:
                                              AutovalidateMode.always,
                                          validator: Validatorless.multiple([
                                            Validatorless.required(
                                                'กรุณากรอกข้อมูล'),
                                            Validatorless.regex(
                                                RegExp(r'^[0-4](\.\d{1,2})?$'),
                                                'x.xx')
                                          ]),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(
                                                    r'^\d+\.?\d{0,2}$')), // ใช้ input formatter เพื่อจำกัดให้เป็นตัวเลขเท่านั้น
                                          ],
                                          controller: gpa,
                                          decoration: const InputDecoration(
                                              hintText: 'กรอกเฉพาะตัวเลข',
                                              labelText: 'GPA : เกรดเฉลี่ย',
                                              labelStyle: TextStyle(
                                                  color: Colors.black87),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
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
