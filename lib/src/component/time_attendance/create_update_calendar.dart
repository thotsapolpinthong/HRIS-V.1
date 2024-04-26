import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/timeattendance_bloc/timeattendance_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/time_attendance/create_holiday_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/get_holiday_data_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/update_holiday_model.dart';
import 'package:hris_app_prototype/src/services/api_time_attendance_service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class CreateUpdateCalendar extends StatefulWidget {
  final bool onEdit;
  final HolidayDatum? subData;
  const CreateUpdateCalendar({super.key, required this.onEdit, this.subData});

  @override
  State<CreateUpdateCalendar> createState() => _CreateUpdateCalendarState();
}

enum SingingCharacter { holiday, dayoff }

class _CreateUpdateCalendarState extends State<CreateUpdateCalendar> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameTH = TextEditingController();
  TextEditingController nameEN = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController dateFrom = TextEditingController();
  TextEditingController validFrom = TextEditingController();
  TextEditingController expFrom = TextEditingController();
  TextEditingController comment = TextEditingController();
  bool disableExp = false;
  SingingCharacter? _character = SingingCharacter.holiday;
  List<DateTime?> dates = [];
  List<String>? dateFromList;

  Future<void> selectDateFromDate() async {
    var picker = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
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
        dateFromList = picker.map((data) {
          if (data != null) {
            // ใช้ DateFormat จาก package:intl เพื่อแปลง DateTime เป็น String
            return DateFormat('yyyy-MM-dd').format(data);
          } else {
            return ''; // หรือค่าอื่น ๆ ที่คุณต้องการในกรณีที่ DateTime เป็น null
          }
        }).toList();
        dateFrom.text = dateFromList.toString();
        if (picker.isEmpty) {
          dateFrom.text = '';
          validFrom.text = '';
        } else {
          validFrom.text = picker[0].toString().split(" ")[0];
          String year = DateFormat('yyyy-12-31').format(picker[0]!);
          disableExp = true;
          expFrom.text = year;
        }
      });
    }
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
      CreateHolidayModel createModel = CreateHolidayModel(
          crop: validFrom.text.substring(0, 4),
          date: dateFromList!,
          holidayNameTh: nameTH.text,
          holidayNameEn: nameEN.text,
          validFrom: validFrom.text,
          endDate: expFrom.text,
          holidayFlag: _character == SingingCharacter.holiday ? true : false,
          note: note.text);
      setState(() {});
      bool success = await ApiTimeAtendanceService.createHoliday(createModel);

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
      UpdateHolidayModel updateModel = UpdateHolidayModel(
          holidayId: widget.subData!.holidayId,
          crop: validFrom.text.substring(0, 4),
          //date: dateFromList == null ? dateFrom.text : dateFromList.toString(),
          holidayNameTh: nameTH.text,
          holidayNameEn: nameEN.text,
          validFrom: validFrom.text,
          endDate: expFrom.text,
          holidayFlag: _character == SingingCharacter.holiday ? true : false,
          note: note.text,
          modifiedBy: employeeId,
          comment: comment.text);

      setState(() {});
      bool success = await ApiTimeAtendanceService.updatedHoliday(updateModel);

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
                        ? 'Created Holiday Success.'
                        : 'Edit Holiday Success.'
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
          context
              .read<TimeattendanceBloc>()
              .add(FetchDataTimeAttendanceEvent());
          if (success == true) {
            Navigator.pop(context);
          }
        });
      },
    ).show();
  }

  @override
  void initState() {
    if (widget.onEdit == true && widget.subData != null) {
      nameTH.text = widget.subData!.holidayNameTh;
      nameEN.text = widget.subData!.holidayNameEn;
      note.text = widget.subData!.note == 'No data' ? '' : widget.subData!.note;
      dateFrom.text = widget.subData!.date;
      validFrom.text = widget.subData!.validFrom;
      expFrom.text = widget.subData!.endDate;
      disableExp = true;
      _character = widget.subData!.holidayFlag == true
          ? SingingCharacter.holiday
          : SingingCharacter.dayoff;
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
                      TextFormFieldDatepickGlobal(
                        controller: dateFrom,
                        labelText: "Holiday Date",
                        validatorless:
                            Validatorless.required("กรุณากรอกข้อมูล"),
                        ontap: widget.onEdit == true
                            ? null
                            : () {
                                selectDateFromDate();
                              },
                      ),
                      const Gap(4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Card(
                              child: TextFormField(
                                controller: validFrom,
                                autovalidateMode: AutovalidateMode.always,
                                validator:
                                    Validatorless.required('*กรุณากรอกข้อมูล'),
                                decoration: const InputDecoration(
                                  labelText: 'มีผลตั้งแต่',
                                  labelStyle: TextStyle(color: Colors.black),
                                  filled: true,
                                  fillColor: Colors.white,
                                  suffixIcon: Icon(
                                    Icons.calendar_today,
                                  ),
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black54),
                                  ),
                                ),
                                readOnly: true,
                                onTap: () {
                                  selectvalidFromDate();
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              child: TextFormField(
                                controller: expFrom,
                                autovalidateMode: AutovalidateMode.always,
                                validator:
                                    Validatorless.required('*กรุณากรอกข้อมูล'),
                                decoration: InputDecoration(
                                  labelText: 'สิ้นสุดเมื่อ',
                                  labelStyle: TextStyle(
                                      color: disableExp == true
                                          ? Colors.black
                                          : Colors.grey),
                                  filled: true,
                                  fillColor: Colors.white,
                                  suffixIcon: const Icon(
                                    Icons.calendar_today,
                                  ),
                                  disabledBorder: InputBorder.none,
                                  border: const OutlineInputBorder(),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black54),
                                  ),
                                ),
                                readOnly: true,
                                enabled: disableExp,
                                onTap: () {
                                  selectexpDate();
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      const Gap(4),
                      TextFormFieldGlobal(
                          controller: nameTH,
                          labelText: "Holiday Name(TH)",
                          hintText: "เพิ่มวันหยุด",
                          enabled: true,
                          validatorless:
                              Validatorless.required("กรุณากรอกข้อมูล")),
                      const Gap(4),
                      TextFormFieldGlobal(
                          controller: nameEN,
                          labelText: "Holiday Name(EN)",
                          hintText: "เพิ่มวันหยุด",
                          enabled: true,
                          validatorless:
                              Validatorless.required("กรุณากรอกข้อมูล")),
                      const Gap(4),
                      TextFormFieldGlobal(
                          controller: note,
                          labelText: "Remark",
                          hintText: "คำอธิบายเพิ่มเติม",
                          enabled: true,
                          validatorless: null),
                      const Gap(4),
                      RadioListTile<SingingCharacter>(
                        title: const Text('วันหยุดตามประกาศบริษัท '),
                        activeColor: mythemecolor,
                        value: SingingCharacter.holiday,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                      const Gap(4),
                      RadioListTile<SingingCharacter>(
                        title: const Text(
                            'วันหยุดพิเศษ \n(จะไม่ถูกคิดเป็นวันทำงานของพนักงานรายวัน , รายวันประจำ)'),
                        activeColor: mythemecolor,
                        value: SingingCharacter.dayoff,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
          // if (widget.onEdit == false)
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
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
                    ))),
          ),
        ],
      ),
    );
  }
}
