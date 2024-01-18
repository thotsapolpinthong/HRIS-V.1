import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_app_prototype/src/bloc/personal_bloc/personal_bloc.dart';
import 'package:hris_app_prototype/src/model/contact_person/add/create_contact_model.dart';
import 'package:hris_app_prototype/src/model/person/dropdown/title.dart';
import 'package:hris_app_prototype/src/services/api_personal_service.dart';
import 'package:validatorless/validatorless.dart';

class AddContactPerson extends StatefulWidget {
  final String personId;
  final bool addButton;
  const AddContactPerson({
    super.key,
    required this.personId,
    required this.addButton,
  });

  @override
  State<AddContactPerson> createState() => _AddContactPersonState();
}

class _AddContactPersonState extends State<AddContactPerson> {
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
  @override
  initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    TitleModel title = await ApiService.getTitle();
    setState(() {
      titlenameList = title.titleNameData;
    });
  }

  void onValidate() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        CreateContactModel createContactModel = CreateContactModel(
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
        );

        context.read<PersonalBloc>().add(
            CreatedContactModelEvent(createContactModel: createContactModel));
      });
      context.read<PersonalBloc>().add(IsValidateProfileEvent());
      context.read<PersonalBloc>().add(ContactValidateEvent());
      context.read<PersonalBloc>().add(ContinueEvent());
    } else {
      context.read<PersonalBloc>().add(IsNotValidateProfileEvent());
      context.read<PersonalBloc>().add(ContactValidateEvent());
      context.read<PersonalBloc>().add(DissContinueEvent());
    }
  }

  void onNewValue() {}

  onadd() async {
    CreateContactModel createContactModel = CreateContactModel(
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
    );

    bool success = await ApiService.createContactById(createContactModel);

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
                  'Add Contact Person Information Success.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'เพิ่มข้อมูลบุคคลที่สามารถติดต่อได้ สำเร็จ',
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
                  'Add Contact Person Information Fail.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'เพิ่มข้อมูลบุคคลที่สามารถติดต่อได้ ไม่สำเร็จ',
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
                child: Column(
                  children: [
                    Expanded(
                        flex: 12,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ListView(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 8, 2, 4),
                                      child: Card(
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
                                          onChanged: (value) {
                                            onNewValue();
                                            onValidate();
                                          },
                                          decoration: const InputDecoration(
                                              labelText:
                                                  'Relation : ความสัมพันธ์',
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
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(2, 8, 0, 4),
                                      child: Card(
                                        child: DropdownButtonFormField(
                                          autovalidateMode:
                                              AutovalidateMode.always,
                                          decoration: const InputDecoration(
                                              labelText: 'Title : คำนำหน้า',
                                              labelStyle: TextStyle(
                                                  color: Colors.black87),
                                              border: OutlineInputBorder(),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black26),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          validator: Validatorless.required(
                                              'กรุณากรอกข้อมูล'),
                                          value: titlename,
                                          items: titlenameList?.map((e) {
                                            return DropdownMenuItem<String>(
                                              value: e.titleNameId.toString(),
                                              child: SizedBox(
                                                  width: 140,
                                                  child: Text(
                                                      '${e.titleNameEn} : ${e.titleNameTh}')),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              titlename = newValue.toString();
                                              onNewValue();
                                              onValidate();
                                            });
                                          },
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
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 2, 2, 4),
                                      child: Card(
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
                                          onChanged: (value) {
                                            onNewValue();
                                            onValidate();
                                          },
                                          decoration: const InputDecoration(
                                              labelText: 'Firstname : ชื่อ',
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
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(2, 2, 0, 4),
                                      child: Card(
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
                                          onChanged: (value) {
                                            onNewValue();
                                            onValidate();
                                          },
                                          decoration: const InputDecoration(
                                              labelText: 'Lastname : นามสกุล',
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
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 4, 2, 4),
                                      child: Card(
                                        child: TextFormField(
                                          autovalidateMode:
                                              AutovalidateMode.always,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[a-zA-Zก-๙]')),
                                          ],
                                          controller: midname,
                                          onChanged: (value) {
                                            onNewValue();
                                          },
                                          decoration: const InputDecoration(
                                              hintText: '(ถ้ามี)',
                                              labelText: 'Midname : ชื่อกลาง',
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
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(2, 4, 0, 4),
                                      child: Card(
                                        child: TextFormField(
                                          validator: null,
                                          controller: occupation,
                                          onChanged: (value) {
                                            onNewValue();
                                            onValidate();
                                          },
                                          decoration: const InputDecoration(
                                              labelText: 'Occupation : อาชีพ',
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
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 2, 2, 4),
                                      child: Card(
                                        child: TextFormField(
                                          autovalidateMode:
                                              AutovalidateMode.always,
                                          controller: companyName,
                                          onChanged: (value) {
                                            onNewValue();
                                          },
                                          decoration: const InputDecoration(
                                              hintText: '(ถ้ามี)',
                                              labelText: 'Company : ชื่อบริษัท',
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
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(2, 2, 0, 6),
                                      child: Card(
                                        child: TextFormField(
                                          autovalidateMode:
                                              AutovalidateMode.always,
                                          controller: midname,
                                          onChanged: (value) {
                                            onNewValue();
                                          },
                                          decoration: const InputDecoration(
                                              hintText: '(ถ้ามี)',
                                              labelText: 'Position : ตำแหน่ง',
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
                                    ),
                                  )
                                ],
                              ),
                              Card(
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.always,
                                  controller: mobilePhone,
                                  onChanged: (value) {
                                    onNewValue();
                                    onValidate();
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(
                                        r'[0-9]')), // ใช้ input formatter เพื่อจำกัดให้เป็นตัวเลขเท่านั้น
                                  ],
                                  validator: Validatorless.multiple([
                                    Validatorless.required(
                                        'กรอกตัวเลข 10 หลัก'),
                                    Validatorless.number('กรอกเฉพาะตัวเลข'),
                                    Validatorless.min(10, 'กรอกให้ครบ 10 หลัก'),
                                    Validatorless.max(10, 'เกิน 10 หลัก'),
                                  ]),
                                  decoration: const InputDecoration(
                                      labelText: 'Tel. : เบอร์โทรติดต่อ',
                                      labelStyle:
                                          TextStyle(color: Colors.black87),
                                      border: OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black26),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white),
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
            ),
          );
  }
}
