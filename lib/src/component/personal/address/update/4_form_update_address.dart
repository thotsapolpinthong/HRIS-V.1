import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_address.dart';
import 'package:hris_app_prototype/src/model/address/addressbyperson_model.dart';
import 'package:hris_app_prototype/src/model/address/dropdown/addresstype_model.dart';
import 'package:hris_app_prototype/src/model/address/dropdown/country_model.dart';
import 'package:hris_app_prototype/src/model/address/dropdown/district_model.dart';
import 'package:hris_app_prototype/src/model/address/dropdown/province.dart';
import 'package:hris_app_prototype/src/model/address/dropdown/subdistrict_Model.dart';
import 'package:hris_app_prototype/src/model/address/update/update_address-model.dart';
import 'package:hris_app_prototype/src/services/api_web_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateAddressByType extends StatefulWidget {
  final String personId;
  final String addressType;
  final AddressDatum data;
  const UpdateAddressByType(
      {super.key,
      required this.personId,
      required this.addressType,
      required this.data});

  @override
  State<UpdateAddressByType> createState() => _UpdateAddressByTypeState();
}

class _UpdateAddressByTypeState extends State<UpdateAddressByType> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
  TextEditingController comment = TextEditingController();

  fetchAddressDataById() async {
    setState(() {
      homeNumber.text = widget.data.homeNumber.toString();
      moo.text = widget.data.moo;
      housingProject.text = widget.data.housingProject;
      street.text = widget.data.street;
      soi.text = widget.data.soi;
      postCode.text = widget.data.postCode;
      homePhoneNumber.text = widget.data.homePhoneNumber;
      typeaddressId = widget.data.addressTypeData.addressTypeId;
      provinceId = widget.data.provinceData.provinceId;
      districtId = widget.data.districtData.districtId;
      subDistrictId = widget.data.subDistrictData.subDistrictId;
      countryId = widget.data.countryData.countryId;

      fetchCountryDataDropdown();
      fetchdDataProvince();
      fetchdDataDistricts();
      fetchdDataSubdistricts();
      isloading = false;
    });
  }

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

  fetchdDataDistricts() async {
    DistrictModel _distictdata = await ApiService.getdistrict(provinceId!);
    setState(() {
      districtList = _distictdata.districtData;
    });
  }

  fetchdDataSubdistricts() async {
    SubdistrictModel _subdistictData =
        await ApiService.getsubdistrict(districtId!);
    setState(() {
      subDistrictList = _subdistictData.subDistrictData;
    });
  }

  Future<void> onSave() async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    UpdateAddressbypersonModel updateAddressbyid = UpdateAddressbypersonModel(
      addressId: widget.data.addressId,
      addressTypeId: widget.addressType,
      personId: widget.personId,
      homeNumber: homeNumber.text,
      moo: moo.text,
      housingProject: housingProject.text,
      street: street.text,
      soi: soi.text,
      subDistrictId: subDistrictId.toString(),
      postcode: postCode.text,
      countryId: countryId.toString(),
      homePhoneNumber: homePhoneNumber.text,
      comment: comment.text,
      modifiedBy: employeeId,
    );
    bool success = await ApiService.updateAddressbyId(updateAddressbyid);

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
                  'Update Address Success.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'แก้ไขข้อมูลที่อยู่ สำเร็จ',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          btnOkOnPress: () {},
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
                  'Update PermanentAddress Fail.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'แก้ไขข้อมูลที่อยู่ ไม่สำเร็จ',
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
    fetchAddressDataById();
    super.initState();
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
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                decoration: BoxDecoration(
                    color: mygreycolors,
                    borderRadius: BorderRadius.circular(12)),
                height: 285,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: MyTextFormfieldAddress(
                                          controller: homeNumber,
                                          labelText: 'Home Number.',
                                          hintText: 'บ้านเลขที่',
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: DropdownButtonFormField(
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
                                              hint: const Text("Country."),
                                              value: countryId,
                                              items: countryList.map((e) {
                                                return DropdownMenuItem<String>(
                                                  value: e.countryId.toString(),
                                                  child: SizedBox(
                                                      width: 140,
                                                      child: Text(
                                                          e.countryNameTh)),
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
                                              hint: const Text("Province."),
                                              value: provinceId,
                                              items: provinceList.map((e) {
                                                return DropdownMenuItem<String>(
                                                  value:
                                                      e.provinceId.toString(),
                                                  child: SizedBox(
                                                      width: 140,
                                                      child: Text(
                                                          e.provinceNameTh)),
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
                                              hint: const Text("District."),
                                              value: districtId,
                                              items: districtList.map((e) {
                                                return DropdownMenuItem<String>(
                                                  value:
                                                      e.districtId.toString(),
                                                  child: SizedBox(
                                                      width: 140,
                                                      child: Text(
                                                          e.districtNameTh)),
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
                                              hint: const Text("Sub-district."),
                                              value: subDistrictId,
                                              items: subDistrictList.map((e) {
                                                return DropdownMenuItem<String>(
                                                  value: e.subDistrictId
                                                      .toString(),
                                                  child: SizedBox(
                                                      width: 140,
                                                      child: Text(
                                                          e.subDistrictNameTh)),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: MyTextFormfieldAddress(
                                                controller: postCode,
                                                labelText: 'Postcode.',
                                                hintText: 'รหัสไปรษณีย์')),
                                        Expanded(
                                            flex: 2,
                                            child: MyTextFormfieldAddress(
                                                controller: homePhoneNumber,
                                                labelText: 'Home Phone Number.',
                                                hintText: 'เบอร์โทรศัพท์บ้าน')),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Expanded(
                        child: Row(
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
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
                        validator:
                            RequiredValidator(errorText: 'กรุณากรอกข้อมูล'),
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
                                onSave();
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
}
