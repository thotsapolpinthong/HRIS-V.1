// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/payroll/1_lot/lot_management_menu.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/payroll/lot_management/create_lot_model.dart';
import 'package:hris_app_prototype/src/model/payroll/lot_management/get_lotnumber_dropdown_model.dart';
import 'package:hris_app_prototype/src/model/payroll/lot_management/update_lot_model.dart';
import 'package:hris_app_prototype/src/services/api_payroll_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class EditLotNumber extends StatefulWidget {
  final bool onEdit;
  final LotNumberDatum? onLotNumber;
  final List<Year> onYearList;
  final Function() fetchData;
  const EditLotNumber({
    Key? key,
    required this.onEdit,
    this.onLotNumber,
    required this.onYearList,
    required this.fetchData,
  }) : super(key: key);

  @override
  State<EditLotNumber> createState() => _EditLotNumberState();
}

class _EditLotNumberState extends State<EditLotNumber> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? yearId;
  //Lot
  TextEditingController lotMonth = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController finishDate = TextEditingController();
  TextEditingController salaryPaidDate = TextEditingController();
  TextEditingController otPaidDate = TextEditingController();

  Future<void> selectvalidFromDate(int formFeild) async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(9999, 12, 31),
    );
    if (picker != null) {
      setState(() {
        switch (formFeild) {
          case 0: //วันที่เริ่ม
            startDate.text = picker.toString().split(" ")[0];
            break;
          case 1: //วันที่สิ้นสุด
            finishDate.text = picker.toString().split(" ")[0];
            break;
          case 2: //เงินเดือน
            salaryPaidDate.text = picker.toString().split(" ")[0];
            break;
          case 3: //โอที
            otPaidDate.text = picker.toString().split(" ")[0];
            break;
        }
      });
    }
  }

  void createLot() async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    CreateLotModel createModel = CreateLotModel(
        lotMonth: lotMonth.text,
        lotYear: yearId!,
        startDate: startDate.text,
        finishDate: finishDate.text,
        salaryPaidDate: salaryPaidDate.text,
        otPaidDate: otPaidDate.text,
        createBy: employeeId);
    bool success = await ApiPayrollService.createLot(createModel);
    alertDialog(success);
  }

  void updateLot() async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    UpdateLotModel updateModel = UpdateLotModel(
        lotNumberId: widget.onLotNumber!.lotNumberId,
        lotMonth: lotMonth.text,
        lotYear: yearId!,
        startDate: startDate.text,
        finishDate: finishDate.text,
        salaryPaidDate: salaryPaidDate.text,
        otPaidDate: otPaidDate.text,
        modifyBy: employeeId);
    bool success = await ApiPayrollService.updateLot(updateModel);
    alertDialog(success);
  }

  alertDialog(bool success) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      width: 500,
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
                    ? widget.onEdit == false
                        ? 'Created Lot Success.'
                        : 'Edit Lot Success.'
                    : widget.onEdit == false
                        ? 'Created Lot Fail.'
                        : 'Edit Lot Fail.',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              Text(
                success == true
                    ? widget.onEdit == false
                        ? 'เพิ่ม สำเร็จ'
                        : 'แก้ไข สำเร็จ'
                    : widget.onEdit == false
                        ? 'เพิ่ม ไม่สำเร็จ'
                        : 'แก้ไข ไม่สำเร็จ',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
      btnOkColor: success == true ? Colors.greenAccent : Colors.red,
      btnOkOnPress: () {
        widget.fetchData();
        Navigator.pop(context);
      },
    ).show();
  }

  @override
  void initState() {
    super.initState();
    if (widget.onEdit == true) {
      lotMonth.text = widget.onLotNumber!.lotMonth;
      yearId = widget.onLotNumber!.lotYear;
      startDate.text = widget.onLotNumber!.startDate;
      finishDate.text = widget.onLotNumber!.finishDate;
      salaryPaidDate.text = widget.onLotNumber!.salaryPaidDate;
      otPaidDate.text = widget.onLotNumber!.otPaidDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: DropdownGlobal(
                          labeltext: 'Lot year',
                          value: yearId,
                          items: widget.onYearList.map((e) {
                            return DropdownMenuItem<String>(
                              value: e.id,
                              child: SizedBox(width: 58, child: Text(e.year)),
                            );
                          }).toList(),
                          onChanged: (newValue) async {
                            setState(() {
                              yearId = newValue.toString();
                            });
                          },
                          validator: Validatorless.required("โปรดระบุ")),
                    ),
                    Expanded(
                      child: TextFormFieldGlobal(
                          controller: lotMonth,
                          labelText: "Lot number",
                          hintText: "Ex* 00",
                          validatorless: Validatorless.required("โปรดระบุ"),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.0-9/]')),
                            LengthLimitingTextInputFormatter(4),
                          ],
                          enabled: true),
                    )
                  ],
                ),
                const Gap(5),
                TextFormFieldDatepickGlobal(
                    controller: startDate,
                    labelText: "วันที่เริ่มต้น",
                    validatorless: Validatorless.required("โปรดระบุ"),
                    ontap: () {
                      selectvalidFromDate(0);
                    }),
                const Gap(5),
                TextFormFieldDatepickGlobal(
                    controller: finishDate,
                    labelText: "วันที่สิ้นสุด",
                    validatorless: Validatorless.required("โปรดระบุ"),
                    ontap: () {
                      selectvalidFromDate(1);
                    }),
                const Gap(5),
                TextFormFieldDatepickGlobal(
                    controller: salaryPaidDate,
                    labelText: "Salary paid date",
                    validatorless: Validatorless.required("โปรดระบุ"),
                    ontap: () {
                      selectvalidFromDate(2);
                    }),
                const Gap(5),
                TextFormFieldDatepickGlobal(
                    controller: otPaidDate,
                    labelText: "Ot paid date",
                    validatorless: Validatorless.required("โปรดระบุ"),
                    ontap: () {
                      selectvalidFromDate(3);
                    }),
              ],
            ),
          )),
          MySaveButtons(
            text: widget.onEdit == false ? "Create" : "Update",
            onPressed: () {
              if (_formKey.currentState!.validate() == true) {
                setState(() {
                  if (widget.onEdit == true) {
                    //function update
                    updateLot();
                  } else {
                    //function create
                    createLot();
                    print("success");
                  }
                });
              } else {
                print("fail");
              }
            },
          )
        ],
      ),
    );
  }
}
