import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_address.dart';
import 'package:hris_app_prototype/src/model/address/addAddress/add_address_model.dart';
import 'package:hris_app_prototype/src/model/address/dropdown/addresstype_model.dart';
import 'package:hris_app_prototype/src/model/address/dropdown/country_model.dart';
import 'package:hris_app_prototype/src/model/address/dropdown/district_model.dart';
import 'package:hris_app_prototype/src/model/address/dropdown/province.dart';
import 'package:hris_app_prototype/src/model/address/dropdown/subdistrict_Model.dart';
import 'package:hris_app_prototype/src/services/api_web_service.dart';
import 'package:validatorless/validatorless.dart';

class AddPermanentAddress extends StatefulWidget {
  final String personId;
  const AddPermanentAddress({super.key, required this.personId});

  @override
  State<AddPermanentAddress> createState() => _AddPermanentAddressState();
}

class _AddPermanentAddressState extends State<AddPermanentAddress> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final requiredValidator = RequiredValidator(errorText: 'กรุณากรอกข้อมูล');
  bool isCheckedIdCard = false;
  bool isCheckedPresent = false;
  bool isloading = true;

  List<AddressTypeDatum> typeaddressList = [];
  String? typeaddressId;

  List<ProvinceDatum> provinceList = [];
  String? provinceId;

  List<DistrictDatum> districtList = [];
  String? districtId;
  bool districtload = true;

  List<SubDistrictDatum> subDistrictList = [];
  String? subDistrictId;

  List<CountryDatum> countryList = [];
  String? countryId;

  TextEditingController homeNumber = TextEditingController();
  TextEditingController moo = TextEditingController();
  TextEditingController housingProject = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController soi = TextEditingController();
  TextEditingController postCode = TextEditingController();
  TextEditingController homePhoneNumber = TextEditingController();

  fetchCountryDataDropdown() async {
    CountryDataModel _countryDataModel = await ApiService.getCountry();
    setState(() {
      countryList = _countryDataModel.countryData;
    });
  }

  fetchdDataProvince() async {
    ProvinceModel _provinceModel = await ApiService.getProvince();
    setState(() {
      provinceList = _provinceModel.provinceData;
    });
  }

  Future fetchdDataDistricts() async {
    DistrictModel _distictdata = await ApiService.getdistrict(provinceId!);
    setState(() {
      districtList = _distictdata.districtData;
    });
  }

  Future fetchdDataSubdistricts() async {
    SubdistrictModel _subdistictData =
        await ApiService.getsubdistrict(districtId!);
    setState(() {
      subDistrictList = _subdistictData.subDistrictData;
    });
  }

  Future<void> onSaveID() async {
    Createaddressmodel createaddressID = Createaddressmodel(
      addressTypeId: "1",
      personId: widget.personId.toString(),
      homeNumber: homeNumber.text,
      moo: moo.text,
      housingProject: housingProject.text,
      street: street.text,
      soi: soi.text,
      subDistrictId: subDistrictId.toString(),
      postcode: postCode.text,
      countryId: countryId.toString(),
      homePhoneNumber: homePhoneNumber.text,
    );

    await ApiService.addAddressByTypeAndId(createaddressID);
  }

  Future<void> onSavePresent() async {
    Createaddressmodel createaddressPresent = Createaddressmodel(
      addressTypeId: "3",
      personId: widget.personId.toString(),
      homeNumber: homeNumber.text,
      moo: moo.text,
      housingProject: housingProject.text,
      street: street.text,
      soi: soi.text,
      subDistrictId: subDistrictId.toString(),
      postcode: postCode.text,
      countryId: countryId.toString(),
      homePhoneNumber: homePhoneNumber.text,
    );

    await ApiService.addAddressByTypeAndId(createaddressPresent);
  }

  Future<void> onSave() async {
    Createaddressmodel createaddressPermanent = Createaddressmodel(
      addressTypeId: "2",
      personId: widget.personId.toString(),
      homeNumber: homeNumber.text,
      moo: moo.text,
      housingProject: housingProject.text,
      street: street.text,
      soi: soi.text,
      subDistrictId: subDistrictId.toString(),
      postcode: postCode.text,
      countryId: countryId.toString(),
      homePhoneNumber: homePhoneNumber.text,
    );

    bool success =
        await ApiService.addAddressByTypeAndId(createaddressPermanent);
    setState(() {
      if (success == true) {
        AwesomeDialog(
          width: 500,
          context: context,
          animType: AnimType.topSlide,
          dialogType: DialogType.success,
          body: const Center(
            child: Column(
              children: [
                Text(
                  'Add PermanentAddress Success.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'เพิ่มข้อมูลที่อยู่ตามทะเบียนบ้าน สำเร็จ',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          btnOkOnPress: () {
            setState(() {
              // Navigator.pushAndRemoveUntil<void>(
              //   context,
              //   MaterialPageRoute<void>(
              //       builder: (BuildContext context) => const PersonalPage()),
              //   ModalRoute.withName('/'),
              // );
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
            child: Column(
              children: [
                Text(
                  'Add PermanentAddress Fail.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'เพิ่มข้อมูลที่อยู่ตามทะเบียนบ้าน ไม่สำเร็จ',
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
  void initState() {
    fetchCountryDataDropdown();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: SizedBox(
          height: 312,
          child: Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    color: Colors.grey[100],
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: MyTextFormfieldNumber(
                                        controller: homeNumber,
                                        labelText: 'Home Number.',
                                        hintText: 'บ้านเลขที่*',
                                      )),
                                      Expanded(
                                          child:
                                              MyTextFormfieldAddressunvalidator(
                                        controller: moo,
                                        labelText: 'Moo.',
                                        hintText: 'หมู่',
                                      )),
                                      Expanded(
                                          child:
                                              MyTextFormfieldAddressunvalidator(
                                        controller: housingProject,
                                        labelText: 'Housing Project.',
                                        hintText: 'หมู่บ้าน / อาคาร',
                                      )),
                                      Expanded(
                                          child:
                                              MyTextFormfieldAddressunvalidator(
                                        controller: street,
                                        labelText: 'Street.',
                                        hintText: 'ถนน',
                                      )),
                                      Expanded(
                                          child:
                                              MyTextFormfieldAddressunvalidator(
                                        controller: soi,
                                        labelText: 'Alley.',
                                        hintText: 'ซอย',
                                      )),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: DropdownButtonFormField(
                                            autovalidateMode:
                                                AutovalidateMode.always,
                                            validator: Validatorless.required(
                                                'เลือกข้อมูล'),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            decoration: const InputDecoration(
                                                labelText: 'Çountry.',
                                                labelStyle: TextStyle(
                                                    color: Colors.black87),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white),
                                            hint: const Text("Country.*",
                                                style: TextStyle(
                                                    color: Colors.red)),
                                            value: countryId,
                                            items: countryList.map((e) {
                                              return DropdownMenuItem<String>(
                                                value: e.countryId.toString(),
                                                child: Text(e.countryNameTh),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              countryId = newValue.toString();
                                              setState(() {
                                                fetchdDataProvince();
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: DropdownButtonFormField(
                                            autovalidateMode:
                                                AutovalidateMode.always,
                                            validator: Validatorless.required(
                                                'เลือกข้อมูล'),
                                            decoration: const InputDecoration(
                                                labelText: 'Province.',
                                                labelStyle: TextStyle(
                                                    color: Colors.black87),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            hint: const Text("Province.*",
                                                style: TextStyle(
                                                    color: Colors.red)),
                                            value: provinceId,
                                            items: provinceList.map((e) {
                                              return DropdownMenuItem<String>(
                                                value: e.provinceId.toString(),
                                                child: Text(e.provinceNameTh),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                if (districtId != null ||
                                                    subDistrictId != null) {
                                                  provinceId =
                                                      newValue.toString();
                                                  districtId = null;
                                                  subDistrictId = null;
                                                  fetchdDataDistricts();
                                                } else {
                                                  provinceId =
                                                      newValue.toString();
                                                  fetchdDataDistricts();
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: DropdownButtonFormField(
                                            autovalidateMode:
                                                AutovalidateMode.always,
                                            validator: Validatorless.required(
                                                'เลือกข้อมูล'),
                                            decoration: const InputDecoration(
                                                labelText: 'District.',
                                                labelStyle: TextStyle(
                                                    color: Colors.black87),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            hint: const Text("District.*",
                                                style: TextStyle(
                                                    color: Colors.red)),
                                            value: districtId,
                                            items: districtList.map((e) {
                                              return DropdownMenuItem<String>(
                                                value: e.districtId.toString(),
                                                child: Text(e.districtNameTh),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                if (subDistrictId != null) {
                                                  districtId =
                                                      newValue.toString();
                                                  subDistrictId = null;
                                                  fetchdDataSubdistricts();
                                                } else {
                                                  districtId =
                                                      newValue.toString();
                                                  fetchdDataSubdistricts();
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: DropdownButtonFormField(
                                            autovalidateMode:
                                                AutovalidateMode.always,
                                            validator: Validatorless.required(
                                                'เลือกข้อมูล'),
                                            decoration: const InputDecoration(
                                                labelText: 'Sub-district.',
                                                labelStyle: TextStyle(
                                                    color: Colors.black87),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            hint: const Text("Sub-district.*",
                                                style: TextStyle(
                                                    color: Colors.red)),
                                            value: subDistrictId,
                                            items: subDistrictList.map((e) {
                                              return DropdownMenuItem<String>(
                                                value:
                                                    e.subDistrictId.toString(),
                                                child:
                                                    Text(e.subDistrictNameTh),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                subDistrictId =
                                                    newValue.toString();
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: MyTextFormfieldNumber(
                                              controller: postCode,
                                              labelText: 'Postcode.',
                                              hintText: 'รหัสไปรษณีย์*')),
                                      Expanded(
                                          flex: 2,
                                          child:
                                              MyTextFormfieldAddressunvalidator(
                                                  controller: homePhoneNumber,
                                                  labelText:
                                                      'Home Phone Number.',
                                                  hintText:
                                                      'เบอร์โทรศัพท์บ้าน')),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(" ที่อยู่ตามบัตรประชาชน"),
                            Checkbox(
                                activeColor: Colors.deepPurple,
                                value: isCheckedIdCard,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isCheckedIdCard = value!;
                                  });
                                }),
                            const Text("ที่อยู่ปัจจุบัน"),
                            Checkbox(
                                activeColor: Colors.deepPurple,
                                value: isCheckedPresent,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isCheckedPresent = value!;
                                  });
                                }),
                            Padding(
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
                                    if (isCheckedIdCard == true &&
                                        isCheckedPresent == false) {
                                      onSave();
                                      onSaveID();
                                    }
                                    if (isCheckedIdCard == false &&
                                        isCheckedPresent == true) {
                                      onSave();
                                      onSavePresent();
                                    }
                                    if (isCheckedIdCard == true &&
                                        isCheckedPresent == true) {
                                      onSave();
                                      onSaveID();
                                      onSavePresent();
                                    } else {
                                      onSave();
                                    }
                                  } else {
                                    // การตรวจสอบไม่ผ่าน
                                    // ทำสิ่งที่คุณต้องการเมื่อข้อมูลไม่ถูกต้อง
                                  }
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
