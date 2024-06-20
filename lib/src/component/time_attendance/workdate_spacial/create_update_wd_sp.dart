// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/timeattendance_bloc/timeattendance_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/time_attendance/shift/dropdown_shift_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/workdate_spacial/create_wd_sp.dart';
import 'package:hris_app_prototype/src/model/time_attendance/workdate_spacial/update_wd_sp.dart';
import 'package:hris_app_prototype/src/model/time_attendance/workdate_spacial/wd_sp_model.dart';
import 'package:hris_app_prototype/src/services/api_time_attendance_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class EditWorkdateSp extends StatefulWidget {
  final bool onEdit;
  final WorkDateSpecialDatum? data;
  final String startDate;
  final String endDate;
  const EditWorkdateSp({
    Key? key,
    required this.onEdit,
    this.data,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);

  @override
  State<EditWorkdateSp> createState() => _EditWorkdateSpState();
}

class _EditWorkdateSpState extends State<EditWorkdateSp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController comment = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  TimeOfDay? selectedStartTime;
  bool? dataStatus;
//Shift Dropdown Data
  List<ShiftDatum>? shiftList;
  String? shiftDataId;
  String? shiftTime;
  String? shiftName;

  fetchData() async {
    shiftList = await ApiTimeAtendanceService.getShiftDropdown();
    setState(() {
      shiftList;
    });
  }

  Future<void> selectDate() async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(9999),
    );
    if (picker != null) {
      setState(() {
        date.text = picker.toString().split(" ")[0];
      });
    }
  }

  Future<void> selectTime() async {
    TimeOfDay? selectedTime24Hour = await showTimePicker(
      hourLabelText: " นาฬิกา         hour",
      minuteLabelText: " นาที         minute",
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

        time.text = selectedStartTime!.format(context).toString();
      });
    }
  }

  Future onCreate() async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    CreateWorkdateSpModel createModel = CreateWorkdateSpModel(
      date: date.text,
      shiftId: int.parse(shiftDataId!),
      endTime: "${time.text}:00",
      createBy: employeeId,
    );
    createModel;
    bool success = await ApiTimeAtendanceService.createWorkSp(createModel);
    alertDialog(success);
  }

  Future onUpdate() async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    UpdateWorkdateSpModel updateModel = UpdateWorkdateSpModel(
        id: widget.data!.id,
        date: date.text,
        shiftId: int.parse(shiftDataId!),
        endTime: "${time.text}:00",
        status: dataStatus!,
        modifyBy: employeeId,
        comment: comment.text);
    bool success = await ApiTimeAtendanceService.updateWorkSp(updateModel);
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
                        ? 'Created Workdate Spacial Success.'
                        : 'Edit Workdate Spacial Success.'
                    : widget.onEdit == false
                        ? 'Created Workdate Spacial Fail.'
                        : 'Edit Workdate Spacial Fail.',
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
        if (success) {
          setState(() {
            context.read<TimeattendanceBloc>().add(FetchWorkdateSpacialEvent(
                startDate: widget.startDate, endDate: widget.endDate));
            Navigator.pop(context);
          });
        }
      },
    ).show();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    if (widget.onEdit) {
      shiftDataId = widget.data!.shiftId.toString();
      date.text = widget.data!.date.toIso8601String().split('T')[0];
      time.text = widget.data!.endTime;
      dataStatus = widget.data!.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormFieldDatepickGlobal(
                      controller: date,
                      labelText: "Date",
                      validatorless: null,
                      ontap: () {
                        selectDate();
                      }),
                  const Gap(5),
                  DropdownGlobal(
                    labeltext: 'Shift',
                    value: shiftDataId,
                    validator: null,
                    items: shiftList?.map((e) {
                      return DropdownMenuItem<String>(
                        value: e.shiftId.toString(),
                        child: Container(
                            constraints: const BoxConstraints(maxWidth: 300),
                            child: Text(
                                "${e.shiftName} : ${e.startTime} - ${e.endTime}")),
                        onTap: () {
                          shiftTime = "${e.startTime} - ${e.endTime}";
                          shiftName = e.shiftName.toString();
                        },
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        shiftDataId = newValue.toString();
                      });
                    },
                  ),
                  const Gap(5),
                  TextFormFieldTimepickGlobal(
                      controller: time,
                      labelText: "Time off Work",
                      validatorless: null,
                      ontap: () {
                        selectTime();
                      },
                      enabled: true),
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.onEdit
                ? Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: dataStatus == true ? 2 : 0,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(8))),
                                backgroundColor: dataStatus == true
                                    ? Colors.greenAccent
                                    : Colors.grey[300],
                              ),
                              onPressed: () {
                                setState(() {
                                  dataStatus = true;
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
                                elevation: dataStatus == false ? 2 : 0,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(8))),
                                backgroundColor: dataStatus == false
                                    ? Colors.redAccent
                                    : Colors.grey[300],
                              ),
                              onPressed: () {
                                setState(() {
                                  dataStatus = false;
                                });
                              },
                              child: const Text(
                                "InActive",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  )
                : Container(),
            widget.onEdit
                ? MySaveButtons(
                    text: "Update",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          onUpdate();
                        });
                      } else {}
                    },
                  )
                : MySaveButtons(
                    text: "Create",
                    onPressed: () {
                      setState(() {
                        onCreate();
                      });
                    },
                  )
          ],
        )
      ],
    );
  }
}
