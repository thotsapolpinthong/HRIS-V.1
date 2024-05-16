import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hris_app_prototype/src/model/contact_person/getdata_contact_model.dart';
import 'package:hris_app_prototype/src/model/contact_person/update/update_contact_model.dart';
import 'package:hris_app_prototype/src/model/person/dropdown/title.dart';
import 'package:hris_app_prototype/src/services/api_personal_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class UpdateContactPerson extends StatefulWidget {
  final String personId;
  final ContactPersonInfoDatum contactdata;
  const UpdateContactPerson(
      {super.key, required this.personId, required this.contactdata});

  @override
  State<UpdateContactPerson> createState() => _UpdateContactPersonState();
}

class _UpdateContactPersonState extends State<UpdateContactPerson> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isloading = false;
  bool disableExp = false;

  List<TitleNameDatum>? titlenameList = [];
  String? titlename;

  TextEditingController relation = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController midname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController occupation = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController positionName = TextEditingController();
  TextEditingController mobilePhone = TextEditingController();
  TextEditingController comment = TextEditingController();
  @override
  initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    TitleModel title = await ApiService.getTitle();
    setState(() {
      titlenameList = title.titleNameData;
      titlename = widget.contactdata.titleName.titleNameId;
      relation.text = widget.contactdata.relation;
      firstname.text = widget.contactdata.firstName;
      midname.text = widget.contactdata.midName;
      lastname.text = widget.contactdata.lastName;
      occupation.text = widget.contactdata.occupation ?? "";
      companyName.text = widget.contactdata.companyName;
      positionName.text = widget.contactdata.positionName;
      mobilePhone.text = widget.contactdata.mobilePhone;
    });
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
    UpdateContactModel updateContactModel = UpdateContactModel(
      contactPersonInfoId: widget.contactdata.contactPersonInfoId,
      personId: widget.personId,
      relation: relation.text,
      titleId: titlename.toString(),
      firstName: firstname.text,
      midName: midname.text,
      lastName: lastname.text,
      occupation: occupation.text,
      companyName: companyName.text,
      positionName: positionName.text,
      homePhone: '',
      mobilePhone: mobilePhone.text,
      modifiedBy: employeeId,
      comment: comment.text,
    );
    bool success = await ApiService.updateContactById(updateContactModel);

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
                  'Edit Contact Person Information Success.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'แก้ไขข้อมูลบุคคลที่สามารถติดต่อได้ สำเร็จ',
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
                  'Edit Contact Person Information Fail.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'แก้ไขข้อมูลบุคคลที่สามารถติดต่อได้ ไม่สำเร็จ',
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
            child: SizedBox(
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
                          child: ListView(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 2, 4),
                                      child: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        validator: Validatorless.multiple([
                                          Validatorless.required(
                                              'กรุณากรอกข้อมูล'),
                                        ]),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[a-zA-Zก-๙]')),
                                        ],
                                        controller: relation,
                                        decoration: const InputDecoration(
                                            labelText:
                                                'Relation : ความสัมพันธ์',
                                            labelStyle: TextStyle(
                                                color: Colors.black87),
                                            border: OutlineInputBorder(),
                                            filled: true,
                                            fillColor: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(2, 4, 0, 4),
                                      child: DropdownButtonFormField(
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        decoration: const InputDecoration(
                                            labelText: 'Title : คำนำหน้า',
                                            labelStyle: TextStyle(
                                                color: Colors.black87),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide()),
                                            filled: true,
                                            fillColor: Colors.white),
                                        borderRadius: BorderRadius.circular(8),
                                        // autovalidateMode:
                                        //     AutovalidateMode.always,
                                        validator: Validatorless.required(
                                            'กรุณากรอกข้อมูล'),
                                        value: titlename,
                                        items: titlenameList?.map((e) {
                                          return DropdownMenuItem<String>(
                                            value: e.titleNameId.toString(),
                                            child: SizedBox(
                                                width: 145,
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
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 2, 2, 4),
                                      child: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        validator: Validatorless.multiple([
                                          Validatorless.required(
                                              'กรุณากรอกข้อมูล'),
                                        ]),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[a-zA-Zก-๙]')),
                                        ],
                                        controller: firstname,
                                        decoration: const InputDecoration(
                                            labelText: 'Firstname : ชื่อ',
                                            labelStyle: TextStyle(
                                                color: Colors.black87),
                                            border: OutlineInputBorder(),
                                            filled: true,
                                            fillColor: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(2, 2, 0, 4),
                                      child: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        validator: Validatorless.multiple([
                                          Validatorless.required(
                                              'กรุณากรอกข้อมูล'),
                                        ]),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[a-zA-Zก-๙]')),
                                        ],
                                        controller: lastname,
                                        decoration: const InputDecoration(
                                            labelText: 'Lastname : นามสกุล',
                                            labelStyle: TextStyle(
                                                color: Colors.black87),
                                            border: OutlineInputBorder(),
                                            filled: true,
                                            fillColor: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
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
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 2, 0, 4),
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.always,
                                  validator:
                                      Validatorless.required('กรุณากรอกข้อมูล'),
                                  controller: occupation,
                                  decoration: const InputDecoration(
                                      labelText: 'Occupation : อาชีพ',
                                      labelStyle:
                                          TextStyle(color: Colors.black87),
                                      border: OutlineInputBorder(),
                                      filled: true,
                                      fillColor: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 2, 0, 4),
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.always,
                                  controller: companyName,
                                  decoration: const InputDecoration(
                                      hintText: '(ถ้ามี)',
                                      labelText: 'Company : ชื่อบริษัท',
                                      labelStyle:
                                          TextStyle(color: Colors.black87),
                                      border: OutlineInputBorder(),
                                      filled: true,
                                      fillColor: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 2, 0, 6),
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.always,
                                  controller: midname,
                                  decoration: const InputDecoration(
                                      hintText: '(ถ้ามี)',
                                      labelText: 'Position : ตำแหน่ง',
                                      labelStyle:
                                          TextStyle(color: Colors.black87),
                                      border: OutlineInputBorder(),
                                      filled: true,
                                      fillColor: Colors.white),
                                ),
                              ),
                              TextFormField(
                                autovalidateMode: AutovalidateMode.always,
                                controller: mobilePhone,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(
                                      r'[0-9]')), // ใช้ input formatter เพื่อจำกัดให้เป็นตัวเลขเท่านั้น
                                ],
                                validator: Validatorless.multiple([
                                  Validatorless.required('กรอกตัวเลข 10 หลัก'),
                                  Validatorless.number('กรอกเฉพาะตัวเลข'),
                                  Validatorless.min(10, 'กรอกให้ครบ 10 หลัก'),
                                  Validatorless.max(10, 'เกิน 10 หลัก'),
                                ]),
                                decoration: const InputDecoration(
                                    labelText: 'Tel. : เบอร์โทรติดต่อ',
                                    labelStyle:
                                        TextStyle(color: Colors.black87),
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white),
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
            ),
          );
  }
}
