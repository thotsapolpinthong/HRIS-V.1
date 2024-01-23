// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_address.dart';
import 'package:validatorless/validatorless.dart';

class CreateManualWorkdate extends StatefulWidget {
  const CreateManualWorkdate({super.key});

  @override
  State<CreateManualWorkdate> createState() => _CreateManualWorkdateState();
}

class _CreateManualWorkdateState extends State<CreateManualWorkdate> {
  TextEditingController selectedDate = TextEditingController();
  TextEditingController scanIn = TextEditingController();
  TextEditingController scanOut = TextEditingController();

  List<TypeManualWorkdate> typeList = [
    // TypeManualWorkdate(id: "A01", name: "เวลาเข้างาน"),
    // TypeManualWorkdate(id: "A02", name: "เวลาออกงาน")
  ];
  String? typeId;

  Future<void> selectvalidFromDate() async {
    DateTime? picker = await showDatePicker(
      // selectableDayPredicate: (DateTime val) => val.weekday == 7 ? false : true,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(9999),
    );
    if (picker != null) {
      setState(() {
        selectedDate.text = picker.toString().split(" ")[0];
        scanIn.text = "08:00:00";
        scanOut.text = "";
        if (selectedDate.text == "2024-01-17") {
          scanOut.text = "17:00:00";
        }

        if (scanIn.text != "" && scanOut.text != "") {
          typeList = [];
        } else {
          typeList = [
            TypeManualWorkdate(id: "A01", name: "เวลาเข้างาน"),
            TypeManualWorkdate(id: "A02", name: "เวลาออกงาน")
          ];
        }
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
              DropdownOrg(
                  labeltext: 'OT Type',
                  value: typeId,
                  items: typeList.map((e) {
                    return DropdownMenuItem<String>(
                      value: e.id.toString(),
                      child: Container(
                          constraints:
                              const BoxConstraints(maxWidth: 100, minWidth: 70),
                          child: Text(e.name)),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    typeId = newValue.toString();
                  },
                  validator: null),
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
            ],
          )),
        ),
        MySaveButtons(
          text: "Save",
          onPressed: null,
        )
      ],
    );
  }
}

class TypeManualWorkdate {
  final String id;
  final String name;
  TypeManualWorkdate({
    required this.id,
    required this.name,
  });
}
