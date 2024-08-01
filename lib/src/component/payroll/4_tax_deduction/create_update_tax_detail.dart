// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/payroll/tax_deduction/tax_detail_all_model.dart';
import 'package:hris_app_prototype/src/model/payroll/tax_deduction/update_tax_detail_model.dart';
import 'package:hris_app_prototype/src/services/api_payroll_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class EditTaxDetails extends StatefulWidget {
  final bool onEdit;
  final TaxDetailDatum? data;
  final Function() fetchData;
  const EditTaxDetails({
    Key? key,
    required this.onEdit,
    this.data,
    required this.fetchData,
  }) : super(key: key);

  @override
  State<EditTaxDetails> createState() => _EditTaxDetailsState();
}

class _EditTaxDetailsState extends State<EditTaxDetails> {
  TextEditingController id = TextEditingController();
  TextEditingController topic = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController comment = TextEditingController();

  @override
  void initState() {
    super.initState();
    id.text = widget.data?.id ?? "";
    topic.text = widget.data?.topic ?? "";
    amount.text = widget.data?.amount.toString() ?? "";
  }

  Future update() async {
    String userEmployeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userEmployeeId = preferences.getString("employeeId")!;
    UpdateTaxDetailModel updateModel = UpdateTaxDetailModel(
        id: widget.data!.id,
        topic: topic.text,
        amount: double.parse(amount.text),
        modifyBy: userEmployeeId,
        comment: comment.text);
    bool success = await ApiPayrollService.updateTaxDetails(updateModel);
    alertDialog(success);
    if (success) widget.fetchData();
  }

  alertDialog(bool success) {
    MyDialogSuccess.alertDialog(context, success, widget.onEdit, "Tax Details");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormFieldGlobal(
                    controller: id, labelText: "ID", enabled: false),
                const Gap(5),
                TextFormFieldGlobal(
                    controller: topic, labelText: "Topic", enabled: true),
                const Gap(5),
                TextFormFieldGlobal(
                  controller: amount,
                  labelText: "Amount",
                  enabled: true,
                  suffixText: "THB",
                ),
                const Gap(5),
                if (widget.onEdit)
                  TextFormFieldGlobal(
                    controller: comment,
                    labelText: "Comment",
                    enabled: true,
                    validatorless: Validatorless.required("required"),
                  ),
              ],
            ),
          ),
        ),
        MySaveButtons(
          text: "Update",
          onPressed: () {
            setState(() {
              if (widget.onEdit) {
                update();
              }
            });
          },
        )
      ],
    );
  }
}
