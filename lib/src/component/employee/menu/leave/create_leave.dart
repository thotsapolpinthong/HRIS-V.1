import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_address.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

class CreateLeave extends StatefulWidget {
  const CreateLeave({super.key});

  @override
  State<CreateLeave> createState() => _CreateLeaveState();
}

class _CreateLeaveState extends State<CreateLeave> {
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
        setState(() {});
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: DropdownOrg(
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
                        onChanged: (newValue) {},
                        validator: Validatorless.required("กรุณากรอกข้อมูล")),
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
              const Gap(5),
              TextFormFieldGlobal(
                  controller: dateCount,
                  labelText: "จำนวนวัน",
                  hintText: '',
                  enabled: leaveDateList.length > 1 ? false : true,
                  validatorless: Validatorless.number('กรอกเฉพาะตัวเลข')),
              const Gap(5),
              TextFormFieldGlobal(
                  controller: noted,
                  labelText: "Noted",
                  hintText: '',
                  enabled: true,
                  validatorless: null),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                  ),
                  onPressed: () {
                    alertDialog(true);
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.black87),
                  ))),
        ),
      ],
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
