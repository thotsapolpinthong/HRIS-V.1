// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
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
  final List<int> onYearList;
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
  //sso
  TextEditingController ssoPercent = TextEditingController();
  TextEditingController ssoMin = TextEditingController();
  TextEditingController ssoMax = TextEditingController();
  TextEditingController ssoMinSalary = TextEditingController();
  TextEditingController ssoMaxSalary = TextEditingController();
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
        ssoPercent: int.parse(ssoPercent.text),
        ssoMin: double.parse(ssoMin.text),
        ssoMax: double.parse(ssoMax.text),
        ssoMinSalary: double.parse(ssoMinSalary.text),
        ssoMaxSalary: double.parse(ssoMaxSalary.text),
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
        ssoPercent: int.parse(ssoPercent.text),
        ssoMin: double.parse(ssoMin.text),
        ssoMax: double.parse(ssoMax.text),
        ssoMinSalary: double.parse(ssoMinSalary.text),
        ssoMaxSalary: double.parse(ssoMaxSalary.text),
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
      startDate.text = widget.onLotNumber!.startDate.substring(0, 10);
      finishDate.text = widget.onLotNumber!.finishDate.substring(0, 10);
      salaryPaidDate.text = widget.onLotNumber!.salaryPaidDate.substring(0, 10);
      otPaidDate.text = widget.onLotNumber!.otPaidDate.substring(0, 10);
      ssoPercent.text = widget.onLotNumber!.ssoPercent.toString();
      ssoMin.text = widget.onLotNumber!.ssoMin.toString();
      ssoMax.text = widget.onLotNumber!.ssoMax.toString();
      ssoMinSalary.text = widget.onLotNumber!.ssoMinSalary.toString();
      ssoMaxSalary.text = widget.onLotNumber!.ssoMaxSalary.toString();
    } else {
      ssoPercent.text = "5";
      ssoMin.text = "83";
      ssoMax.text = "750";
      ssoMinSalary.text = "1650";
      ssoMaxSalary.text = "15000";
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
              child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text("LOT",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: mythemecolor)),
                    const Gap(5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: DropdownGlobal(
                              labeltext: 'Lot year',
                              value: yearId,
                              items: widget.onYearList.map((e) {
                                return DropdownMenuItem<String>(
                                  value: e.toString(),
                                  child: SizedBox(
                                      width: 58, child: Text(e.toString())),
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
                    const Gap(3),
                    TextFormFieldDatepickGlobal(
                        controller: startDate,
                        labelText: "วันที่เริ่มต้น",
                        validatorless: Validatorless.required("โปรดระบุ"),
                        ontap: () {
                          selectvalidFromDate(0);
                        }),
                    const Gap(3),
                    TextFormFieldDatepickGlobal(
                        controller: finishDate,
                        labelText: "วันที่สิ้นสุด",
                        validatorless: Validatorless.required("โปรดระบุ"),
                        ontap: () {
                          selectvalidFromDate(1);
                        }),
                    const Gap(3),
                    TextFormFieldDatepickGlobal(
                        controller: salaryPaidDate,
                        labelText: "Salary paid date",
                        validatorless: Validatorless.required("โปรดระบุ"),
                        ontap: () {
                          selectvalidFromDate(2);
                        }),
                    const Gap(3),
                    TextFormFieldDatepickGlobal(
                        controller: otPaidDate,
                        labelText: "Ot paid date",
                        validatorless: Validatorless.required("โปรดระบุ"),
                        ontap: () {
                          selectvalidFromDate(3);
                        }),
                  ],
                ),
              ),
              const Gap(5),
              VerticalDivider(
                thickness: 2.5,
                color: mythemecolor,
              ),
              const Gap(5),
              Expanded(
                child: Column(
                  children: [
                    Text("SSO",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: mythemecolor)),
                    const Gap(5),
                    TextFormFieldGlobal(
                        controller: ssoPercent,
                        labelText: "ssoPercent",
                        validatorless: Validatorless.required("โปรดระบุ"),
                        suffixText: "%",
                        onChanged: (p0) => setState(() {}),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                        ],
                        enabled: true),
                    const Gap(3),
                    TextFormFieldGlobal(
                        controller: ssoMin,
                        labelText: "ssoMin",
                        validatorless: Validatorless.required("โปรดระบุ"),
                        suffixText: "บาท",
                        onChanged: (p0) => setState(() {}),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                        ],
                        enabled: true),
                    const Gap(3),
                    TextFormFieldGlobal(
                        controller: ssoMax,
                        labelText: "ssoMax",
                        validatorless: Validatorless.required("โปรดระบุ"),
                        suffixText: "บาท",
                        onChanged: (p0) => setState(() {}),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                        ],
                        enabled: true),
                    const Gap(3),
                    TextFormFieldGlobal(
                        controller: ssoMinSalary,
                        labelText: "ssoMinSalary",
                        validatorless: Validatorless.required("โปรดระบุ"),
                        suffixText: "บาท",
                        onChanged: (p0) => setState(() {}),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                        ],
                        enabled: true),
                    const Gap(3),
                    TextFormFieldGlobal(
                        controller: ssoMaxSalary,
                        labelText: "ssoMaxSalary",
                        validatorless: Validatorless.required("โปรดระบุ"),
                        suffixText: "บาท",
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                        ],
                        onChanged: (p0) => setState(() {}),
                        enabled: true),
                  ],
                ),
              ),
            ],
          )),
          MySaveButtons(
            text: widget.onEdit == false ? "Create" : "Update",
            onPressed: _formKey.currentState?.validate() != true
                ? null
                : () {
                    setState(() {
                      if (widget.onEdit == true) {
                        //function update
                        updateLot();
                      } else {
                        //function create
                        createLot();
                      }
                    });
                  },
          )
        ],
      ),
    );
  }
}
