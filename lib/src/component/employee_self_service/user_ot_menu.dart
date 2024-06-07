// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/ot_menu_model/dropdown_ot_request_type_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/ot_menu_model/dropdown_ot_type_model.dart';
import 'package:hris_app_prototype/src/model/self_service/ot/create_ot_request_online_model.dart';
import 'package:hris_app_prototype/src/model/self_service/ot/ot_request_model.dart';
import 'package:hris_app_prototype/src/model/self_service/ot/ot_time_count_model.dart';
import 'package:hris_app_prototype/src/model/self_service/user_info/get_user_info_date_model.dart';
import 'package:hris_app_prototype/src/model/self_service/user_info/get_user_info_model.dart';
import 'package:hris_app_prototype/src/model/self_service/workdate/get_manual_workdate_time.dart';
import 'package:hris_app_prototype/src/services/api_employee_self_service.dart';
import 'package:hris_app_prototype/src/services/api_employee_service.dart';
import 'package:validatorless/validatorless.dart';

class OTManage extends StatefulWidget {
  final EmployeeDatum? employeeData;
  final OtTimeCountModel? otTimeCountData;
  const OTManage({
    Key? key,
    required this.employeeData,
    required this.otTimeCountData,
  }) : super(key: key);

  @override
  State<OTManage> createState() => _OTManageState();
}

class _OTManageState extends State<OTManage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  OtRequestModel? requestData;
  bool isLoading = true;
  TextEditingController noted = TextEditingController();
  //calendar
  TextEditingController selectedDate = TextEditingController();
  List<DateTime?> dates = [];
  List<String> selectedDateList = [];

  //dropdown
  OverTimeTypeModel? otTypeData;
  String? otTypeId;
  OverTimeRequestTypeModel? otRequestTypeData;
  String? otRequestTypeId;

  //time
  TimeOfDay? selectedStartTime;
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();

  //user info (time stamp)
  UserInfoDateModel? userInfoData;
  TextEditingController checkIn = TextEditingController();
  int checkInIcon =
      0; // 0 = no check , 1 = fingerprint , 2 = manual time , 3 = , 4 = empty
  TextEditingController checkOut = TextEditingController();
  int checkOutIcon =
      0; // 0 = no check , 1 = fingerprint , 2 = manual time , 3 = , 4 = empty
  //manual work date time
  ManualWorkDateTimeModel? manualTime;

  List<WorkTimeDatum> timeStampList = [
    // WorkTimeDatum(
    //     date: "2024-02-14", checkInTime: "07:55:00", checkOutTime: ""),
    // WorkTimeDatum(
    //     date: "2024-02-15", checkInTime: "", checkOutTime: "17:22:00"),
    // WorkTimeDatum(
    //     date: "2024-02-16", checkInTime: "07:55:00", checkOutTime: "17:33:00"),
    // WorkTimeDatum(
    //     date: "2024-02-17", checkInTime: "07:55:00", checkOutTime: "17:33:00"),
    // WorkTimeDatum(
    //     date: "2024-02-18", checkInTime: "07:55:00", checkOutTime: "17:33:00"),
    // WorkTimeDatum(
    //     date: "2024-02-19", checkInTime: "07:55:00", checkOutTime: ""),
    // WorkTimeDatum(
    //     date: "2024-02-20", checkInTime: "", checkOutTime: "17:33:00"),
    // WorkTimeDatum(
    //     date: "2024-02-21", checkInTime: "07:55:00", checkOutTime: "17:33:00"),
    // WorkTimeDatum(
    //     date: "2024-02-22", checkInTime: "07:51:00", checkOutTime: ""),
    WorkTimeDatum(
        date: "2024-02-23", checkInTime: "", checkOutTime: "17:33:00"),
  ];

//Function ----------------------------------------------------

