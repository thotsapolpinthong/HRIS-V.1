// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_address.dart';
import 'package:validatorless/validatorless.dart';

class CreateOt extends StatefulWidget {
  const CreateOt({super.key});

  @override
  State<CreateOt> createState() => _CreateOtState();
}

class _CreateOtState extends State<CreateOt> {
  TextEditingController selectedDate = TextEditingController();
  TextEditingController scanIn = TextEditingController();
  TextEditingController scanOut = TextEditingController();
  TextEditingController totalScan = TextEditingController();

  List<OtTypeData> otTypeList = [
    OtTypeData(id: "1", name: "OT-normal"),
    OtTypeData(id: "2", name: "Holiday"),
    OtTypeData(id: "3", name: "OT-holiday"),
    OtTypeData(id: "4", name: "OT-แบบเหมา")
  ];
  String? otTypeId;
  List<RequestTypeData> requestTypeList = [
    RequestTypeData(id: "1", name: "OT-ก่อนเริ่มงาน"),
    RequestTypeData(id: "2", name: "OT-หลังเลิกงาน")
  ];
  String? requestTypeId;

  List<HourSelect> hourSelectList = [
    HourSelect(id: "1"),
    HourSelect(id: "2"),
    HourSelect(id: "3"),
    HourSelect(id: "4"),
    HourSelect(id: "5"),
    HourSelect(id: "6"),
    HourSelect(id: "7"),
    HourSelect(id: "8"),
    HourSelect(id: "9"),
    HourSelect(id: "10"),
  ];
  String? hourSelect;

  List<MinuteSelect> minuteSelectList = [
    MinuteSelect(id: "10"),
    MinuteSelect(id: "20"),
    MinuteSelect(id: "30"),
    MinuteSelect(id: "40"),
    MinuteSelect(id: "50"),
  ];
  String? minuteSelect;

  Future<void> selectvalidFromDate() async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(9999),
    );
    if (picker != null) {
      setState(() {
        selectedDate.text = picker.toString().split(" ")[0];
        scanIn.text = "08:00:00";
        scanOut.text = "17:00:00";
        totalScan.text = "9";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
              child: Column(
            children: [
              const Gap(5),
              Card(
                child: TextFormField(
                  controller: selectedDate,
                  autovalidateMode: AutovalidateMode.always,
                  validator: Validatorless.required('*กรุณากรอกข้อมูล'),
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: Icon(
                      Icons.calendar_today_rounded,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54),
                    ),
                  ),
                  readOnly: true,
                  onTap: () {
                    selectvalidFromDate();
                  },
                ),
              ),
              const Gap(3),
              Row(children: [
                Expanded(
                    child: TextFormFieldGlobal(
                        controller: scanIn,
                        labelText: "Time Scan In",
                        hintText: "",
                        validatorless: null,
                        enabled: false)),
                Expanded(
                    child: TextFormFieldGlobal(
                        controller: scanOut,
                        labelText: "Time Scan Out",
                        hintText: "",
                        validatorless: null,
                        enabled: false)),
              ]),
              const Gap(3),
              TextFormFieldGlobal(
                  controller: totalScan,
                  labelText: "Total (hr.)",
                  hintText: "",
                  validatorless: null,
                  enabled: false),
              const Gap(3),
              Row(
                children: [
                  Expanded(
                    child: DropdownOrg(
                        labeltext: 'OT Type',
                        value: otTypeId,
                        items: otTypeList.map((e) {
                          return DropdownMenuItem<String>(
                            value: e.id.toString(),
                            child: Container(
                                constraints: const BoxConstraints(
                                    maxWidth: 100, minWidth: 70),
                                child: Text(e.name)),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          otTypeId = newValue.toString();
                        },
                        validator: null),
                  ),
                  Expanded(
                    child: DropdownOrg(
                        labeltext: 'Request Type',
                        value: requestTypeId,
                        items: requestTypeList.map((e) {
                          return DropdownMenuItem<String>(
                            value: e.id.toString(),
                            child: Container(
                                constraints: const BoxConstraints(
                                    maxWidth: 130, minWidth: 70),
                                child: Text(e.name)),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          requestTypeId = newValue.toString();
                        },
                        validator: null),
                  ),
                ],
              ),
              const Gap(3),
              Row(
                children: [
                  Expanded(
                    child: DropdownOrg(
                        labeltext: 'Hour',
                        value: hourSelect,
                        items: hourSelectList.map((e) {
                          return DropdownMenuItem<String>(
                            value: e.id.toString(),
                            child: Container(
                                constraints: const BoxConstraints(
                                    maxWidth: 100, minWidth: 70),
                                child: Text(e.id)),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            hourSelect = newValue.toString();
                          });
                        },
                        validator: null),
                  ),
                  Expanded(
                    child: DropdownOrg(
                        labeltext: 'Minute',
                        value: minuteSelect,
                        items: minuteSelectList.map((e) {
                          return DropdownMenuItem<String>(
                            value: e.id.toString(),
                            child: Container(
                                constraints: const BoxConstraints(
                                    maxWidth: 130, minWidth: 70),
                                child: Text(e.id)),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          minuteSelect = newValue.toString();
                        },
                        validator: null),
                  ),
                ],
              ),
            ],
          )),
        ),
        MySaveButtons(
          text: "Save",
          onPressed: hourSelect != null ? () {} : null,
        )
      ],
    );
  }
}

class OtTypeData {
  final String id;
  final String name;
  OtTypeData({
    required this.id,
    required this.name,
  });
}

class RequestTypeData {
  final String id;
  final String name;
  RequestTypeData({
    required this.id,
    required this.name,
  });
}

class HourSelect {
  final String id;
  HourSelect({
    required this.id,
  });
}

class MinuteSelect {
  final String id;
  MinuteSelect({
    required this.id,
  });
}
