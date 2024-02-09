// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee/menu/leave/create_leave.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_address.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_by_id_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model.dart/leave_amount_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model.dart/leave_data_employee_model.dart';
import 'package:hris_app_prototype/src/model/self_service/leave/create_leave_request_online.dart';
import 'package:hris_app_prototype/src/services/api_employee_self_service.dart';

import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

class LeaveManage extends StatefulWidget {
  final EmployeeIdModel? employeeData;
  final double vacationLeave;
  final double bussinessLeave;
  final double sickLeave;
  const LeaveManage({
    Key? key,
    required this.employeeData,
    required this.vacationLeave,
    required this.bussinessLeave,
    required this.sickLeave,
  }) : super(key: key);

  @override
  State<LeaveManage> createState() => _LeaveManageState();
}

class _LeaveManageState extends State<LeaveManage> {
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

  List test = ["test1", "test2", "test3", "test4"];

  double vacationLeave = 0;
  double bussinessLeave = 0;
  double sickLeave = 0;

  double vacationLeaveRequest = 0;
  double bussinessLeaveRequest = 0;
  double sickLeaveRequest = 0;
  LeaveRequestByEmployeeModel? leaveDataEmployee;
  LeaveRequestAmountModel? leaveAmount;

  bool requestLoading = true;

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
          // alertDialogInfo();
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

