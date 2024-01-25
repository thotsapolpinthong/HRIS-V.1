import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee/menu/leave/create_leave.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_address.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

class LeaveManage extends StatefulWidget {
  const LeaveManage({super.key});

  @override
  State<LeaveManage> createState() => _LeaveManageState();
}

class _LeaveManageState extends State<LeaveManage> {
  // Create leave date
  TextEditingController leaveDate = TextEditingController();
  TextEditingController dateCount = TextEditingController();
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
        dateCount.text = picker.length.toString();
        leaveDate.text = leaveDateList.toString();
        if (picker.isEmpty) {
          leaveDate.text = '';
          dateCount.text = '';
        } else {
          alertDialogInfo();
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

  alertDialogInfo() {
    AwesomeDialog(
      width: 400,
      context: context,
      animType: AnimType.topSlide,
      dialogType: DialogType.info,
      title: "INFO",
      desc:
          'ใช้สิทธิ์วันลาไป ${leaveDateList.length} วัน \nเป็นวันลาเกิน(หักเงิน) 0 วัน',
      btnOkColor: mythemecolor,
      btnOkOnPress: () {},
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("บันทึกข้อมูลการลา"),
      ),
      body: Hero(
          tag: "leave",
          child: Row(
            children: [
              Expanded(
                flex: 3,
                // left child
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.white,
                          child: const ListTile(
                            leading: Icon(Icons.airplane_ticket_outlined),
                            title: Text("ลาพักผ่อนประจำปี"),
                            subtitle: Text("คงเหลือ 14 วัน"),
                            trailing: Icon(
                              Icons.check_box_rounded,
                              color: Colors.greenAccent,
                            ),
                          ),
                        )),
                        Expanded(
                            child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.white,
                          child: const ListTile(
                            leading: Icon(Icons.card_travel_rounded),
                            title: Text("ลากิจ"),
                            subtitle: Text("คงเหลือ 0 วัน"),
                            trailing: Icon(
                              Icons.indeterminate_check_box_rounded,
                              color: Colors.amber,
                            ),
                          ),
                        )),
                        Expanded(
                            child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.white,
                          child: const ListTile(
                            leading: Icon(Icons.sick_outlined),
                            title: Text("ลาป่วย"),
                            subtitle: Text("ลาไปแล้ว 4 วัน"),
                            trailing: Icon(
                              Icons.check_box_rounded,
                              color: Colors.greenAccent,
                            ),
                          ),
                        )),
                      ],
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            width: double.infinity,
                            color: Colors.amber,
                            child: Text(""),
                          ),
                          Container(
                            height: 100,
                            width: double.infinity,
                            color: Colors.amberAccent,
                            child: Text(""),
                          ),
                          Container(
                            height: 100,
                            width: double.infinity,
                            color: Colors.blue,
                            child: Text(""),
                          ),
                          Container(
                            height: 100,
                            width: double.infinity,
                            color: Colors.blueAccent[100],
                            child: Text(""),
                          ),
                          Container(
                            height: 100,
                            width: double.infinity,
                            color: Colors.blueGrey,
                            child: Text(""),
                          ),
                          Container(
                            height: 100,
                            width: double.infinity,
                            color: Colors.amber,
                            child: Text(""),
                          ),
                          Container(
                            height: 100,
                            width: double.infinity,
                            color: Colors.amberAccent,
                            child: Text(""),
                          ),
                          Container(
                            height: 100,
                            width: double.infinity,
                            color: Colors.blue,
                            child: Text(""),
                          ),
                          Container(
                            height: 100,
                            width: double.infinity,
                            color: Colors.blueAccent[100],
                            child: Text(""),
                          ),
                          Container(
                            height: 100,
                            width: double.infinity,
                            color: Colors.blueGrey,
                            child: Text(""),
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
              VerticalDivider(
                color: mythemecolor,
                indent: 40,
                endIndent: 40,
                thickness: 4,
              ),
              Expanded(
                flex: 2,
                // right child
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      const Gap(20),
                      const Text(
                        "ใบลา",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Text("Request for leave."),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Gap(20),
                              const Text(" เลือกประเภทการลา",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const Gap(5),
                              DropdownOrg(
                                  labeltext: '',
                                  value: selectLeaveType,
                                  items: leaveTypeList.map((e) {
                                    return DropdownMenuItem<String>(
                                      value: e.leaveTypeId.toString(),
                                      child: Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 260),
                                          child: Text(e.leaveTypeNameTh)),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {},
                                  validator: null),
                              const Gap(10),
                              const Text(" ระบุวันที่ (สามารถเลือกหลายวันได้)",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const Gap(5),
                              TextFormFieldDatepickGlobal(
                                controller: leaveDate,
                                labelText: "",
                                validatorless: null,
                                ontap: () {
                                  selectDateFromDate();
                                },
                              ),
                              const Gap(10),
                              const Text(" ระบุเวลา",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const Gap(5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: TextFormFieldTimepickGlobal(
                                      controller: startTime,
                                      labelText:
                                          "ระยะเวลาเริ่มลา (Start Time).",
                                      validatorless: null,
                                      ontap: () {
                                        selectTime(true);
                                      },
                                      enabled: leaveDateList.length > 1
                                          ? false
                                          : true,
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
                                      enabled: leaveDateList.length > 1
                                          ? false
                                          : true,
                                    ),
                                  ),
                                ],
                              ),
                              // const Gap(5),
                              // TextFormFieldGlobal(
                              //     controller: dateCount,
                              //     labelText: "จำนวนวัน",
                              //     hintText: '',
                              //     enabled:
                              //         leaveDateList.length > 1 ? false : true,
                              //     validatorless: Validatorless.number(
                              //         'กรอกเฉพาะตัวเลข')),
                              const Gap(10),
                              const Text(" ลาเพื่อ (Reasons for leaving.)",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              TextFormFieldGlobal(
                                  controller: noted,
                                  labelText: "",
                                  hintText: 'บันทึกข้อความ',
                                  enabled: true,
                                  validatorless: null),
                            ],
                          ),
                        ),
                      )),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ElevatedButton(
                              onPressed: () {}, // Navigator.pop(context),
                              child: const Text("Submit")),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // ElevatedButton(
              //     onPressed: () => Navigator.pop(context),
              //     child: const Text("pop"))
            ],
          )),
    );
  }
}
