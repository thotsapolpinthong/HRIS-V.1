import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/personal_bloc/personal_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/address/dropdown/country_model.dart';
import 'package:hris_app_prototype/src/model/education/add/create_education_model.dart';
import 'package:hris_app_prototype/src/model/education/dropdown/create_institute.dart';
import 'package:hris_app_prototype/src/model/education/dropdown/create_major.dart';
import 'package:hris_app_prototype/src/model/education/dropdown/create_qualificaion.dart';
import 'package:hris_app_prototype/src/model/education/dropdown/education_level_model.dart';
import 'package:hris_app_prototype/src/model/education/dropdown/education_qualification_model.dart';
import 'package:hris_app_prototype/src/model/education/dropdown/institute_model.dart';
import 'package:hris_app_prototype/src/model/education/dropdown/major_madel.dart';
import 'package:hris_app_prototype/src/services/api_personal_service.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

class AddEducation extends StatefulWidget {
  final String personId;
  final bool addButton;
  const AddEducation(
      {super.key, required this.personId, required this.addButton});

  @override
  State<AddEducation> createState() => _AddEducationState();
}

class _AddEducationState extends State<AddEducation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isloading = false;
  bool disableExp = false;

  List<CountryDatum>? countryList = [];
  String? countryId;

  List<EducationLevelDatum>? educationlevelList = [];
  String? educationlevel;

  List<EducationQualificationDatum>? qualificationList = [];
  String? qualification;
  String? qualificationIdDialog;

  List<InstituteDatum>? instituteList = [];
  String? institute;

  List<MajorDatum>? majorlList = [];
  String? major;

  TextEditingController admissionDate = TextEditingController();
  TextEditingController graduatedDate = TextEditingController();
  TextEditingController gpa = TextEditingController();
  TextEditingController instituteMenu = TextEditingController();

  @override
  initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    educationlevelList = await ApiService.getEducationLevelDropdown();
    qualificationList = await ApiService.getEducationQualificationDropdown();
    instituteList = await ApiService.getInstitueDropdown();
    // majorlList = await ApiService.getMajorDropdown();
    CountryDataModel? countryDataModel = await ApiService.getCountry();
    setState(() {
      countryList = countryDataModel?.countryData;
      educationlevelList;
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
        onNewValue();
        onValidate();
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
        onNewValue();
        onValidate();
      });
    }
  }

  void onValidate() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        CreateeducationModel addEducation = CreateeducationModel(
          educationLevelId: educationlevel.toString(),
          personId: widget.personId,
          educationQualificationId: qualification.toString(),
          institueId: institute.toString(),
          countryId: countryId.toString(),
          admissionDate: admissionDate.text,
          graduatedDate: graduatedDate.text,
          gpa: gpa.text,
          majorId: major.toString(),
        );

        context
            .read<PersonalBloc>()
            .add(CreatedEducationEvent(creatededucationModel: addEducation));
      });
      context.read<PersonalBloc>().add(IsValidateProfileEvent());
      context.read<PersonalBloc>().add(EducationValidateEvent());
      context.read<PersonalBloc>().add(ContinueEvent());
    } else {
      context.read<PersonalBloc>().add(IsNotValidateProfileEvent());
      context.read<PersonalBloc>().add(EducationValidateEvent());
      context.read<PersonalBloc>().add(DissContinueEvent());
    }
  }

  void onNewValue() {}

  onadd() async {
    CreateeducationModel addEducation = CreateeducationModel(
      educationLevelId: educationlevel.toString(),
      personId: widget.personId,
      educationQualificationId: qualification.toString(),
      institueId: institute.toString(),
      countryId: countryId.toString(),
      admissionDate: admissionDate.text,
      graduatedDate: graduatedDate.text,
      gpa: gpa.text,
      majorId: major.toString(),
    );

    bool success = await ApiService.addEducationbyId(addEducation);

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
                  'Add Education Information Success.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'เพิ่มข้อมูลประวัติการศึกษา สำเร็จ',
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
                  'Add Education Information Fail.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'เพิ่มข้อมูลประวัติการศึกษา ไม่สำเร็จ',
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

  createDropdownDialog(int type) async {
    //0 วุฒิการศึกษา //1 สถาบัน //2วิชาหลัก
    TextEditingController text = TextEditingController();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: mygreycolors,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: TitleDialog(
                title: type == 0
                    ? "เพิ่มตัวเลือกวุติการศึกษา"
                    : type == 1
                        ? "เพิ่มตัวเลือกสถาบัน"
                        : "เพิ่มตัวเลือกวิชาหลัก",
                onPressed: () {
                  Navigator.pop(context);
                  text.text = "";
                },
              ),
              content: SizedBox(
                width: 300,
                height: 180,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (type == 2)
                              DropdownGlobal(
                                  labeltext: 'วุฒิการศึกษา',
                                  value: qualificationIdDialog,
                                  items: qualificationList?.map((e) {
                                    return DropdownMenuItem<String>(
                                      value:
                                          e.educationQualificationId.toString(),
                                      child: Container(
                                          width: 58,
                                          constraints: const BoxConstraints(
                                              maxWidth: 250, minWidth: 200),
                                          child:
                                              Text(e.educationQualificaionTh)),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      qualificationIdDialog =
                                          newValue.toString();
                                    });
                                  },
                                  validator: null),
                            const Gap(5),
                            TextFormFieldGlobal(
                                controller: text,
                                labelText: "ข้อมูลที่ต้องการเพิ่ม",
                                hintText: "",
                                validatorless: null,
                                enabled: true),
                          ],
                        ),
                      ),
                    ),
                    MySaveButtons(
                      text: "Submit",
                      onPressed: () async {
                        switch (type) {
                          case 0:
                            CreateQualificaionThModel createModel =
                                CreateQualificaionThModel(
                                    educationQualificaionTh: text.text);
                            bool success = await ApiService
                                .createEducationQualificationDropdown(
                                    createModel);
                            alertDialog(success);
                            break;
                          case 1:
                            CreateinstituteModel createModel =
                                CreateinstituteModel(
                                    instituteNameTh: text.text);
                            bool success =
                                await ApiService.createInstitueDropdown(
                                    createModel);
                            alertDialog(success);
                            break;
                          case 2:
                            CreateMajorModel createModel = CreateMajorModel(
                                educationQualificationId:
                                    qualificationIdDialog.toString(),
                                majorTh: text.text);
                            bool success = await ApiService.createMajorDropdown(
                                createModel);
                            alertDialog(success);
                            break;
                        }
                      },
                    )
                  ],
                ),
              ));
        });
  }

  alertDialog(bool success) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      width: 400,
      context: context,
      animType: AnimType.topSlide,
      dialogType: success == true ? DialogType.success : DialogType.error,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Column(
            children: [
              Text(
                success == true ? 'Created Success.' : 'Created Fail.',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              TextThai(
                text: success == true
                    ? 'เพิ่มข้อมูล สำเร็จ'
                    : 'เพิ่มข้อมูล ไม่สำเร็จ',
                textStyle: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
      btnOkColor: success == true ? Colors.greenAccent : Colors.red,
      btnOkOnPress: () {
        if (success == true) {
          fetchData();
          Navigator.pop(context);
        } else {}
      },
    ).show();
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
                                      child: DropdownButtonFormField(
                                        decoration: const InputDecoration(
                                            labelText:
                                                'Educationlevel : ระดับการศึกษา',
                                            labelStyle: TextStyle(
                                                color: Colors.black87),
                                            border: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black26),
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
                                                width: 280,
                                                child:
                                                    Text(e.educationLevelTh)),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            educationlevel =
                                                newValue.toString();
                                            onNewValue();
                                            onValidate();
                                          });
                                        },
                                      ),
                                    ),
                                    Card(
                                      child: DropdownButtonFormField(
                                        decoration: const InputDecoration(
                                            labelText:
                                                'Country : ประเทศที่สำเร็จการศึกษา',
                                            labelStyle: TextStyle(
                                                color: Colors.black87),
                                            border: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black26),
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
                                            onNewValue();
                                            onValidate();
                                          });
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: Card(
                                        child: TextFormField(
                                          autovalidateMode:
                                              AutovalidateMode.always,
                                          validator: null,
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
                                            border: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black26),
                                            ),
                                          ),
                                          readOnly: true,
                                          onTap: () {
                                            _selectadmissionDate();
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 2),
                                      child: Card(
                                        child: TextFormField(
                                          autovalidateMode:
                                              AutovalidateMode.always,
                                          validator: null,
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
                                            border: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black26),
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
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Card(
                                            child: DropdownButtonFormField(
                                              decoration: const InputDecoration(
                                                  labelText:
                                                      'Qualification : วุฒิการศึกษา',
                                                  labelStyle: TextStyle(
                                                      color: Colors.black87),
                                                  border: OutlineInputBorder(),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black26),
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              autovalidateMode:
                                                  AutovalidateMode.always,
                                              validator: null,
                                              value: qualification,
                                              items:
                                                  qualificationList?.map((e) {
                                                return DropdownMenuItem<String>(
                                                  value: e
                                                      .educationQualificationId
                                                      .toString(),
                                                  child: Text(e
                                                      .educationQualificaionTh),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) async {
                                                majorlList = await ApiService
                                                    .getMajorDropdown(
                                                        newValue.toString());
                                                setState(() {
                                                  majorlList;
                                                  qualification =
                                                      newValue.toString();
                                                  onNewValue();
                                                  onValidate();
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 4),
                                          child: SizedBox(
                                            height: 45,
                                            width: 45,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0)),
                                                onPressed: () {
                                                  setState(() {
                                                    createDropdownDialog(0);
                                                  });
                                                },
                                                child: const Icon(Icons.add)),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Card(
                                            child: DropdownButtonFormField(
                                              decoration: const InputDecoration(
                                                  labelText: 'Major : วิชาหลัก',
                                                  labelStyle: TextStyle(
                                                      color: Colors.black87),
                                                  border: OutlineInputBorder(),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black26),
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              autovalidateMode:
                                                  AutovalidateMode.always,
                                              validator: null,
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
                                                  onNewValue();
                                                  onValidate();
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 4),
                                          child: SizedBox(
                                            height: 45,
                                            width: 45,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0)),
                                                onPressed: () {
                                                  setState(() {
                                                    createDropdownDialog(2);
                                                  });
                                                },
                                                child: const Icon(Icons.add)),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: DropdownMenuGlobalOutline(
                                              label: "Institute : สถาบัน",
                                              width: 370,
                                              controller: instituteMenu,
                                              onSelected: (value) {
                                                setState(() {
                                                  institute = value.toString();
                                                  onNewValue();
                                                  onValidate();
                                                });
                                              },
                                              dropdownMenuEntries:
                                                  instituteList!.map((e) {
                                                return DropdownMenuEntry(
                                                  value: e.instituteId,
                                                  label: e.instituteNameTh,
                                                );
                                              }).toList()),
                                        ),
                                        // Expanded(
                                        //   child: Card(
                                        //     child: DropdownButtonFormField(
                                        //       decoration: const InputDecoration(
                                        //           labelText:
                                        //               'Institute : สถาบัน',
                                        //           labelStyle: TextStyle(
                                        //               color: Colors.black87),
                                        //           border: OutlineInputBorder(),
                                        //           enabledBorder:
                                        //               OutlineInputBorder(
                                        //             borderSide: BorderSide(
                                        //                 color: Colors.black26),
                                        //           ),
                                        //           filled: true,
                                        //           fillColor: Colors.white),
                                        //       borderRadius:
                                        //           BorderRadius.circular(8),
                                        //       autovalidateMode:
                                        //           AutovalidateMode.always,
                                        //       validator: null,
                                        //       value: institute,
                                        //       items: instituteList?.map((e) {
                                        //         return DropdownMenuItem<String>(
                                        //           value:
                                        //               e.instituteId.toString(),
                                        //           child: SizedBox(
                                        //               width: 280,
                                        //               child: Text(
                                        //                   e.instituteNameTh)),
                                        //         );
                                        //       }).toList(),
                                        //       onChanged: (newValue) {
                                        //         setState(() {
                                        //           institute =
                                        //               newValue.toString();
                                        //           onNewValue();
                                        //           onValidate();
                                        //         });
                                        //       },
                                        //     ),
                                        //   ),
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 4),
                                          child: SizedBox(
                                            height: 45,
                                            width: 45,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0)),
                                                onPressed: () {
                                                  setState(() {
                                                    createDropdownDialog(1);
                                                  });
                                                },
                                                child: const Icon(Icons.add)),
                                          ),
                                        )
                                      ],
                                    ),
                                    Card(
                                      child: TextFormField(
                                        validator: null,
                                        //  Validatorless.multiple([
                                        //   Validatorless.required(
                                        //       'กรุณากรอกข้อมูล'),
                                        //   Validatorless.regex(
                                        //       RegExp(r'^[0-4](\.\d{1,2})?$'),
                                        //       'x.xx')
                                        // ]),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(
                                              r'^\d+\.?\d{0,2}$')), // ใช้ input formatter เพื่อจำกัดให้เป็นตัวเลขเท่านั้น
                                        ],
                                        controller: gpa,
                                        onChanged: (value) {
                                          // onNewValue();
                                          onValidate();
                                        },
                                        decoration: const InputDecoration(
                                            hintText: 'กรอกเฉพาะตัวเลข',
                                            labelText: 'GPA : เกรดเฉลี่ย',
                                            labelStyle: TextStyle(
                                                color: Colors.black87),
                                            border: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black26),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  if (widget.addButton == true)
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
                          child: Text('Add',
                              style: TextStyle(
                                color: Colors.grey[800],
                              )),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // การตรวจสอบผ่านแล้ว
                              // ทำสิ่งที่คุณต้องการเมื่อข้อมูลถูกกรอกถูกต้อง
                              onadd();
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