// Select date
  Future<void> selectvalidFromDate() async {
    // DateTime startDate = DateTime.parse(widget.calendarStartDate);
    // DateTime endDate = DateTime.parse(widget.calendarEndDate);

    DateTime? picker = await showDatePicker(
      // selectableDayPredicate: (DateTime val) => val.weekday == 7 ? false : true,
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 1)),
      firstDate: DateTime(1950),
      lastDate: DateTime.now().subtract(const Duration(days: 1)),
    );
    if (picker != null) {
      setState(() {
        selectedDate.text = picker.toString().split(" ")[0];

        if (selectedDate.text != "") {
          fetchDataUserInfo(selectedDate.text);
        }
      });
    }
  }

  // เลือกหลายวัน
  // Future<void> selectDateFromDate() async {
  //   var picker = await showCalendarDatePicker2Dialog(
  //     context: context,
  //     config: CalendarDatePicker2WithActionButtonsConfig(
  //       firstDate: DateTime(DateTime.now().year - 1, 01, 1),
  //       lastDate: DateTime.now(),
  //       firstDayOfWeek: 1,
  //       calendarType: CalendarDatePicker2Type.single,
  //       dayTextStyle: const TextStyle(
  //         color: Colors.black,
  //       ),
  //       dayTextStylePredicate: ({required date}) {
  //         TextStyle? textStyle;
  //         if (date.weekday == DateTime.sunday) {
  //           textStyle =
  //               TextStyle(color: Colors.red[500], fontWeight: FontWeight.w600);
  //         }
  //         return textStyle;
  //       },
  //       weekdayLabelTextStyle:
  //           TextStyle(color: mythemecolor, fontWeight: FontWeight.bold),
  //     ),
  //     dialogSize: const Size(500, 400),
  //     value: dates,
  //     borderRadius: BorderRadius.circular(15),
  //   );
  //   if (picker != null) {
  //     setState(() {
  //       selectedDateList = picker.map((data) {
  //         if (data != null) {
  //           // ใช้ DateFormat จาก package:intl เพื่อแปลง DateTime เป็น String
  //           return DateFormat('yyyy-MM-dd').format(data);
  //         } else {
  //           return ''; // หรือค่าอื่น ๆ ที่คุณต้องการในกรณีที่ DateTime เป็น null
  //         }
  //       }).toList();
  //       //  dateCount = picker.length.toDouble();
  //       selectedDate.text = selectedDateList.toString();
  //       if (selectedDate.text != "") {
  //         fetchDataUserInfo(selectedDate.text);
  //       }
  //       if (picker.isEmpty) {
  //         selectedDate.text = '';
  //         //   dateCount = 0;
  //       } else {}
  //     });
  //   }
  // }

  //ข้อมูลสแกนนิ้ว
  fetchDataUserInfo(String date) async {
    userInfoData = await ApiEmployeeSelfService.getUserInfoByDate(
        widget.employeeData!.fingerScanId, date);
    manualTime = await ApiEmployeeSelfService.getManualWorkDateTime(
        widget.employeeData!.employeeId, date);
    timeStampList; //Test Data time
    setState(() {
      //Now data test <<<<<<<<<<<<<<<<<
      // userInfoData = UserInfoEmployeeModel(
      //     userInfoData: UserInfoData(userId: "1", workTimeData: timeStampList),
      //     message: "test",
      //     status: true);

      userInfoData; //time scan data
      manualTime; //manualworkdate time data
      checkIn.text = "";
      checkOut.text = "";
      conditionTimescan();
    });
  }

  conditionTimescan() {
    setState(() {
      //เงื่อนไขตรวจสอบวันที่ไม่มีเวลาเข้า-ออกงาน
      if (manualTime != null) {
        // นำเข้าข้อมูลเวลา manualworkdate //ตอนนี้เงื่อนไข ยังมีหลาย record ไม่ได้
        for (var e in manualTime!.manualWorkDateData) {
          if (e.startTime == "No data") {
            checkIn.text = "";
            checkInIcon = 4;
          } else {
            checkIn.text = e.startTime;
            checkInIcon = 2;
          }
          if (e.endTime == "No data") {
            checkOut.text = "";
            checkOutIcon = 4;
          } else {
            checkOut.text = e.endTime;
            checkOutIcon = 2;
          }
        }
      } else {
        checkIn.text = "";
        checkInIcon = 4;
        checkOut.text = "";
        checkOutIcon = 4;
      }
      if (userInfoData != null) {
        // นำเข้าข้อมูลเวลา Time Scan
        // Icon >> 0 = no check , 1 = fingerprint , 2 = manual time , 3 = , 4 = empty <<

        if (userInfoData!.userInfoData.workTimeData.checkInTime != "") {
          checkIn.text = userInfoData!.userInfoData.workTimeData.checkInTime;
          checkInIcon = 1;
        } else {}
        if (userInfoData!.userInfoData.workTimeData.checkOutTime != "") {
          checkOut.text = userInfoData!.userInfoData.workTimeData.checkOutTime;
          checkOutIcon = 1;
        } else {}
        // end if checkin time
      } else {
        //ถ้าไม่มีเวลาเข้าออก
      }
    });
  }
