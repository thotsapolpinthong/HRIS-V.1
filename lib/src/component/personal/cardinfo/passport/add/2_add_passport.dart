import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_app_prototype/src/bloc/personal_bloc/personal_bloc.dart';
import 'package:hris_app_prototype/src/model/address/dropdown/country_model.dart';
import 'package:hris_app_prototype/src/model/cardinfomation/passport/add/createpassport_model.dart';
import 'package:hris_app_prototype/src/model/cardinfomation/passport/update/getpassport_model.dart';
import 'package:hris_app_prototype/src/services/api_web_service.dart';
import 'package:validatorless/validatorless.dart';

class AddPassport extends StatefulWidget {
  final String personId;
  final bool addButton;
  const AddPassport(
      {super.key, required this.personId, required this.addButton});

  @override
  State<AddPassport> createState() => _AddPassportState();
}

class _AddPassportState extends State<AddPassport> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isloading = true;
  Getpassport? passportData;
  TextEditingController passportId = TextEditingController();
  TextEditingController expireDateVisa = TextEditingController();
  TextEditingController expiredDatePassport = TextEditingController();

  List<CountryDatum> countryList = [];
  String? countryId;

  @override
  void initState() {
    fetchCountryDataDropdown();
    super.initState();
  }

  fetchCountryDataDropdown() async {
    CountryDataModel _countryDataModel = await ApiService.getCountry();
    setState(() {
      countryList = _countryDataModel.countryData;
      isloading = false;
    });
  }

  Future<void> _selectvisaDate() async {
    DateTime? _picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(3000),
    );
    if (_picker != null) {
      setState(() {
        expireDateVisa.text = _picker.toString().split(" ")[0];
        onNewValue();
        onValidate();
      });
    }
  }

  Future<void> _selectpassportDate() async {
    DateTime? _picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(3000),
    );
    if (_picker != null) {
      setState(() {
        expiredDatePassport.text = _picker.toString().split(" ")[0];
        onNewValue();
        onValidate();
      });
    }
  }

  void onValidate() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        CreatePassportModel addpassportModel = CreatePassportModel(
          passportId: passportId.text,
          personId: widget.personId,
          issuedAtCountry: countryId.toString(),
          expiredDatePassport: expiredDatePassport.text,
          expireDateVisa: expireDateVisa.text,
        );
        context
            .read<PersonalBloc>()
            .add(CreatedPassportEvent(passportModel: addpassportModel));
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

  void onNewValue() {}

  onadd() async {
    CreatePassportModel addpassportModel = CreatePassportModel(
      passportId: passportId.text,
      personId: widget.personId,
      issuedAtCountry: countryId.toString(),
      expiredDatePassport: expiredDatePassport.text,
      expireDateVisa: expireDateVisa.text,
    );
    bool success = await ApiService.addPassportbyId(addpassportModel);

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
                  'Add Passport Success.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'เพิ่มข้อมูลพาสปอร์ท สำเร็จ',
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
                  'Add Passport Fail.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'เพิ่มข้อมูลพาสปอร์ท ไม่สำเร็จ',
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
                height: 465,
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
                            elevation: 1,
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.always,
                              validator: Validatorless.multiple([
                                Validatorless.required('กรุณากรอกข้อมูล'),
                                Validatorless.max(9, 'Overvalue'),
                                Validatorless.min(9, 'กรอกให้ครบ 9 หลัก')
                              ]),
                              controller: passportId,
                              onChanged: (newValue) {
                                onNewValue();
                                onValidate();
                              },
                              decoration: const InputDecoration(
                                  labelText:
                                      'Passport Number : เลขที่หนังสือเดินทาง',
                                  labelStyle: TextStyle(color: Colors.black87),
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black26),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white),
                            ),
                          ),
                          Card(
                            elevation: 1,
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.always,
                              validator:
                                  Validatorless.required('กรุณากรอกข้อมูล'),
                              controller: expiredDatePassport,
                              decoration: const InputDecoration(
                                labelText:
                                    'Expiring Date : วันหมดอายุหนังสือเดินทาง',
                                labelStyle: TextStyle(color: Colors.black),
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: Icon(
                                  Icons.calendar_today,
                                ),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black26),
                                ),
                              ),
                              readOnly: true,
                              onTap: () {
                                _selectpassportDate();
                              },
                            ),
                          ),
                          Card(
                            elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.always,
                                validator:
                                    Validatorless.required('กรุณากรอกข้อมูล'),
                                controller: expireDateVisa,
                                decoration: const InputDecoration(
                                  labelText: 'Expiring Visa : วันหมดอายุวิช่า',
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
                          ),
                          Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: DropdownButtonFormField(
                                autovalidateMode: AutovalidateMode.always,
                                validator:
                                    Validatorless.required('กรุณากรอกข้อมูล'),
                                decoration: const InputDecoration(
                                    labelText: 'At Country. : ออกให้ ณ ประเทศ',
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
                                borderRadius: BorderRadius.circular(8),
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
                                    onNewValue();
                                    onValidate();
                                  });
                                },
                              ),
                            ),
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
