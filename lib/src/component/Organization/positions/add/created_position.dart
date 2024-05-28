import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/organization_bloc/position_bloc/positions_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/organization/position/created_position_model.dart';
import 'package:hris_app_prototype/src/model/organization/position/getpositionall_model.dart';
import 'package:hris_app_prototype/src/model/organization/position/update_position_model.dart';
import 'package:hris_app_prototype/src/services/api_org_service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class EditPositions extends StatefulWidget {
  final bool onEdit;
  final PositionDatum? positions;
  const EditPositions({super.key, required this.onEdit, this.positions});

  @override
  State<EditPositions> createState() => _EditPositionsState();
}

class _EditPositionsState extends State<EditPositions> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameTH = TextEditingController();
  TextEditingController nameEN = TextEditingController();
  TextEditingController discription = TextEditingController();
  TextEditingController validFrom = TextEditingController();
  TextEditingController expFrom = TextEditingController();
  TextEditingController comment = TextEditingController();
  bool status = true;
  bool disableExp = false;

  Future<void> selectvalidFromDate() async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(9999, 12, 31),
    );
    if (picker != null) {
      setState(() {
        validFrom.text = picker.toString().split(" ")[0];
        disableExp = true;
        expFrom.text = "";
        // onValidate();
      });
    }
  }

  Future<void> selectexpDate() async {
    DateFormat format = DateFormat('yyyy-MM-dd');
    DateTime dateTime =
        validFrom.text == "" ? DateTime(1950) : format.parse(validFrom.text);
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime(9999, 12, 31),
      firstDate: dateTime,
      lastDate: DateTime(9999, 12, 31),
    );
    if (picker != null) {
      setState(() {
        expFrom.text = picker.toString().split(" ")[0];
        // onValidate();
      });
    }
  }

  showdialogEdit() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return MyDeleteBox(
            onPressedCancel: () {
              Navigator.pop(context);
              comment.text = '';
            },
            controller: comment,
            onPressedOk: () {
              onSave(comment.text);
              Navigator.pop(context);
              comment.text = '';
            },
          );
        });
  }

  Future onSave(String comment) async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    if (_formKey.currentState!.validate()) {
      UpdatePositionByIdModel updatedPosition = UpdatePositionByIdModel(
        positionId: widget.positions!.positionId.toString(),
        positionNameTh: nameTH.text,
        positionNameEn: nameEN.text,
        jobSpecification: discription.text,
        validFrom: validFrom.text,
        endDate: expFrom.text,
        positionStatus: status == true ? 'Active' : 'Inactive',
        modifiedBy: employeeId,
        comment: comment.toString(),
      );
      setState(() {});
      bool success = await ApiOrgService.updatedPositionById(updatedPosition);
      alertDialog(success);
    } else {}
  }

  Future onAdd() async {
    if (_formKey.currentState!.validate()) {
      CreatedPositionModel createdPosition = CreatedPositionModel(
        positionNameTh: nameTH.text,
        positionNameEn: nameEN.text,
        jobSpecification: discription.text,
        validFrom: validFrom.text,
        endDate: expFrom.text,
      );
      setState(() {});
      bool success = await ApiOrgService.createdPositions(createdPosition);
      alertDialog(success);
    } else {}
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
                        ? 'Created Position Success.'
                        : 'Edit Position Success.'
                    : widget.onEdit == false
                        ? 'Created Position Fail.'
                        : 'Edit Position Fail.',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              Text(
                success == true
                    ? widget.onEdit == false
                        ? 'เพิ่มตำแหน่งงาน สำเร็จ'
                        : 'แก้ไขตำแหน่งงาน สำเร็จ'
                    : widget.onEdit == false
                        ? 'เพิ่มตำแหน่งงาน ไม่สำเร็จ'
                        : 'แก้ไขตำแหน่งงาน ไม่สำเร็จ',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
      btnOkColor: success == true ? Colors.greenAccent : Colors.red,
      btnOkOnPress: () {
        setState(() {
          context.read<PositionsBloc>().add(FetchDataEvent());
          Navigator.pop(context);
        });
      },
    ).show();
  }

  @override
  void initState() {
    if (widget.onEdit == true) {
      nameTH.text = widget.positions!.positionNameTh;
      nameEN.text = widget.positions!.positionNameEn;
      discription.text = widget.positions!.jobSpecification;
      validFrom.text = widget.positions!.validFrom;
      expFrom.text = widget.positions!.endDate;
      status = widget.positions!.positionStatus == 'Active' ? true : false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  TextFormFieldGlobal(
                      controller: nameTH,
                      labelText: 'ชื่อตำแหน่งงาน (TH)',
                      hintText: 'ชื่อตำแหน่งงาน',
                      validatorless: Validatorless.required('*กรุณากรอกข้อมูล'),
                      enabled: true),
                  const Gap(5),
                  TextFormFieldGlobal(
                      controller: nameEN,
                      labelText: 'Position Name (EN)',
                      hintText: 'ชื่อตำแหน่งงาน',
                      validatorless: Validatorless.required('*กรุณากรอกข้อมูล'),
                      enabled: true),
                  const Gap(5),
                  TextFormFieldGlobal(
                      controller: discription,
                      labelText: 'Job Specification (TH/EN)',
                      hintText: 'อธิบายลักษณะงาน',
                      validatorless: Validatorless.required('*กรุณากรอกข้อมูล'),
                      enabled: true),
                  const Gap(5),
                  TextFormFieldDatepickGlobal(
                    controller: validFrom,
                    labelText: "มีผลตั้งแต่",
                    validatorless: Validatorless.required('*กรุณากรอกข้อมูล'),
                    ontap: () {
                      selectvalidFromDate();
                    },
                  ),
                  const Gap(5),
                  TextFormFieldDatepickGlobal(
                    controller: expFrom,
                    labelText: "สิ้นสุดเมื่อ",
                    validatorless: Validatorless.required('*กรุณากรอกข้อมูล'),
                    ontap: () {
                      selectexpDate();
                    },
                  ),
                  const Gap(5),
                ]),
              ),
            ),
            if (widget.onEdit == false)
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: BlocBuilder<PositionsBloc, PositionsState>(
                    builder: (context, state) {
                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                          ),
                          onPressed: () {
                            onAdd();
                          },
                          child: const Text(
                            "Add",
                            style: TextStyle(color: Colors.black87),
                          ));
                    },
                  ),
                ),
              )
            else
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: BlocBuilder<PositionsBloc, PositionsState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: status == true ? 2 : 0,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.horizontal(
                                                    left: Radius.circular(8))),
                                        backgroundColor: status == true
                                            ? Colors.greenAccent
                                            : Colors.grey[300],
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          status = true;
                                        });
                                      },
                                      child: const Text(
                                        "Active",
                                        style: TextStyle(color: Colors.black87),
                                      )),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: status == false ? 2 : 0,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.horizontal(
                                                    right: Radius.circular(8))),
                                        backgroundColor: status == false
                                            ? Colors.redAccent
                                            : Colors.grey[300],
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          status = false;
                                        });
                                      },
                                      child: const Text(
                                        "InActive",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.greenAccent,
                              ),
                              onPressed: () {
                                showdialogEdit();
                              },
                              child: const Text(
                                "Save",
                                style: TextStyle(color: Colors.black87),
                              )),
                        ],
                      );
                    },
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