// end date and Time scan check in / out--------------------------------------------

// Functions of Time scanner to Ot Start Time / End Time
//เวลา
  Future<void> selectTime(bool from) async {
    TimeOfDay? selectedTime24Hour = await showTimePicker(
      context: context,
      helpText: from == true //true = start time , false = end time
          ? "เวลาที่เริ่มทำงานล่วงเวลา (Start time OT)"
          : "เวลาที่สิ้นสุดทำงานล่วงเวลา \n(Finish time OT)",
      hourLabelText: " นาฬิกา         hour",
      minuteLabelText: " นาที         minute",
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
        conditionStartTime(from, selectedStartTime);
      });
    }
  }

//เงื่อนไข บันทึกเวลาเข้า - ออกโอที
  conditionStartTime(bool from, TimeOfDay? selectedTime) {
    checkIn.text;
    checkOut.text;
    otRequestTypeId;
    otTypeId;
    TimeOfDay timeIn = TimeOfDay(
        hour: int.parse(checkIn.text.split(':')[0]),
        minute: int.parse(checkIn.text.split(':')[1]));
    TimeOfDay timeOut = TimeOfDay(
        hour: int.parse(checkOut.text.split(':')[0]),
        minute: int.parse(checkOut.text.split(':')[1]));
//ot type  H = Holiday, N = OT-normal , S = OT-holiday, SP = OT-Special
//check type 0 = no check , 1 = fingerprint , 2 = manual time , 3 = trip *อยาคต, 4 = empty
// OT Normal | Ot holiday (มีเวลาสแกนนิ้ว ปกติ)
//เงื่อนไข เวลาเริ่ม จะต้องมากกว่าเวลาสแกนเข้า และน้อยกว่าสแกนออก
//เวลาสิ้นสุด จะต้องมากกว่าเวลาที่เลือกจะต้องน้อยกว่าเวลาสแกนออก
    if ((otTypeId == "N" || otTypeId == "S") &&
        (checkInIcon == 1 && checkOutIcon == 1)) {
      if (from == true) {
        //start time textfield
        // for StartTime กรอกเวลาเริ่ม
        if ((selectedTime!.hour > timeIn.hour ||
                (selectedTime.hour == timeIn.hour &&
                    selectedTime.minute >= timeIn.minute)) &&
            (selectedTime.hour < timeOut.hour ||
                (selectedTime.hour == timeOut.hour &&
                    selectedTime.minute <= timeOut.minute))) {
          startTime.text = selectedStartTime!.format(context).toString();
        } else {
          // เตือนข้อความอะไรบางอย่าง
          alertDialogInfoError("โปรดระบุเวลาในขอบเขต เวลาแสกนนิ้วเท่านั้น");
          startTime.text = "";
        }
      } else {
        //end time textfield
        // for EndTime  กรอกเวลาสิ้นสุด
        TimeOfDay timeStart = TimeOfDay(
            hour: int.parse(startTime.text.split(':')[0]),
            minute: int.parse(startTime.text.split(':')[1]));
        if ((selectedTime!.hour > timeStart.hour ||
                (selectedTime.hour == timeStart.hour &&
                    selectedTime.minute >= timeStart.minute)) &&
            (selectedTime.hour < timeOut.hour ||
                (selectedTime.hour == timeOut.hour &&
                    selectedTime.minute <= timeOut.minute))) {
          endTime.text = selectedStartTime!.format(context).toString();
        } else {
          // เตือนข้อความอะไรบางอย่าง
          alertDialogInfoError("โปรดระบุเวลาในขอบเขต เวลาแสกนนิ้วเท่านั้น");
          endTime.text = "";
        }
      } //----------------------------------------------------------------
    } else if ((otTypeId == "N" ||
            otTypeId == "S") && // หากช่อง เวลาสแกนเข้า ไม่ได้มาจากเครื่องสแกน
        (checkInIcon != 1 && checkOutIcon == 1)) {
      // Check IN Request
      if (from == true) {
        //start time textfield
        switch (otRequestTypeId) {
          case "A": // ot ก่อนเริ่มงาน
            if (selectedTime!.hour < timeIn.hour ||
                selectedTime.hour == timeIn.hour &&
                    selectedTime.minute <= timeIn.minute) {
              startTime.text = selectedStartTime!.format(context).toString();
            } else {
              // เตือนข้อความอะไรบางอย่าง
              alertDialogInfoError("โปรดระบุเวลาก่อนเวลาจาก Manualworkdate");
              startTime.text = "";
            }
            break;

          case "B": // ot หลังเลิกงาน
            if (selectedTime!.hour < timeOut.hour ||
                selectedTime.hour == timeOut.hour &&
                    selectedTime.minute <= timeOut.minute) {
              startTime.text = selectedStartTime!.format(context).toString();
            } else {
              // เตือนข้อความอะไรบางอย่าง
              alertDialogInfoError("โปรดระบุเวลาก่อนเวลาแสกนนิ้ว");
              startTime.text = "";
            }
            break;
        }
      } else {
        //end time textfield
        TimeOfDay timeStart = TimeOfDay(
            hour: int.parse(startTime.text.split(':')[0]),
            minute: int.parse(startTime.text.split(':')[1]));
        switch (otRequestTypeId) {
          case "A": // ot ก่อนเริ่มงาน
            if ((selectedTime!.hour > timeStart.hour ||
                    selectedTime.hour == timeStart.hour &&
                        selectedTime.minute > timeStart.minute) &&
                (selectedTime.hour < timeIn.hour ||
                    selectedTime.hour == timeIn.hour &&
                        selectedTime.minute <= timeIn.minute)) {
              endTime.text = selectedStartTime!.format(context).toString();
            } else {
              // เตือนข้อความอะไรบางอย่าง
              alertDialogInfoError("โปรดระบุเวลาก่อนเวลาจาก Manualworkdate");
              endTime.text = "";
            }
            break;
          case "B": // ot หลังเลิกงาน
            if ((selectedTime!.hour > timeStart.hour ||
                    selectedTime.hour == timeStart.hour &&
                        selectedTime.minute >= timeStart.minute) &&
                (selectedTime.hour < timeOut.hour ||
                    selectedTime.hour == timeOut.hour &&
                        selectedTime.minute <= timeOut.minute)) {
              endTime.text = selectedStartTime!.format(context).toString();
            } else {
              // เตือนข้อความอะไรบางอย่าง
              alertDialogInfoError("โปรดระบุเวลาในขอบเขต เวลาแสกนนิ้วเท่านั้น");
              endTime.text = "";
            }
            break;
        }
      }
    } //----------------------------------------------------------------
    else if ((otTypeId == "N" ||
            otTypeId == "S") && // หากช่อง เวลาสแกนออก ไม่ได้มาจากเครื่องสแกน
        (checkInIcon == 1 && checkOutIcon != 1)) {
      // Check OUT Request
      if (from == true) {
        //start time textfield
        switch (otRequestTypeId) {
          case "A": // ot ก่อนเริ่มงาน
            if (selectedTime!.hour > timeIn.hour ||
                (selectedTime.hour == timeIn.hour &&
                    selectedTime.minute >= timeIn.minute)) {
              startTime.text = selectedStartTime!.format(context).toString();
            } else {
              // เตือนข้อความอะไรบางอย่าง
              alertDialogInfoError(
                  "*เนื่องจากมีเวลาแสกนนิ้ว\nโปรดระบุเวลาในขอบเขต เวลาแสกนนิ้วเท่านั้น");
              startTime.text = "";
            }
            break;
          case "B": // ot หลังเลิกงาน
            if (selectedTime!.hour > timeOut.hour ||
                (selectedTime.hour == timeOut.hour &&
                    selectedTime.minute >= timeOut.minute)) {
              startTime.text = selectedStartTime!.format(context).toString();
            } else {
              // เตือนข้อความอะไรบางอย่าง
              alertDialogInfoError(
                  "*เนื่องจากมีเวลาManualworkdate\nโปรดระบุเวลาหลังจากเวลา Check Out ");
              startTime.text = "";
            }
            break;
        }
      } else {
        //end time textfield
        TimeOfDay timeStart = TimeOfDay(
            hour: int.parse(startTime.text.split(':')[0]),
            minute: int.parse(startTime.text.split(':')[1]));
        switch (otRequestTypeId) {
          case "A": // ot ก่อนเริ่มงาน
            if ((selectedTime!.hour > timeStart.hour ||
                    selectedTime.hour == timeStart.hour &&
                        selectedTime.minute > timeStart.minute) &&
                (selectedTime.hour < timeOut.hour ||
                    selectedTime.hour == timeOut.hour &&
                        selectedTime.minute <= timeOut.minute)) {
              endTime.text = selectedStartTime!.format(context).toString();
            } else {
              // เตือนข้อความอะไรบางอย่าง
              alertDialogInfoError("โปรดระบุเวลาในขอบเขต เวลาแสกนนิ้วเท่านั้น");
              endTime.text = "";
            }
            break;
          case "B": // ot หลังเลิกงาน
            if (selectedTime!.hour > timeStart.hour ||
                selectedTime.hour == timeStart.hour &&
                    selectedTime.minute >= timeStart.minute) {
              endTime.text = selectedStartTime!.format(context).toString();
            } else {
              // เตือนข้อความอะไรบางอย่าง
              alertDialogInfoError(
                  "*เนื่องจากมีเวลาManualworkdate\nโปรดระบุเวลาหลังจากเวลา Check Out");
              endTime.text = "";
            }
            break;
        }
        //end time textfield
      }
    } //----------------------------------------------------------------
    else {
      if (from == true) {
        //start time textfield
        startTime.text = selectedStartTime!.format(context).toString();
      } else {
        //end time textfield
        endTime.text = selectedStartTime!.format(context).toString();
      }
    } //----------------------------------------------------------------

// OT Normal | Ot holiday (มีเวลาสแกนนิ้ว รวมกับเวลา manualworkdate)
//>>> โอที ก่อนเริ่มงาน <<<
//>>> โอทีหลังเลิกงาน <<<
  }

