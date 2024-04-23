// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/employee_bloc/employee_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model/create_leave_by_hr_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model/leave_employee_approve_model.dart';

import 'package:hris_app_prototype/src/services/api_employee_service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class CreateLeave extends StatefulWidget {
  final EmployeeDatum employeeData;
  final double vacationLeave;
  final double bussinessLeave;
  final double sickLeave;
  const CreateLeave({
    Key? key,
    required this.employeeData,
    required this.vacationLeave,
    required this.bussinessLeave,
    required this.sickLeave,
  }) : super(key: key);

  @override
  State<CreateLeave> createState() => _CreateLeaveState();
}

class _CreateLeaveState extends State<CreateLeave> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Create leave date
  TextEditingController leaveDate = TextEditingController();
  double dateCount = 0;
  TextEditingController noted = TextEditingController();
  String? selectLeaveType;
  List<DateTime?> dates = [];
  List<String> leaveDateList = [];

  List<DropdownLeaveType> leaveTypeList = [
    DropdownLeaveType(leaveTypeId: "L001", leaveTypeNameTh: "ลาพักร้อน"),
    DropdownLeaveType(leaveTypeId: "L002", leaveTypeNameTh: "ลากิจ"),
    DropdownLeaveType(leaveTypeId: "L003", leaveTypeNameTh: "ลาป่วย"),
    DropdownLeaveType(leaveTypeId: "L004", leaveTypeNameTh: "ลาคลอด"),
  ];

  TimeOfDay? selectedStartTime;
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();

  List<EmployeeApproveModel> approveList = [];
  String? approveId;

  Future<void> selectDateFromDate() async {
    var picker = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        firstDate: DateTime(DateTime.now().year, 01, 1),
        lastDate: DateTime(DateTime.now().year, 12, 31),
        firstDayOfWeek: 1,
        calendarType: CalendarDatePicker2Type.multi,
        dayTextStyle: const TextStyle(
          color: Colors.black,
        ),
        disabledDayTextStyle:
            const TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
        weekdayLabelTextStyle:
            TextStyle(color: mythemecolor, fontWeight: FontWeight.bold),
        dayTextStylePredicate: ({required date}) {
          TextStyle? textStyle;
          if (date.weekday == DateTime.sunday) {
            textStyle =
                TextStyle(color: Colors.red[500], fontWeight: FontWeight.w600);
          }
          return textStyle;
        },
        selectableDayPredicate: (day) =>
            day.weekday == DateTime.sunday ? false : true,
      ),
      dialogSize: const Size(500, 400),
      value: dates,
      borderRadius: BorderRadius.circular(15),
    );

    if (picker != null) {
      setState(() {
        leaveDateList = picker.map((data) {
          if (data != null) {
            // ใช้ DateFormat จาก package:intl เพื่อแปลง DateTime เป็น String
            return DateFormat('yyyy-MM-dd').format(data);
          } else {
            return ''; // หรือค่าอื่น ๆ ที่คุณต้องการในกรณีที่ DateTime เป็น null
          }
        }).toList();
        dateCount = picker.length.toDouble();
        leaveDate.text = leaveDateList.toString();
        if (picker.isEmpty) {
          leaveDate.text = '';
          dateCount = 0;
        } else {
          // var validFrom;
          // validFrom.text = picker[0].toString().split(" ")[0];
          // String year = DateFormat('yyyy-12-31').format(picker[0]!);
          // disableExp = true;
          // expFrom.text = year;
        }

        // expFrom.text = "";
      });
    }
  }

  alertDialogInfo(double dateCount, double sumCount) {
    AwesomeDialog(
            width: 400,
            context: context,
            animType: AnimType.topSlide,
            dialogType: DialogType.info,
            title: "แจ้งเตือน",
            desc:
                'ต้องการใช้สิทธิ์วันลาทั้งหมด $dateCount วัน \nเป็นวันลาเกิน(หักเงิน) $sumCount วัน',
            btnOkColor: sumCount >= 0 ? Colors.greenAccent : Colors.red[700],
            btnOkOnPress: () {
              createLeave();
            },
            btnCancelColor: mythemecolor,
            btnCancelOnPress: () {})
        .show();
  }

  createLeave() async {
    String? employeeId;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId");
    LeaveRequestHrModel createLeaveModel = LeaveRequestHrModel(
        employeeId: widget.employeeData.employeeId,
        leaveTypeId: selectLeaveType!,
        leaveDate: leaveDateList,
        startTime:
            startTime.text == "" ? startTime.text : "${startTime.text}:00",
        endTime: endTime.text == "" ? endTime.text : "${endTime.text}:00",
        leaveDescription: noted.text,
        approveBy: approveId!,
        createBy: employeeId!);
    bool success =
        await ApiEmployeeService.createLeaveRquestByHr(createLeaveModel);
    alertDialog(success);
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
                success == true ? 'Created Success.' : 'Created Fail.',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              Text(
                success == true
                    ? 'เพิ่มข้อมูล สำเร็จ'
                    : 'เพิ่มข้อมูล ไม่สำเร็จ',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
      btnOkColor: success == true ? Colors.greenAccent : Colors.red,
      btnOkOnPress: () {
        context.read<EmployeeBloc>().add(FetchDataLeaveEmployeeEvent(
            employeeId: widget.employeeData.employeeId));
      },
    ).show();
  }

  Future<void> selectTime(bool from) async {
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
        if (from == true) {
          startTime.text = selectedStartTime!.format(context).toString();
        } else {
          endTime.text = selectedStartTime!.format(context).toString();
        }
      });
    }
  }

  fetchApproveDropdown() async {
    approveList = [
      await ApiEmployeeService.getEmployeeApprove(widget.employeeData
          .positionData.parentPositionBusinessNodeId.positionOrganizationId)
    ];
    setState(() {
      approveList;
    });
  }

  @override
  void initState() {
    fetchApproveDropdown();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
                            labeltext: 'ประเภทการลา',
                            value: selectLeaveType,
                            items: leaveTypeList.map((e) {
                              return DropdownMenuItem<String>(
                                value: e.leaveTypeId.toString(),
                                child: Container(
                                    constraints:
                                        const BoxConstraints(maxWidth: 260),
                                    child: Text(e.leaveTypeNameTh)),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectLeaveType = newValue.toString();
                              });
                            },
                            validator:
                                Validatorless.required("กรุณากรอกข้อมูล")),
                      ),
                      Expanded(
                          child: TextFormFieldDatepickGlobal(
                        controller: leaveDate,
                        labelText: "วันที่ต้องการลา ",
                        validatorless: null,
                        ontap: () {
                          selectDateFromDate();
                        },
                      ))
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormFieldTimepickGlobal(
                          controller: startTime,
                          labelText: "ระยะเวลาเริ่มลา (Start Time).",
                          validatorless: null,
                          ontap: () {
                            selectTime(true);
                          },
                          enabled: leaveDateList.length > 1 ? false : true,
                        ),
                      ),
                      Expanded(
                        child: TextFormFieldTimepickGlobal(
                          controller: endTime,
                          labelText: "ระยะเวลาสิ้นสุด (End Time).",
                          validatorless: null,
                          ontap: () {
                            selectTime(false);
                          },
                          enabled: leaveDateList.length > 1 ? false : true,
                        ),
                      ),
                    ],
                  ),
                  const Gap(5),
                  TextFormFieldGlobal(
                      controller: noted,
                      labelText: "Noted",
                      hintText: '',
                      enabled: true,
                      validatorless: Validatorless.required("โปรดระบุ")),
                  const Gap(5),
                  DropdownGlobal(
                      labeltext: 'Approve By',
                      value: approveId,
                      items: approveList.map((e) {
                        return DropdownMenuItem<String>(
                          value: e.employeeId.toString(),
                          child: Container(
                              constraints: const BoxConstraints(maxWidth: 260),
                              child: Text(
                                  "${e.employeeId} ${e.firstName} ${e.lastName}")),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          approveId = newValue.toString();
                        });
                      },
                      validator: Validatorless.required("กรุณากรอกข้อมูล")),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: selectLeaveType != "L003" ? null : () {},
                        child: const SizedBox(
                          width: 76,
                          child: Row(
                            children: [
                              Icon(
                                Icons.upload_file_rounded,
                                size: 20,
                              ),
                              Gap(5),
                              Text("Upload"),
                            ],
                          ),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                        ),
                        onPressed: selectLeaveType != null &&
                                leaveDate.text != ""
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  if (selectLeaveType == "L001") {
                                    double tempLeave = widget.vacationLeave;
                                    tempLeave -= dateCount;
                                    tempLeave;
                                    alertDialogInfo(dateCount,
                                        tempLeave < 0 ? tempLeave : 0);
                                  } else if (selectLeaveType == "L002") {
                                    double tempLeave = widget.bussinessLeave;
                                    tempLeave -= dateCount;
                                    tempLeave;
                                    alertDialogInfo(dateCount,
                                        tempLeave < 0 ? tempLeave : 0);
                                  } else if (selectLeaveType == "L003") {
                                    double tempLeave = widget.sickLeave;
                                    tempLeave -= dateCount;
                                    tempLeave;
                                    alertDialogInfo(dateCount,
                                        tempLeave < 0 ? tempLeave : 0);
                                  } else if (selectLeaveType == "L004") {
                                  } else {}
                                } else {}

                                //  alertDialogInfo();
                              }
                            : null,
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.black87),
                        )),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

// leave type
class DropdownLeaveType {
  String leaveTypeId;
  String leaveTypeNameTh;
  DropdownLeaveType({
    required this.leaveTypeId,
    required this.leaveTypeNameTh,
  });
}
