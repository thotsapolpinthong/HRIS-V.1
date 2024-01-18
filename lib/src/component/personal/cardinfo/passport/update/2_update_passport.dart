import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hris_app_prototype/src/model/address/dropdown/country_model.dart';
import 'package:hris_app_prototype/src/model/cardinfomation/passport/update/editpassport_model.dart';
import 'package:hris_app_prototype/src/model/cardinfomation/passport/update/getpassport_model.dart';
import 'package:hris_app_prototype/src/services/api_personal_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';
import 'package:intl/intl.dart';

class UpdatePassport extends StatefulWidget {
  final String personId;
  final Getpassport? passportData;
  const UpdatePassport(
      {super.key, required this.personId, required this.passportData});

  @override
  State<UpdatePassport> createState() => _UpdatePassportState();
}

class _UpdatePassportState extends State<UpdatePassport> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isloading = true;
  Getpassport? passportData;
  TextEditingController passportId = TextEditingController();
  TextEditingController expireDateVisa = TextEditingController();
  TextEditingController expiredDatePassport = TextEditingController();
  TextEditingController comment = TextEditingController();

  List<CountryDatum> countryList = [];
  String? countryId;

  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() {
    setState(() {
      passportData = widget.passportData;
      if (passportData != null) {
        passportId.text = passportData!.passportData.passportId;
        expiredDatePassport.text =
            passportData!.passportData.expiredDatePassport;
        expireDateVisa.text = passportData!.passportData.expireDateVisa;
        countryId = passportData!.passportData.issuedAtCountry.countryId;
        fetchCountryDataDropdown();
        isloading = false;
      } else {
        passportId.text = "ไม่พบข้อมูล";
        expiredDatePassport.text = "0000-00-00";
        expireDateVisa.text = "0000-00-00";
      }
    });
  }

  fetchCountryDataDropdown() async {
    CountryDataModel _countryDataModel = await ApiService.getCountry();
    setState(() {
      countryList = _countryDataModel.countryData;
    });
  }

  Future<void> _selectvisaDate() async {
    DateFormat format = DateFormat('yyyy-MM-dd');
    DateTime dateTime = format.parse(expireDateVisa.text);
    DateTime? _picker = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1950),
      lastDate: DateTime(3000),
    );
    if (_picker != null) {
      setState(() {
        expireDateVisa.text = _picker.toString().split(" ")[0];
      });
    }
  }

  Future<void> _selectpassportDate() async {
    DateFormat format = DateFormat('yyyy-MM-dd');
    DateTime dateTime = format.parse(expiredDatePassport.text);
    DateTime? _picker = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1950),
      lastDate: DateTime(3000),
    );
    if (_picker != null) {
      setState(() {
        expiredDatePassport.text = _picker.toString().split(" ")[0];
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
    EditPassportModel passportModel = EditPassportModel(
      id: passportData!.passportData.id,
      passportId: passportId.text,
      personId: passportData!.passportData.personId,
      issuedAtCountry: countryId.toString(),
      expiredDatePassport: expiredDatePassport.text,
      expireDateVisa: expireDateVisa.text,
      modifiedBy: employeeId,
      comment: comment.text,
    );
    bool success = await ApiService.updatePassport(passportModel);

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
                  'Update Passport Success.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'แก้ไขข้อมูลพาสปอร์ท สำเร็จ',
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
                  'Update Passport Fail.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'แก้ไขข้อมูลพาสปอร์ท ไม่สำเร็จ',
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
                            Validatorless.required('กรุณากรอกขอมูล'),
                          ]),
                          controller: passportId,
                          decoration: InputDecoration(
                              hintText: 'กรอกเฉพาะตัวเลข',
                              labelText:
                                  'Passport Number : เลขที่หนังสือเดินทาง',
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
                          controller: expiredDatePassport,
                          decoration: const InputDecoration(
                            labelText: 'วันหมดอายุหนังสือเดินทาง',
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
                            _selectpassportDate();
                          },
                        ),
                      ),
                      Card(
                        elevation: 2,
                        child: TextFormField(
                          controller: expireDateVisa,
                          decoration: const InputDecoration(
                            labelText: 'วันหมดอายุวิช่า',
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
                            _selectvisaDate();
                          },
                        ),
                      ),
                      Card(
                        elevation: 2,
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                              labelText: 'Country.',
                              labelStyle: TextStyle(color: Colors.black87),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              filled: true,
                              fillColor: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                          hint: const Text("Country."),
                          value: countryId,
                          items: countryList.map((e) {
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
