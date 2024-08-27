// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/payroll/payroll/insert_extrawage_model.dart';
import 'package:hris_app_prototype/src/model/payroll/payroll/payrikk_data_by_id_model.dart';
import 'package:hris_app_prototype/src/model/payroll/payroll/payroll_data_model.dart';
import 'package:hris_app_prototype/src/services/api_payroll_service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PayrollDetailsManagement extends StatefulWidget {
  const PayrollDetailsManagement({
    Key? key,
    required this.employee_id,
    required this.lotYear,
    required this.lotMonth,
    required this.fetchData,
  }) : super(key: key);
  final String employee_id;
  final String lotYear;
  final String lotMonth;
  final Function() fetchData;
  @override
  State<PayrollDetailsManagement> createState() =>
      _PayrollDetailsManagementState();
}

class _PayrollDetailsManagementState extends State<PayrollDetailsManagement> {
  TextEditingController extraWage = TextEditingController();
  TextEditingController deductWage = TextEditingController();

  PayrollDatum? data;
  bool isDataLoading = false;

  Future fetchDataById() async {
    setState(() => isDataLoading = true);
    PayrollByIdModel? dataModel = await ApiPayrollService.getPayrollDataById(
        widget.lotYear, widget.lotMonth, widget.employee_id);
    if (dataModel != null) {
      setState(() {
        data = dataModel.payrollData;
        isDataLoading = false;
      });
    }
  }

  getNumberDesimal(double value) {
    NumberFormat numberFormat = NumberFormat("#,##0.00", "en_US");
    String number;
    if (value == 0) {
      number = "0";
    } else {
      number = numberFormat.format(value);
    }
    return number;
  }

  Widget dataTextfield(String text, String label) {
    TextEditingController data = TextEditingController();
    data.text = text;
    return TextFormFieldGlobal(
        controller: data, labelText: label, enabled: false);
  }

  Widget valueTextfield(
      double value, String label, String? suffix, Color? colors) {
    TextEditingController data = TextEditingController();
    data.text = getNumberDesimal(value);
    return TextFormFieldGlobal(
      controller: data,
      labelText: label,
      enabled: false,
      suffixText: suffix ?? "บาท",
      fillColor: colors,
    );
  }

