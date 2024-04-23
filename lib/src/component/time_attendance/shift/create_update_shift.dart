import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/timeattendance_bloc/timeattendance_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/time_attendance/shift/create_shift_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/shift/get_shift_all_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/shift/update_shift_model.dart';
import 'package:hris_app_prototype/src/services/api_time_attendance_service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class CreateUpdateShift extends StatefulWidget {
  final bool onEdit;
  final ShiftDatum? subData;
  const CreateUpdateShift({super.key, required this.onEdit, this.subData});

  @override
  State<CreateUpdateShift> createState() => _CreateUpdateShiftState();
}

class _CreateUpdateShiftState extends State<CreateUpdateShift> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController shiftName = TextEditingController();
  //TextEditingController startTime = TextEditingController();
  TextEditingController startTimepicker = TextEditingController();
  TextEditingController endTime = TextEditingController();
  TextEditingController validFrom = TextEditingController();
  TextEditingController expFrom = TextEditingController();
  TextEditingController comment = TextEditingController();
  bool disableTime = false;
  bool disableExp = false;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  bool status = true;

  Future<void> selectTime() async {
    TimeOfDay? selectedTime24Hour = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (selectedTime24Hour != null) {
      setState(() {
        selectedStartTime = selectedTime24Hour;
        startTimepicker.text = selectedStartTime!.format(context).toString();
        disableTime = true;
      });
    }
  }

  Future<void> selectEndTime() async {
    TimeOfDay? selectedTime24Hour = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (selectedTime24Hour != null) {
      if (selectedTime24Hour == selectedStartTime) {
        alertDialogSameTime();
      } else {
        setState(() {
          selectedEndTime = selectedTime24Hour;
          endTime.text = selectedEndTime!.format(context).toString();
        });
        //หาระยะเวลา
        Duration difference = Duration(
            hours: selectedEndTime!.hour - selectedStartTime!.hour,
            minutes: selectedEndTime!.minute - selectedStartTime!.minute);
        alertDialogCalculateTime(difference.inHours, difference.inMinutes % 60);
      }
    }
  }

  alertDialogSameTime() {
    AwesomeDialog(
      context: context,
      width: 400,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      title: 'เกิดข้อผิดพลาด',
      desc: 'ไม่สามารถใส่เวลาซ้ำกับเวลาเริ่มงานได้',
      btnOkOnPress: () {},
      buttonsBorderRadius: BorderRadius.circular(8),
      btnOkColor: Colors.amber[600],
      dialogBackgroundColor: mygreycolors,
    ).show();
  }

  alertDialogCalculateTime(int hour, int minute) {
    AwesomeDialog(
      context: context,
      width: 400,
      dialogType: DialogType.info,
      animType: AnimType.scale,
      title: 'รวมระยะเวลาทำงาน (ยังไม่หักเวลาพัก)',
      desc: '$hour ชั่วโมง $minute นาที',
      btnOkOnPress: () {},
      buttonsBorderRadius: BorderRadius.circular(8),
      btnOkColor: mythemecolor,
      dialogBackgroundColor: mygreycolors,
    ).show();
  }

  Future<void> selectvalidFromDate() async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(9999),
    );
    if (picker != null) {
      setState(() {
        validFrom.text = picker.toString().split(" ")[0];
        disableExp = true;
        expFrom.text = "";
      });
    }
  }

  Future<void> selectexpDate() async {
    DateFormat format = DateFormat('yyyy-MM-dd');
    DateTime dateTime = format.parse(validFrom.text);
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime(9999, 12, 31),
      firstDate: dateTime,
      lastDate: DateTime(9999, 12, 31),
    );
    if (picker != null) {
      setState(() {
        expFrom.text = picker.toString().split(" ")[0];
      });
    }
  }

  Future onAdd() async {
    if (_formKey.currentState!.validate()) {
      CreateShiftModel createModel = CreateShiftModel(
          shiftName: shiftName.text,
          startTime: "${startTimepicker.text}:00",
          endTime: "${endTime.text}:00",
          validFrom: validFrom.text,
          endDate: expFrom.text,
          shiftStatus: "Active");

      setState(() {});
      bool success = await ApiTimeAtendanceService.createShift(createModel);

      alertDialog(success);
    } else {}
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
              onSave();
              Navigator.pop(context);
            },
          );
        });
  }

  Future onSave() async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    if (_formKey.currentState!.validate()) {
      UpdateShiftModel updateModel = UpdateShiftModel(
          shiftId: widget.subData!.shiftId,
          shiftName: shiftName.text,
          startTime: startTimepicker.text.length == 8
              ? startTimepicker.text
              : "${startTimepicker.text}:00",
          endTime:
              endTime.text.length == 8 ? endTime.text : "${endTime.text}:00",
          validFrom: validFrom.text,
          endDate: expFrom.text,
          shiftStatus: status == true ? 'Active' : 'Inactive',
          modifiedBy: employeeId,
          comment: comment.text);

      setState(() {});
      bool success = await ApiTimeAtendanceService.updatedShit(updateModel);

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
                        ? 'Created Shift Success.'
                        : 'Edit Shift Success.'
                    : widget.onEdit == false
                        ? 'Created Holiday Fail.'
                        : 'Edit Holiday Fail.',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              Text(
                success == true
                    ? widget.onEdit == false
                        ? 'เพิ่มข้อมูล สำเร็จ'
                        : 'แก้ไขข้อมูล สำเร็จ'
                    : widget.onEdit == false
                        ? 'เพิ่มข้อมูล ไม่สำเร็จ'
                        : 'แก้ไขข้อมูล ไม่สำเร็จ',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
      btnOkColor: success == true ? Colors.greenAccent : Colors.red,
      btnOkOnPress: () {
        setState(() {
          context.read<TimeattendanceBloc>().add(FetchDataShiftEvent());
        });
      },
    ).show();
  }

  @override
  void initState() {
    if (widget.onEdit == true && widget.subData != null) {
      shiftName.text = widget.subData!.shiftName;
      startTimepicker.text = widget.subData!.startTime;
      endTime.text = widget.subData!.endTime;
      validFrom.text = widget.subData!.validFrom;
      expFrom.text = widget.subData!.endDate;
      status = widget.subData?.shiftStatus == 'Active' ? true : false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Expanded(
              child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    children: [
                      const Gap(4),
                      TextFormFieldGlobal(
                          controller: shiftName,
                          labelText: "ชื่อกะการทำงาน (Name Shift).",
                          hintText: "ระบุชื่อ",
                          enabled: true,
                          validatorless:
                              Validatorless.required("กรุณากรอกข้อมูล")),
                      const Gap(6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextFormFieldTimepickGlobal(
                              controller: startTimepicker,
                              labelText: "ระยะเวลาเริ่มงาน (Start Time).",
                              validatorless:
                                  Validatorless.required("กรุณากรอกข้อมูล"),
                              ontap: () {
                                selectTime();
                              },
                              enabled: true,
                            ),
                          ),
                          Expanded(
                            child: TextFormFieldTimepickGlobal(
                              controller: endTime,
                              labelText: "ระยะเวลาสิ้นสุดงาน (End Time).",
                              validatorless:
                                  Validatorless.required("กรุณากรอกข้อมูล"),
                              ontap: () {
                                selectEndTime();
                              },
                              enabled: disableTime,
                            ),
                          ),
                        ],
                      ),
                      const Gap(6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextFormFieldDatepickGlobal(
                              controller: validFrom,
                              labelText: "มีผลตั้งแต่ (Valid Form).",
                              validatorless:
                                  Validatorless.required("กรุณากรอกข้อมูล"),
                              ontap: () {
                                selectvalidFromDate();
                              },
                            ),
                          ),
                          Expanded(
                            child: TextFormFieldDatepickGlobalDisable(
                              controller: expFrom,
                              labelText: "สิ้นสุดเมื่อ (End Date).",
                              validatorless:
                                  Validatorless.required("กรุณากรอกข้อมูล"),
                              ontap: () {
                                selectexpDate();
                              },
                              enabled: disableExp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: widget.onEdit == true
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.end,
                  children: [
                    if (widget.onEdit == true)
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: status == true ? 2 : 0,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.horizontal(
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
                                      borderRadius: BorderRadius.horizontal(
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
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                        ),
                        onPressed: () {
                          if (widget.onEdit == false) {
                            onAdd();
                          } else {
                            showdialogEdit();
                          }
                        },
                        child: Text(
                          widget.onEdit == false ? "Add" : "Save",
                          style: const TextStyle(color: Colors.black87),
                        )),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