  createLeave() async {
    LeaveQuotaOnlineByEmployeeModel createLeaveModel =
        LeaveQuotaOnlineByEmployeeModel(
            employeeId: widget.employeeData!.employeeData[0].employeeId,
            leaveTypeId: selectLeaveType!,
            leaveDate: leaveDateList,
            startTime:
                startTime.text == "" ? startTime.text : "${startTime.text}:00",
            endTime: endTime.text == "" ? endTime.text : "${endTime.text}:00",
            leaveDescription: noted.text,
            createBy: widget.employeeData!.employeeData[0].employeeId);
    bool success =
        await ApiEmployeeSelfService.createLeaveRequestOnline(createLeaveModel);
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
        fetchData();
      },
    ).show();
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

  fetchData() async {
    leaveDataEmployee =
        await ApiEmployeeSelfService.getLeaveRequestByEmployeeId(
            widget.employeeData!.employeeData[0].employeeId);
    setState(() {
      leaveDataEmployee;
    });
  }

  fetchAmount() async {
    leaveAmount = await ApiEmployeeSelfService.getLeaveAmountByEmployeeId(
        widget.employeeData!.employeeData[0].employeeId);
    if (leaveAmount != null) {
      for (var element in leaveAmount!.leaveRequestData) {
        switch (element.leaveTypeData.leaveTypeId) {
          case "L001":
            double amount = double.parse(element.leaveAmount);
            vacationLeaveRequest += amount;
            vacationLeave -= amount;
            vacationLeave;
            break;
          case "L002":
            double amount = double.parse(element.leaveAmount);
            bussinessLeaveRequest += amount;
            bussinessLeave -= amount;
            break;
          case "L003":
            double amount = double.parse(element.leaveAmount);
            sickLeaveRequest += amount;
            sickLeave -= amount;
            break;
        }
      }
    }
    setState(() {
      vacationLeaveRequest;
      bussinessLeaveRequest;
      sickLeaveRequest;
      leaveAmount;
      vacationLeave;
      bussinessLeave;
      sickLeave;
      requestLoading = false;
    });
  }

  @override
  void initState() {
    vacationLeave = widget.vacationLeave;
    bussinessLeave = widget.bussinessLeave;
    sickLeave = widget.sickLeave;
    fetchData();
    fetchAmount();
    super.initState();
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
                    const Gap(20),
                    Row(
                      children: [
                        Expanded(
                            child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.white,
                          child: ListTile(
                            minLeadingWidth: 25,
                            leading: const Icon(Icons.airplane_ticket_outlined),
                            title: const Text("ลาพักผ่อนประจำปี"),
                            subtitle: Text(
                                "ใช้ไป $vacationLeaveRequest วัน คงเหลือ $vacationLeave วัน"),
                            trailing: Icon(
                              vacationLeave >= 1
                                  ? Icons.check_box_rounded
                                  : Icons.indeterminate_check_box_rounded,
                              color: vacationLeave >= 1
                                  ? Colors.greenAccent
                                  : Colors.amber,
                            ),
                          ),
                        )),
                        Expanded(
                            child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.white,
                          child: ListTile(
                            minLeadingWidth: 25,
                            leading: const Icon(Icons.card_travel_rounded),
                            title: const Text("ลากิจ"),
                            subtitle: Text(
                                "ใช้ไป $bussinessLeaveRequest วัน คงเหลือ $bussinessLeave วัน"),
                            trailing: Icon(
                              bussinessLeave >= 1
                                  ? Icons.check_box_rounded
                                  : Icons.indeterminate_check_box_rounded,
                              color: bussinessLeave >= 1
                                  ? Colors.greenAccent
                                  : Colors.amber,
                            ),
                          ),
                        )),
                        Expanded(
                            child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.white,
                          child: ListTile(
                            minLeadingWidth: 25,
                            leading: const Icon(Icons.sick_outlined),
                            title: const Text("ลาป่วย"),
                            subtitle: Text(
                                "ใช้ไป $sickLeaveRequest วัน คงเหลือ $sickLeave วัน"),
                            trailing: Icon(
                              sickLeave >= 1
                                  ? Icons.check_box_rounded
                                  : Icons.indeterminate_check_box_rounded,
                              color: sickLeave >= 1
                                  ? Colors.greenAccent
                                  : Colors.amber,
                            ),
                          ),
                        )),
                      ],
                    ),
                    const Gap(20),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Leave Request :",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                        child: requestLoading == true
                            ? myLoadingScreen
                            : ListView.builder(
                                itemCount: leaveDataEmployee == null
                                    ? 1
                                    : leaveDataEmployee
                                        ?.leaveRequestData.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 2,
                                    child: SizedBox(
                                      height: 70,
                                      child: Center(
                                        child: ListTile(
                                          leading: leaveDataEmployee == null
                                              ? null
                                              : Text(
                                                  "${leaveDataEmployee?.leaveRequestData[index].leaveTypeData.leaveTypeNameTh}",
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                          title: leaveDataEmployee == null
                                              ? const Center(
                                                  child: Text(
                                                  "ไม่มีใบคำร้อง",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                              : Row(
                                                  children: [
                                                    Text(
                                                        "จำนวน ${leaveDataEmployee?.leaveRequestData[index].leaveAmount} วัน"),
                                                  ],
                                                ),
                                          subtitle: leaveDataEmployee == null
                                              ? null
                                              : Text(
                                                  "วันที่ ${leaveDataEmployee?.leaveRequestData[index].leaveDate}"),
                                          trailing: leaveDataEmployee == null
                                              ? null
                                              : Container(
                                                  decoration: BoxDecoration(
                                                      color: leaveDataEmployee
                                                                  ?.leaveRequestData[
                                                                      index]
                                                                  .status ==
                                                              "request"
                                                          ? Colors
                                                              .amberAccent[100]
                                                          : leaveDataEmployee
                                                                      ?.leaveRequestData[
                                                                          index]
                                                                      .status ==
                                                                  "approve"
                                                              ? Colors
                                                                  .greenAccent
                                                              : Colors.redAccent[
                                                                  100],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14)),
                                                  width: 100,
                                                  height: 30,
                                                  child: Center(
                                                      child: Text(
                                                          "${leaveDataEmployee?.leaveRequestData[index].status}",
                                                          style: TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .grey[800]))),
                                                ),
                                        ),
                                      ),
                                    ),
                                  );
                                })),
                  ],
                ),
              ),
              // VerticalDivider(
              //   color: mythemecolor,
              //   // indent: 40,
              //   // endIndent: 40,
              //   thickness: 4,
              // ),
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
                          child: Form(
                            key: _formKey,
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
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectLeaveType = newValue.toString();
                                      });
                                    },
                                    validator: null),
                                const Gap(10),
                                const Text(
                                    " ระบุวันที่ (สามารถเลือกหลายวันได้)",
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
                                        labelText:
                                            "ระยะเวลาสิ้นสุด (End Time).",
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
                                    validatorless:
                                        Validatorless.required("โปรดระบุ")),
                                const Gap(10),
                                const Text(
                                  "หมายเหตุ*\n- โปรดกรอกข้อมูลให้ครบถ้วน\n- หากต้องการลาหลายวันควรเป็นวันที่ติดกัน(ระยะเวลาการลา จะคิดเป็นเต็มวัน)\n- หากต้องการลาไม่เกินหนึ่งวันหรือลาหนึ่งวัน ต้องระบุระยะเวลาการลา\n- หากลา 1 วัน ให้ใส่ระยะเวลาเป็นจำนวน 9 ชั่วโมง ตัวอย่างเช่น '8:00-17:00'\n- หากโปรแกรมมีการเตือนว่าใช้สิทธิลาเกิน แล้วยังทำรายการต่อ จะถือว่าเป็นการยินยอมให้หักเงิน",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  onPressed:
                                      selectLeaveType != "L003" ? null : () {},
                                  child: const SizedBox(
                                    width: 80,
                                    height: 40,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.upload_file_rounded,
                                          size: 24,
                                        ),
                                        Gap(5),
                                        Text("Upload"),
                                      ],
                                    ),
                                  )),
                              const Gap(10),
                              ElevatedButton(
                                  onPressed: selectLeaveType != null &&
                                          leaveDate.text != ""
                                      ? () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (selectLeaveType == "L001") {
                                              double tempLeave = vacationLeave;
                                              tempLeave -= dateCount;
                                              tempLeave;
                                              alertDialogInfo(
                                                  dateCount,
                                                  tempLeave < 0
                                                      ? tempLeave
                                                      : 0);
                                            } else if (selectLeaveType ==
                                                "L002") {
                                              double tempLeave = bussinessLeave;
                                              tempLeave -= dateCount;
                                              tempLeave;
                                              alertDialogInfo(
                                                  dateCount,
                                                  tempLeave < 0
                                                      ? tempLeave
                                                      : 0);
                                            } else if (selectLeaveType ==
                                                "L003") {
                                              double tempLeave = sickLeave;
                                              tempLeave -= dateCount;
                                              tempLeave;
                                              alertDialogInfo(
                                                  dateCount,
                                                  tempLeave < 0
                                                      ? tempLeave
                                                      : 0);
                                            } else if (selectLeaveType ==
                                                "L004") {
                                            } else {}
                                          } else {}

                                          //  alertDialogInfo();
                                        }
                                      : null,
                                  child: SizedBox(
                                    width: 70,
                                    height: 40,
                                    child: Row(
                                      children: [
                                        const Text("Send"),
                                        const Gap(5),
                                        Transform.rotate(
                                            alignment: Alignment.topCenter,
                                            angle: 37,
                                            child: const Icon(
                                              Icons.send_rounded,
                                            ))
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