// end of function Time ot Start time / End time----------------------------------------------
  alertDialogInfoError(String text) {
    AwesomeDialog(
      width: 400,
      context: context,
      animType: AnimType.topSlide,
      dialogType: DialogType.error,
      body: Column(
        children: [
          const Gap(10),
          const TextThai(text: "ไม่สามารถใส่เวลาดังกล่าวได้"),
          const Gap(5),
          TextThai(
            text: text,
            textAlign: TextAlign.center,
          ),
          const Gap(10),
        ],
      ),
      btnOkColor: Colors.red[600],
      btnOkOnPress: () {},
    ).show();
  }

  alertDialogInfo() {
    AwesomeDialog(
            width: 400,
            context: context,
            animType: AnimType.topSlide,
            dialogType: DialogType.info,
            title: 'Confirm',
            desc: 'ต้องการยื่นใบคำร้องOT',
            btnOkColor: mythemecolor,
            btnOkOnPress: () {
              createFunction();
            },
            btnCancelOnPress: () {})
        .show();
  }

  createFunction() async {
    CreateOtRequestModel createOtModel = CreateOtRequestModel(
        employeeId: widget.employeeData!.employeeId,
        oTrequestTypeId: otRequestTypeId.toString(),
        otTypeId: otTypeId!,
        date: selectedDate.text,
        startTime:
            startTime.text == "" ? startTime.text : "${startTime.text}:00",
        endTime: endTime.text == "" ? endTime.text : "${endTime.text}:00",
        otDescription: noted.text,
        createBy: widget.employeeData!.employeeId);

    bool success =
        await ApiEmployeeSelfService.createOTRequestOnline(createOtModel);
    alertDialog(success);
    if (success == true) {
      fetchData();
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
                success == true ? 'Created Success.' : 'Created Fail.',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              Text(
                success == true
                    ? 'ยื่นใบคำขอOT สำเร็จ'
                    : 'ยื่นใบคำขอOT ไม่สำเร็จ',
                //style: const TextStyle(fontStyle: FontStyle.italic),
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

  fetchData() async {
    requestData = await ApiEmployeeSelfService.getOtRequestByEmployeeId(
        widget.employeeData!.employeeId);
    setState(() {
      requestData;
      isLoading = false;
    });
  }

  fetchDropdown() async {
    otTypeData = await ApiEmployeeService.getOtTypeDropdown();
    otRequestTypeData = await ApiEmployeeService.getOtRequestTypeDropdown();

    setState(() {
      otTypeData;
      otRequestTypeData;
    });
  }

  @override
  void initState() {
    fetchData();
    fetchDropdown();
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ข้อมูลบันทึกการทำงานล่วงเวลา"),
      ),
      body: Row(
        children: [
          //หน้าต่างฝั่งซ้าย
          Expanded(
            flex: 3,
            child: Column(
              children: [
                const Gap(20),
                rowStat(widget.otTimeCountData),
                const Gap(20),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "OT Request :",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                    child: isLoading == true
                        ? myLoadingScreen
                        : ListView.builder(
                            itemCount: requestData == null
                                ? 1
                                : requestData?.overTimeRequestData.length,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 2,
                                child: SizedBox(
                                  height: 70,
                                  child: Center(
                                    child: ListTile(
                                      leading: requestData == null
                                          ? null
                                          : SizedBox(
                                              height: 40,
                                              child: Icon(
                                                requestData
                                                            ?.overTimeRequestData[
                                                                index]
                                                            .otTypeData
                                                            .otTypeCode ==
                                                        "H"
                                                    ? Icons.weekend_rounded
                                                    : requestData
                                                                ?.overTimeRequestData[
                                                                    index]
                                                                .otTypeData
                                                                .otTypeCode ==
                                                            "N"
                                                        ? Icons
                                                            .work_outline_rounded
                                                        : requestData
                                                                    ?.overTimeRequestData[
                                                                        index]
                                                                    .otTypeData
                                                                    .otTypeCode ==
                                                                "S"
                                                            ? Icons
                                                                .work_history_rounded
                                                            : Icons
                                                                .workspace_premium_rounded,
                                                size: 30,
                                              )),
                                      title: requestData == null
                                          ? const Center(
                                              child: Text(
                                              "ไม่มีใบคำร้อง",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ))
                                          : Row(
                                              children: [
                                                Text(
                                                    "${requestData?.overTimeRequestData[index].otTypeData.otTypeName} | ${requestData?.overTimeRequestData[index].oTrequestTypeData.oTrequestTypeName}"),
                                              ],
                                            ),
                                      subtitle: requestData == null
                                          ? null
                                          : Text(
                                              "วันที่ ${requestData?.overTimeRequestData[index].otDate} เวลา ${requestData?.overTimeRequestData[index].otData[0].otStartTime} - ${requestData?.overTimeRequestData[index].otData[0].otEndTime} จำนวนชั่วโมง ${requestData?.overTimeRequestData[index].otData[0].nCountOt}"),
                                      trailing: requestData == null
                                          ? null
                                          : Container(
                                              decoration: BoxDecoration(
                                                  color: requestData
                                                              ?.overTimeRequestData[
                                                                  index]
                                                              .status ==
                                                          "request"
                                                      ? Colors.amberAccent[100]
                                                      : requestData
                                                                  ?.overTimeRequestData[
                                                                      index]
                                                                  .status ==
                                                              "approve"
                                                          ? Colors.greenAccent
                                                          : Colors
                                                              .redAccent[100],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14)),
                                              width: 100,
                                              height: 30,
                                              child: Center(
                                                  child: Text(
                                                      "${requestData?.overTimeRequestData[index].status}",
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
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
          //หน้าต่างฝั่งขวา
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Gap(10),
                      const Text(
                        "ใบคำขอ OT",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Text("Request for overtime."),
                      const Gap(20),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            constraints: const BoxConstraints(
                              maxWidth: 490,
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Gap(10),
                                  const Text(
                                      " ระบุวันที่ (สามารถเลือกได้ทีละวัน)",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  const Gap(5),
                                  TextFormFieldDatepickGlobal(
                                    controller: selectedDate,
                                    labelText: "",
                                    validatorless: null,
                                    ontap: () {
                                      // selectDateFromDate();
                                      selectvalidFromDate();
                                    },
                                  ),
                                  const Gap(10),
                                  const Text(" เลือกประเภท (OT)",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  const Gap(5),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: DropdownGlobal(
                                            labeltext: 'OT Type',
                                            value: otTypeId,
                                            items: otTypeData?.overTimeTypeData
                                                .map((e) {
                                              return DropdownMenuItem<String>(
                                                value: e.otTypeCode.toString(),
                                                child: Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                            maxWidth: 100,
                                                            minWidth: 70),
                                                    child: Text(
                                                        "${e.otTypeName} ${e.otTypeCode} ")),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                otTypeId = newValue.toString();
                                                if (otTypeId == "H") {
                                                  otRequestTypeId = null;
                                                }
                                              });
                                            },
                                            validator: null),
                                      ),
                                      Expanded(
                                        child: DropdownGlobal(
                                            labeltext: 'Request Type',
                                            value: otRequestTypeId,
                                            items: otTypeId == "H"
                                                ? null
                                                : otRequestTypeData
                                                    ?.overTimeRequestTypeData
                                                    .map((e) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: e.otRequestTypeId
                                                          .toString(),
                                                      child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                                  maxWidth: 130,
                                                                  minWidth: 70),
                                                          child: Text(
                                                              "${e.oTrequestTypeName} ${e.otRequestTypeId}")),
                                                    );
                                                  }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                otRequestTypeId =
                                                    newValue.toString();
                                              });
                                            },
                                            validator: null),
                                      ),
                                    ],
                                  ),
                                  const Gap(10),
                                  const Text(" Time scan",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  const Gap(5),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: TextFormFieldpicker(
                                          controller: checkIn,
                                          labelText: "(Check In).",
                                          validatorless: null,
                                          ontap: null,
                                          enabled: false,
                                          suffixIcon: checkInIcon == 0
                                              ? null
                                              : SizedBox(
                                                  width: 40,
                                                  child: Icon(
                                                    checkInIcon == 1
                                                        ? Icons
                                                            .fingerprint_rounded
                                                        : checkInIcon == 4
                                                            ? Icons.cancel
                                                            : Icons
                                                                .edit_document,
                                                    size: 30,
                                                  ),
                                                ),
                                        ),
                                      ),
                                      Expanded(
                                        child: TextFormFieldpicker(
                                          controller: checkOut,
                                          labelText: "(Check Out).",
                                          validatorless: null,
                                          ontap: null,
                                          enabled: false,
                                          suffixIcon: checkInIcon == 0
                                              ? null
                                              : SizedBox(
                                                  width: 40,
                                                  child: Icon(
                                                    checkOutIcon == 1
                                                        ? Icons
                                                            .fingerprint_rounded
                                                        : checkOutIcon == 4
                                                            ? Icons.cancel
                                                            : Icons
                                                                .edit_document,
                                                    size: 30,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(10),
                                  const Text(" ระบุระยะเวลา",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  const Gap(5),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: TextFormFieldTimepickGlobal(
                                          controller: startTime,
                                          labelText: "เวลาเริ่ม (Start Time).",
                                          validatorless: null,
                                          ontap: () {
                                            selectTime(true);
                                          },
                                          enabled: otTypeId == null ||
                                                  otRequestTypeId == null &&
                                                      checkIn.text == "" ||
                                                  checkOut.text == ""
                                              ? false
                                              : true,
                                        ),
                                      ),
                                      Expanded(
                                        child: TextFormFieldTimepickGlobal(
                                          controller: endTime,
                                          labelText: "เวลาสิ้นสุด (End Time).",
                                          validatorless: null,
                                          ontap: () {
                                            selectTime(false);
                                          },
                                          enabled: checkIn.text == "" ||
                                                  checkOut.text == "" ||
                                                  startTime.text == ""
                                              ? false
                                              : true,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(10),
                                  const Text(" รายละเอียดงาน",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  const Gap(5),
                                  TextFormFieldGlobal(
                                      controller: noted,
                                      labelText: "",
                                      hintText: '',
                                      enabled: true,
                                      validatorless:
                                          Validatorless.required("โปรดระบุ")),
                                  const Gap(10),
                                  const Text(
                                      "หมายเหตุ*\n- หากต้องการเลือกหลายวัน ควรเป็นโอทีประเภทเดียวกันและเวลาเดียวกัน\n- หากเลือกประเภทเป็น Holiday ไม่ต้องระบุ Request type\n- โปรดกรอกข้อมูลให้ครบถ้วน",
                                      style: TextStyle(color: Colors.black54)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                alertDialogInfo();
                              }
                            },
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget rowStat(OtTimeCountModel? otTimeCountData) {
    return Row(
      children: [
        Expanded(
            child: MyOtListTile(
          title: "Holiday",
          subTitle: "ทำงานวันหยุด",
          countTime: otTimeCountData == null
              ? 0
              : otTimeCountData.overTimeCountData.holidayTotalAmount,
          type: 1,
        )).animate().scale().fadeIn().slideX(),
        Expanded(
                child: MyOtListTile(
          title: "OT-normal",
          subTitle: "โอทีวันทำงาน",
          countTime: otTimeCountData == null
              ? 0
              : otTimeCountData.overTimeCountData.otNormalTotalAmount,
          type: 2,
        ))
            .animate()
            .scaleXY(delay: 100.ms)
            .fadeIn(delay: 100.ms)
            .slideX(delay: 100.ms),
        Expanded(
                child: MyOtListTile(
          title: "OT-holiday",
          subTitle: "โอทีในวันหยุด",
          countTime: otTimeCountData == null
              ? 0
              : otTimeCountData.overTimeCountData.otHolidayTotalAmount,
          type: 3,
        ))
            .animate()
            .scaleXY(delay: 200.ms)
            .fadeIn(delay: 200.ms)
            .slideX(delay: 200.ms),
        Expanded(
                child: MyOtListTile(
          title: "OT-special",
          subTitle: "โอทีแบบเหมา",
          countTime: otTimeCountData == null
              ? 0
              : otTimeCountData.overTimeCountData.otSpecialTotalAmount,
          type: 4,
        ))
            .animate()
            .scaleXY(delay: 300.ms)
            .fadeIn(delay: 300.ms)
            .slideX(delay: 300.ms),
      ],
    );
  }
}

class MyOtListTile extends StatelessWidget {
  final double countTime;
  final String title;
  final String subTitle;
  final int type; //  1,2,3,4
  const MyOtListTile({
    Key? key,
    required this.countTime,
    required this.title,
    required this.subTitle,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Center(
        child: ListTile(
          minLeadingWidth: 25,
          leading: SizedBox(
            width: 25,
            height: 30,
            child: Icon(
              type == 1
                  ? Icons.weekend_rounded
                  : type == 2
                      ? Icons.work_outline_rounded
                      : type == 3
                          ? Icons.work_history_rounded
                          : Icons.workspace_premium_rounded,
              size: 25,
            ),
          ),
          title: Text(title),
          subtitle: Text(subTitle),
          trailing: SizedBox(
            height: 43,
            child: Column(
              children: [
                Text(
                  countTime.toStringAsFixed(2),
                  style: TextStyle(
                      fontSize: 16,
                      color: countTime == 0
                          ? Colors.black54
                          : Colors.greenAccent[700]),
                ),
                const Text(
                  "ชั่วโมง",
                  style: TextStyle(color: Colors.black54),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
