import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_app_prototype/src/bloc/personal_bloc/personal_bloc.dart';
import 'package:hris_app_prototype/src/model/address/dropdown/district_model.dart';
import 'package:hris_app_prototype/src/model/address/dropdown/province.dart';
import 'package:hris_app_prototype/src/model/cardinfomation/idcard/add/create_idcard_model.dart';
import 'package:hris_app_prototype/src/model/cardinfomation/idcard/update/getidentifycard_model.dart';
import 'package:hris_app_prototype/src/services/api_web_service.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

class AddIdCard extends StatefulWidget {
  final String personId;
  final bool addButton;
  const AddIdCard({
    super.key,
    required this.personId,
    required this.addButton,
  });

  @override
  State<AddIdCard> createState() => _AddIdCardState();
}

class _AddIdCardState extends State<AddIdCard> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isloading = true;
  GetIdCardModel? idcardData;
  List<ProvinceDatum> provinceList = [];
  String? provinceId;

  List<DistrictDatum> districtList = [];
  String? districtId;
  bool disableExp = false;

  TextEditingController idcard = TextEditingController();
  TextEditingController issueDate = TextEditingController();
  TextEditingController expDate = TextEditingController();

  @override
  void initState() {
    fetchdDataProvince();
    super.initState();
  }

  fetchdDataProvince() async {
    ProvinceModel? _provinceModel = await ApiService.getProvince();

    setState(() {
      provinceList = _provinceModel!.provinceData;
      isloading = false;
    });
  }

  fetchdDataDistricts() async {
    DistrictModel _distictdata = await ApiService.getdistrict(provinceId!);
    setState(() {
      districtList = _distictdata.districtData;
    });
  }

  void onValidate() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        AddNewIdcardModel addIdcardModel = AddNewIdcardModel(
          cardId: idcard.text,
          personId: widget.personId,
          issuedDate: issueDate.text,
          expiredDate: expDate.text,
          issuedAtDistrictId: districtId.toString(),
          issuedAtProvinceId: provinceId.toString(),
        );
        context
            .read<PersonalBloc>()
            .add(CreatedIdCardEvent(newIdcardModel: addIdcardModel));
      });
      context.read<PersonalBloc>().add(IsValidateProfileEvent());
      context.read<PersonalBloc>().add(CardValidateEvent());
      context.read<PersonalBloc>().add(ContinueEvent());
    } else {
      context.read<PersonalBloc>().add(IsNotValidateProfileEvent());
      context.read<PersonalBloc>().add(CardValidateEvent());
      context.read<PersonalBloc>().add(DissContinueEvent());
    }
  }

  //เช็คความถูกต้องรหัสบัตรประชาชน
  bool checkID(String id) {
    if (id.substring(0, 1) == '0') return false;
    if (id.length != 13) return false;
    double sum = 0;
    for (int i = 0; i < 12; i++) {
      sum += double.parse(id[i]) * (13 - i);
    }
    if ((11 - sum % 11) % 10 != double.parse(id[12])) return false;
    return true;
  }

  Future<void> _selectissueDate() async {
    DateTime? _picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(3000),
    );
    if (_picker != null) {
      setState(() {
        issueDate.text = _picker.toString().split(" ")[0];
        disableExp = true;
        expDate.text = "";
        onValidate();
      });
    }
  }

  Future<void> _selectexpDate() async {
    DateFormat format = DateFormat('yyyy-MM-dd');
    DateTime dateTime = format.parse(issueDate.text);
    DateTime? _picker = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: dateTime,
      lastDate: DateTime(3000),
    );
    if (_picker != null) {
      setState(() {
        expDate.text = _picker.toString().split(" ")[0];
        onValidate();
      });
    }
  }

  onadd() async {
    AddNewIdcardModel addIdcardModel = AddNewIdcardModel(
      cardId: idcard.text,
      personId: widget.personId,
      issuedDate: issueDate.text,
      expiredDate: expDate.text,
      issuedAtDistrictId: districtId.toString(),
      issuedAtProvinceId: provinceId.toString(),
    );
    bool success = await ApiService.addIdCardbyId(addIdcardModel);

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
                  'Add ID Card Success.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'เพิ่มข้อมูลบัตรประชาชน สำเร็จ',
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
                  'Add ID Card Fail.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'เพิ่มข้อมูลบัตรประชาชน ไม่สำเร็จ',
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
            child: Column(
              children: [
                SizedBox(height: 56),
                CircularProgressIndicator(),
              ],
            ),
          )
        : Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: SizedBox(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (widget.addButton == false)
                            const SizedBox(height: 56),
                          Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.always,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(
                                      r'[0-9]')), // ใช้ input formatter เพื่อจำกัดให้เป็นตัวเลขเท่านั้น
                                ],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'กรุณากรอกรหัสประชาชน';
                                  }
                                  if (!checkID(value)) {
                                    return 'รหัสประชาชนไม่ถูกต้อง';
                                  }
                                  return null;
                                  // รหัสถูกต้อง
                                },
                                onChanged: (value) {
                                  onValidate();
                                },
                                controller: idcard,
                                decoration: const InputDecoration(
                                    hintText: 'กรอกเฉพาะตัวเลข',
                                    labelText:
                                        'ID Card : เลขบัตรประจำตัวประชาชน',
                                    labelStyle:
                                        TextStyle(color: Colors.black87),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white),
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Card(
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: TextFormField(
                                      autovalidateMode: AutovalidateMode.always,
                                      validator: Validatorless.required(
                                          'กรุณากรอกข้อมูล'),
                                      controller: issueDate,
                                      decoration: const InputDecoration(
                                        labelText: 'Issued Date : วันออกบัตร',
                                        labelStyle:
                                            TextStyle(color: Colors.black),
                                        filled: true,
                                        fillColor: Colors.white,
                                        suffixIcon: Icon(
                                          Icons.calendar_today,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                      ),
                                      readOnly: true,
                                      onTap: () {
                                        _selectissueDate();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Card(
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: TextFormField(
                                      autovalidateMode: AutovalidateMode.always,
                                      controller: expDate,
                                      validator: Validatorless.required(
                                          'กรุณากรอกข้อมูล'),
                                      decoration: const InputDecoration(
                                        labelText:
                                            'Expired Date : วันหมดอายุบัคร',
                                        labelStyle:
                                            TextStyle(color: Colors.black),
                                        filled: true,
                                        fillColor: Colors.white,
                                        suffixIcon: Icon(
                                          Icons.calendar_today,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                      ),
                                      readOnly: true,
                                      enabled: disableExp,
                                      onTap: () {
                                        _selectexpDate();
                                      },
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
                                  child: DropdownButtonFormField(
                                    autovalidateMode: AutovalidateMode.always,
                                    validator: Validatorless.required(
                                        'กรุณากรอกข้อมูล'),
                                    decoration: const InputDecoration(
                                        labelText:
                                            'ออกให้ ณ จังหวัด : Province.',
                                        labelStyle:
                                            TextStyle(color: Colors.black87),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white),
                                    borderRadius: BorderRadius.circular(8),
                                    value: provinceId,
                                    items: provinceList.map((e) {
                                      return DropdownMenuItem<String>(
                                        value: e.provinceId.toString(),
                                        child: Text(e.provinceNameTh),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        if (districtId != null) {
                                          provinceId = newValue.toString();
                                          districtId = null;
                                          fetchdDataDistricts();

                                          onValidate();
                                        } else {
                                          provinceId = newValue.toString();
                                          fetchdDataDistricts();

                                          onValidate();
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Card(
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: DropdownButtonFormField(
                                      autovalidateMode: AutovalidateMode.always,
                                      validator: Validatorless.required(
                                          'กรุณากรอกข้อมูล'),
                                      decoration: const InputDecoration(
                                          labelText:
                                              'ออกให้ ณ เขต/อำเภอ : District.',
                                          labelStyle:
                                              TextStyle(color: Colors.black87),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white),
                                      borderRadius: BorderRadius.circular(8),
                                      value: districtId,
                                      items: districtList.map((e) {
                                        return DropdownMenuItem<String>(
                                          value: e.districtId.toString(),
                                          child: Text(e.districtNameTh),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          districtId = newValue.toString();

                                          onValidate();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      )),
                      if (widget.addButton == true)
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.greenAccent,
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    onadd();
                                  } else {}
                                },
                                child: const Text(
                                  "Add",
                                  style: TextStyle(color: Colors.black87),
                                )),
                          )),
                        )
                    ],
                  ),
                ),
              ),
            ));
  }
}
