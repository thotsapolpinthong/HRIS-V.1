import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hris_app_prototype/src/model/address/dropdown/district_model.dart';
import 'package:hris_app_prototype/src/model/address/dropdown/province.dart';
import 'package:hris_app_prototype/src/model/cardinfomation/idcard/update/getidentifycard_model.dart';
import 'package:hris_app_prototype/src/model/cardinfomation/idcard/update/updateidcard_model.dart';
import 'package:hris_app_prototype/src/services/api_personal_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';
import 'package:intl/intl.dart';

class UpdateIdCard extends StatefulWidget {
  final String personId;
  final GetIdCardModel? idcardData;
  const UpdateIdCard(
      {super.key, required this.personId, required this.idcardData});

  @override
  State<UpdateIdCard> createState() => _UpdateIdCardState();
}

class _UpdateIdCardState extends State<UpdateIdCard> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isloading = true;
  GetIdCardModel? idcardData;
  List<ProvinceDatum> provinceList = [];
  String? provinceId;

  List<DistrictDatum> districtList = [];
  String? districtId;
  bool districtload = true;

  TextEditingController idcard = TextEditingController();
  TextEditingController issueDate = TextEditingController();
  TextEditingController expDate = TextEditingController();
  TextEditingController comment = TextEditingController();

  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() {
    setState(() {
      idcardData = widget.idcardData;
      if (idcardData != null) {
        idcard.text = idcardData!.personalCardData.cardId;
        issueDate.text = idcardData!.personalCardData.issuedDate;
        expDate.text = idcardData!.personalCardData.expiredDate;
        provinceId = idcardData!.personalCardData.issuedAtProvince.provinceId;
        districtId = idcardData!.personalCardData.issuedAtDistrict.districtId;
        fetchdDataProvince();
        fetchdDataDistricts();
        isloading = false;
      } else {
        idcard.text = "ไม่พบข้อมูล";
        issueDate.text = "0000-00-00";
        expDate.text = "0000-00-00";
      }
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

  Future<void> _selectissueDate() async {
    DateFormat format = DateFormat('yyyy-MM-dd');
    DateTime dateTime = format.parse(issueDate.text);
    DateTime? _picker = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1950),
      lastDate: DateTime(3000),
    );
    if (_picker != null) {
      setState(() {
        issueDate.text = _picker.toString().split(" ")[0];
      });
    }
  }

  Future<void> _selectexpDate() async {
    DateFormat format = DateFormat('yyyy-MM-dd');
    DateTime dateTime = format.parse(expDate.text);
    DateTime? _picker = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (_picker != null) {
      setState(() {
        expDate.text = _picker.toString().split(" ")[0];
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
                                onsave();
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

  onsave() async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    UpdateIdcardModel idcardModel = UpdateIdcardModel(
      id: idcardData!.personalCardData.id,
      cardId: idcardData!.personalCardData.cardId,
      personId: idcardData!.personalCardData.personId,
      issuedDate: issueDate.text,
      expiredDate: expDate.text,
      issuedAtDistrictId: districtId.toString(),
      issuedAtProvinceId: provinceId.toString(),
      modifiedBy: employeeId,
      comment: comment.text,
    );
    bool success = await ApiService.updateIdCard(idcardModel);

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
                  'Update ID Card Success.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'แก้ไขข้อมูลบัตรประชาชน สำเร็จ',
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
                  'Update ID Card Fail.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'แก้ไขข้อมูลบัตรประชาชน ไม่สำเร็จ',
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
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              height: 350,
              child: Column(
                children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        elevation: 2,
                        child: TextFormField(
                          validator: Validatorless.multiple([
                            Validatorless.number('กรอกเฉพาะตัวเลข'),
                          ]),
                          controller: idcard,
                          decoration: InputDecoration(
                              hintText: 'กรอกเฉพาะตัวเลข',
                              labelText: 'ID Card : เลขบัตรประจำตัวประชาชน',
                              labelStyle:
                                  const TextStyle(color: Colors.black87),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              filled: true,
                              fillColor: Colors.grey[100]),
                        ),
                      ),
                      Card(
                        elevation: 2,
                        child: TextFormField(
                          controller: issueDate,
                          decoration: const InputDecoration(
                            labelText: 'วันออกบัตร',
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
                            _selectissueDate();
                          },
                        ),
                      ),
                      Card(
                        elevation: 2,
                        child: TextFormField(
                          controller: expDate,
                          decoration: const InputDecoration(
                            labelText: 'วันหมดอายุบัคร',
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
                            _selectexpDate();
                          },
                        ),
                      ),
                      Card(
                        elevation: 2,
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                              labelText: 'Province.',
                              labelStyle: TextStyle(color: Colors.black87),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              filled: true,
                              fillColor: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                          hint: const Text("Province."),
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
                              } else {
                                provinceId = newValue.toString();
                                fetchdDataDistricts();
                              }
                            });
                          },
                        ),
                      ),
                      Card(
                        elevation: 2,
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                              labelText: 'District.',
                              labelStyle: TextStyle(color: Colors.black87),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              filled: true,
                              fillColor: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                          hint: const Text("District."),
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
                            });
                          },
                        ),
                      ),
                    ],
                  )),
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
                            showdialogEdit();
                          },
                          child: const Text(
                            "save",
                            style: TextStyle(color: Colors.black87),
                          )),
                    )),
                  )
                ],
              ),
            ));
  }
}