  Widget employeeData() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const TextThai(
              text: "- ข้อมูลพนักงาน -",
            ),
            const Gap(3),
            Row(
              children: [
                Expanded(
                  child: dataTextfield(
                      "${data!.lotYear} / ${data!.lotMonth}", "Lot"),
                ),
                Expanded(child: dataTextfield(data!.employeeId, "Employee ID")),
              ],
            ),
            dataTextfield(data!.idCard, "ID Card"),
            dataTextfield("${data!.firstName}  ${data!.lastName}", "Name"),
            Row(
              children: [
                Expanded(
                    child: dataTextfield(data!.organizationCode, "Department")),
                Expanded(
                  child: dataTextfield(data!.staffType, "Type"),
                ),
              ],
            ),
            dataTextfield(data!.positionName, "Position")
          ],
        ),
      ),
    );
  }

  Widget totalIncome() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const TextThai(
              text: "- รายได้ -",
            ),
            const Gap(3),
            valueTextfield(data!.salary, "เงินเดือน", null, null),
            Row(children: [
              Expanded(
                child:
                    valueTextfield(data!.workAmount, "รวมวันทำงาน", null, null),
              ),
              Expanded(
                  child: valueTextfield(
                      data!.holidayOtWage, "ทำงานวันหยุด", null, null))
            ]),
            Row(children: [
              Expanded(
                child: valueTextfield(
                    data!.normalOtWage, "โอที-ธรรมดา", null, null),
              ),
              Expanded(
                  child: valueTextfield(
                      data!.holidayOtWage, "โอที-วันหยุด", null, null))
            ]),
            Row(children: [
              Expanded(
                child: valueTextfield(data!.bonus, "โบนัส", null, null),
              ),
              Expanded(
                  child:
                      valueTextfield(data!.shiftFee, "ค่าแรงจูงใจ", null, null))
            ]),
            Row(children: [
              Expanded(
                child: valueTextfield(data!.allowance, "ค่าอาหาร", null, null),
              ),
              Expanded(
                  child: valueTextfield(
                      data!.extraWage, "เงินพิเศษ", null, Colors.blue[50]))
            ]),
          ],
        ),
      ),
    );
  }

  Widget totalDeduct() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const TextThai(
              text: "- รายการหัก -",
            ),
            const Gap(3),
            valueTextfield(data!.leaveExceeds, "ลาเกิน", null, null),
            valueTextfield(data!.sso, "ประกันสังคม", null, null),
            valueTextfield(data!.tax, "หักภาษี", null, null),
            valueTextfield(data!.studentLoans, "หัก กยศ.", null, null),
            valueTextfield(data!.deductWage, "หักเงิน", null, Colors.red[50]),
          ],
        ),
      ),
    );
  }

  Widget totalnet() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const TextThai(
              text: "- สรุปรายได้ -",
            ),
            const Gap(3),
            valueTextfield(data!.totalSalary, "รายได้รวม", null, null),
            valueTextfield(data!.netSalary, "รายได้สุทธิ", null, null),
          ],
        ),
      ),
    );
  }

  Widget manageWage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const TextThai(
              text: "- เงินพิเศษ -",
            ),
            const Gap(3),
            TextFormFieldGlobal(
                controller: extraWage,
                labelText: "เพิ่มเงินพิเศษ",
                enabled: true,
                suffixText: "บาท",
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                ],
                onChanged: (p0) {
                  setState(() {});
                },
                outlineColor: Colors.blue[900]),
            TextFormFieldGlobal(
                controller: deductWage,
                labelText: "หักเงิน",
                enabled: true,
                suffixText: "บาท",
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                ],
                onChanged: (p0) {
                  setState(() {});
                },
                outlineColor: Colors.red[800])
          ],
        ),
      ),
    );
  }

  Future<void> onInsert() async {
    String userEmployeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userEmployeeId = preferences.getString("employeeId")!;
    InsertExtraWageModel createModel = InsertExtraWageModel(
        lotYear: data!.lotYear,
        lotMonth: data!.lotMonth,
        employeeId: data!.employeeId,
        extraWage: extraWage.text == ''
            ? data!.extraWage
            : double.parse(extraWage.text),
        deductWage: deductWage.text == ''
            ? data!.deductWage
            : double.parse(deductWage.text),
        modifyBy: userEmployeeId);
    bool success = await ApiPayrollService.insertExtraWage(createModel);
    alertDialog(success);
    if (success) {
      fetchDataById();
      widget.fetchData();
      extraWage.text = '';
      deductWage.text = '';
    }
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
                    ? 'Edit Extra / Deduct Wage Success.'
                    : 'Edit Extra / Deduct Wage Fail.',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              Text(
                success == true ? 'แก้ไขข้อมูลสำเร็จ' : 'แก้ไขข้อมูลไม่สำเร็จ',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
      btnOkColor: success == true ? Colors.greenAccent : Colors.red,
      btnOkOnPress: () {},
    ).show();
  }

  @override
  void initState() {
    super.initState();
    fetchDataById();
  }

  @override
  Widget build(BuildContext context) {
    return isDataLoading
        ? myLoadingScreen
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const TextThai(
                  text: "รายละเอียดการจ่ายเงินเดือน",
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 4, 18, 4),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: mygreycolors,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        color: Colors.grey, width: 3)),
                                child: employeeData()),
                          ),
                          const Gap(8),
                          Expanded(
                            child: Container(
                              height: 180,
                              decoration: BoxDecoration(
                                  color: mygreycolors,
                                  borderRadius: BorderRadius.circular(16),
                                  border:
                                      Border.all(color: Colors.grey, width: 3)),
                              child: totalIncome(),
                            ),
                          )
                        ],
                      )),
                      const Gap(8),
                      Expanded(
                          child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: mygreycolors,
                                  borderRadius: BorderRadius.circular(16),
                                  border:
                                      Border.all(color: Colors.grey, width: 3)),
                              child: totalDeduct(),
                            ),
                          ),
                          const Gap(8),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: mygreycolors,
                                  borderRadius: BorderRadius.circular(16),
                                  border:
                                      Border.all(color: Colors.grey, width: 3)),
                              child: totalnet(),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: mygreycolors,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        color: mythemecolor, width: 3)),
                                child: manageWage(),
                              ),
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: MySaveButtons(
                      text: "Update",
                      onPressed: extraWage.text == "" && deductWage.text == ""
                          ? null
                          : () => onInsert()),
                )
              ],
            ),
          );
  }
}
