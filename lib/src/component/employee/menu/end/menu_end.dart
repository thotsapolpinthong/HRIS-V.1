// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_address.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';

class EndofEmploymentMenu extends StatefulWidget {
  final EmployeeDatum employeeData;
  const EndofEmploymentMenu({
    Key? key,
    required this.employeeData,
  }) : super(key: key);

  @override
  State<EndofEmploymentMenu> createState() => _EndofEmploymentMenuState();
}

class _EndofEmploymentMenuState extends State<EndofEmploymentMenu> {
  TextEditingController selectedDate = TextEditingController();

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
      });
    }
  }

  alertDialogInfo() {
    AwesomeDialog(
            width: 400,
            context: context,
            animType: AnimType.topSlide,
            dialogType: DialogType.info,
            title: "INFO",
            desc:
                'สิ้นสุดการเป็นพนักงาน\n${widget.employeeData.personData.titleName.titleNameTh} ${widget.employeeData.personData.fisrtNameTh} ${widget.employeeData.personData.lastNameTh}',
            btnOkColor: Colors.red[700],
            btnOkText: "Accept",
            btnOkOnPress: () {
              alertDialog(true);
            },
            btnCancelOnPress: () {
              alertDialog(false);
            },
            btnCancelColor: Colors.greenAccent)
        .show();
  }

  alertDialog(bool success) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      width: 450,
      context: context,
      animType: AnimType.topSlide,
      dialogType: success == true ? DialogType.success : DialogType.error,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Column(
            children: [
              Text(
                success == true
                    ? 'End of employment Success.'
                    : 'End of employment Fail.',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              Text(
                success == true
                    ? 'บันทึกข้อมูล สำเร็จ'
                    : 'บันทึกข้อมูล ไม่สำเร็จ',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
      btnOkColor: success == true ? Colors.greenAccent : Colors.red,
      btnOkOnPress: () {
        if (success == true) {
          Navigator.pop(context);
        } else {}
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
                constraints: const BoxConstraints(
                    maxWidth: 400,
                    maxHeight: 200,
                    minWidth: 300,
                    minHeight: 100),
                child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    color: mygreycolors,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextFormFieldDatepickGlobal(
                              controller: selectedDate,
                              labelText: "วันที่สิ้นสุดการเป็นพนักงาน",
                              validatorless: null,
                              ontap: () {
                                selectvalidFromDate();
                              }),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red[700]),
                                  onPressed: () {
                                    alertDialogInfo();
                                  },
                                  child: const Text("สิ้นสุดการเป็นพนักงาน")),
                            ),
                          )
                        ],
                      ),
                    ))),
          ),
        ),
      ),
    );
  }
}
