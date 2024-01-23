// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_address.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';

class TransferMenu extends StatefulWidget {
  final EmployeeDatum employeeData;
  const TransferMenu({
    Key? key,
    required this.employeeData,
  }) : super(key: key);

  @override
  State<TransferMenu> createState() => _TransferMenuState();
}

class _TransferMenuState extends State<TransferMenu> {
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
                    maxWidth: 450,
                    maxHeight: 380,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFormFieldDatepickGlobal(
                              controller: selectedDate,
                              labelText: "วันที่เริ่มตำแหน่งใหม่",
                              validatorless: null,
                              ontap: () {
                                // selectvalidFromDate();
                              }),
                          MySaveButtons(
                            text: "Accept",
                            onPressed: () {},
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
