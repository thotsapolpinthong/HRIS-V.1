// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/employee_bloc/employee_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model/leave_employee_approve_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/ot_menu_model/dropdown_ot_request_type_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/ot_menu_model/dropdown_ot_type_model.dart';
import 'package:hris_app_prototype/src/model/self_service/ot/create_ot_request_manual_model.dart';
import 'package:hris_app_prototype/src/model/self_service/user_info/get_user_info_date_model.dart';
import 'package:hris_app_prototype/src/model/self_service/workdate/get_manual_workdate_time.dart';
import 'package:hris_app_prototype/src/services/api_employee_self_service.dart';
import 'package:hris_app_prototype/src/services/api_employee_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class CreateOt extends StatefulWidget {
  final EmployeeDatum employeeData;
  const CreateOt({
    Key? key,
    required this.employeeData,
  }) : super(key: key);

  @override
  State<CreateOt> createState() => _CreateOtState();
}

class _CreateOtState extends State<CreateOt> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  //approve
  List<EmployeeApproveModel> approveList = [];
  String? approveId;

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

  //ข้อมูลสแกนนิ้ว
  fetchDataUserInfo(String date) async {
    userInfoData = await ApiEmployeeSelfService.getUserInfoByDate(
        widget.employeeData.fingerScanId, date);
    manualTime = await ApiEmployeeSelfService.getManualWorkDateTime(
        widget.employeeData.employeeId, date);
    // timeStampList; //Test Data time
    setState(() {
      // userInfoData = UserInfoEmployeeModel(
      //     userInfoData: UserInfoData(userId: "1", workTimeData: timeStampList),
      //     message: "test",
      //     status: true); //Now data test <<<<<<<<<<<<<<<<<

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
            if (checkIn.text != "") {
              checkIn.text = checkIn.text;
              checkInIcon = 2;
            } else {
              checkIn.text = "";
              checkInIcon =
                  4; // 0 = no check , 1 = fingerprint , 2 = manual time , 3 = , 4 = empty
            }
          } else {
            checkIn.text = e.startTime;
            checkInIcon = 2;
          }
          if (e.endTime == "No data") {
            if (checkOut.text != "") {
              checkOut.text = checkOut.text;
              checkOutIcon = 2;
            } else {
              checkOut.text = "";
              checkOutIcon = 4;
            }
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
//check type 0 = no check , 1 = fingerprint , 2 = manual time , 3 = trip *อนาคต, 4 = empty
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
    } else if ((otTypeId == "N" ||
            otTypeId == "S") && // หากช่อง เวลาสแกนออก ไม่ได้มาจากเครื่องสแกน
        (checkInIcon == 2 && checkOutIcon == 2)) {
      //manual & manual
      // Check OUT Request
      if (from == true) {
        //start time textfield
        switch (otRequestTypeId) {
          case "A": // ot ก่อนเริ่มงาน
            if (selectedTime!.hour < timeIn.hour ||
                selectedTime.hour == timeIn.hour &&
                    selectedTime.minute < timeIn.minute) {
              startTime.text = selectedStartTime!.format(context).toString();
            } else {
              // เตือนข้อความอะไรบางอย่าง
              alertDialogInfoError("โปรดระบุเวลาก่อนเวลาจาก Manualworkdate");
              startTime.text = "";
            }
            break;

          case "B": // ot หลังเลิกงาน
            if (selectedTime!.hour > timeOut.hour ||
                selectedTime.hour == timeOut.hour &&
                    selectedTime.minute >= timeOut.minute) {
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
              alertDialogInfoError("โปรดระบุเวลาหลังจากเวลา Manualworkdate");
              endTime.text = "";
            }
            break;
          case "B": // ot หลังเลิกงาน
            if (selectedTime!.hour > timeStart.hour ||
                selectedTime.hour == timeStart.hour &&
                    selectedTime.minute > timeStart.minute) {
              endTime.text = selectedStartTime!.format(context).toString();
            } else {
              // เตือนข้อความอะไรบางอย่าง
              alertDialogInfoError(
                  "*โปรดระบุเวลาหลังจากเวลา Manualworkdate\nและหลังจากเวลา  Start Time");
              endTime.text = "";
            }
            break;
        }
        //end time textfield
      }
    }
    //----------------------------------------------------------------
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

// end of function Time ot Start time / End time----------------------------------------------
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
    String? employeeId;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId");
    CreateOtRequestManualModel createOtModel = CreateOtRequestManualModel(
        employeeId: widget.employeeData.employeeId,
        oTrequestTypeId: otRequestTypeId.toString(),
        otTypeId: otTypeId!,
        date: selectedDate.text,
        startTime: otTypeId == "H"
            ? checkIn.text
            : startTime.text == ""
                ? startTime.text
                : "${startTime.text}:00",
        endTime: otTypeId == "H"
            ? checkOut.text
            : endTime.text == ""
                ? endTime.text
                : "${endTime.text}:00",
        otDescription: noted.text,
        approveBy: approveId.toString(),
        createBy: employeeId.toString());
    bool success =
        await ApiEmployeeSelfService.createOTRequestManual(createOtModel);
    alertDialog(success);
  }

  alertDialog(bool success) {
    if (success == true) {
      context.read<EmployeeBloc>().add(
          FetchDataOtEmployeeEvent(employeeId: widget.employeeData.employeeId));
    }
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
        if (success == true) {
          context.read<EmployeeBloc>().add(FetchDataOtEmployeeEvent(
              employeeId: widget.employeeData.employeeId));
          Navigator.pop(context);
        }
      },
    ).show();
  }

  fetchDropdown() async {
    otTypeData = await ApiEmployeeService.getOtTypeDropdown();
    otRequestTypeData = await ApiEmployeeService.getOtRequestTypeDropdown();
    approveList = [
      await ApiEmployeeService.getEmployeeApprove(widget.employeeData
          .positionData.parentPositionBusinessNodeId.positionOrganizationId)
    ];

    setState(() {
      otTypeData;
      otRequestTypeData;
      approveList;
    });
  }

  @override
  void initState() {
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
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(5),
                  TextFormFieldDatepickGlobal(
                    controller: selectedDate,
                    labelText: "ระบุวันที่",
                    validatorless: null,
                    ontap: () {
                      selectvalidFromDate();
                    },
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownGlobal(
                            labeltext: 'OT Type',
                            value: otTypeId,
                            items: otTypeData?.overTimeTypeData.map((e) {
                              return DropdownMenuItem<String>(
                                value: e.otTypeCode.toString(),
                                child: Container(
                                    constraints: const BoxConstraints(
                                        maxWidth: 100, minWidth: 70),
                                    child: Text(e.otTypeName)),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                otTypeId = newValue.toString();
                                startTime.text = "";
                                endTime.text = "";
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
                                : otRequestTypeData?.overTimeRequestTypeData
                                    .map((e) {
                                    return DropdownMenuItem<String>(
                                      value: e.otRequestTypeId.toString(),
                                      child: Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 130, minWidth: 70),
                                          child: Text(e.oTrequestTypeName)),
                                    );
                                  }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                otRequestTypeId = newValue.toString();
                                startTime.text = "";
                                endTime.text = "";
                              });
                            },
                            validator: null),
                      ),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormFieldpicker(
                          controller: checkIn,
                          labelText: "(Check In Time).",
                          validatorless: null,
                          ontap: null,
                          enabled: false,
                          suffixIcon: checkInIcon == 0
                              ? null
                              : SizedBox(
                                  width: 40,
                                  child: Icon(
                                    checkInIcon == 1
                                        ? Icons.fingerprint_rounded
                                        : checkInIcon == 4
                                            ? Icons.cancel
                                            : Icons.edit_document,
                                    size: 30,
                                    color: checkInIcon == 1
                                        ? mygreencolors
                                        : checkInIcon == 4
                                            ? myredcolors
                                            : mythemecolor,
                                  ),
                                ),
                        ),
                      ),
                      Expanded(
                        child: TextFormFieldpicker(
                          controller: checkOut,
                          labelText: "(Check Out Time).",
                          validatorless: null,
                          ontap: null,
                          enabled: false,
                          suffixIcon: checkInIcon == 0
                              ? null
                              : SizedBox(
                                  width: 40,
                                  child: Icon(
                                    checkOutIcon == 1
                                        ? Icons.fingerprint_rounded
                                        : checkOutIcon == 4
                                            ? Icons.cancel
                                            : Icons.edit_document,
                                    size: 30,
                                    color: checkOutIcon == 1
                                        ? mygreencolors
                                        : checkOutIcon == 4
                                            ? myredcolors
                                            : mythemecolor,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormFieldTimepickGlobal(
                          controller: startTime,
                          labelText: "เวลาเริ่ม (Start Time).",
                          validatorless: null,
                          ontap: () {
                            selectTime(true);
                          },
                          enabled: otTypeId == "H" ||
                                  otTypeId == null ||
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
                  TextFormFieldGlobal(
                      controller: noted,
                      labelText: "รายละเอียดงาน",
                      hintText: '',
                      enabled: true,
                      validatorless: Validatorless.required("โปรดระบุ")),
                  const Gap(10),
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
                  // const Text(
                  //     "หมายเหตุ*\n- หากต้องการเลือกหลายวัน ควรเป็นโอทีประเภทเดียวกันและเวลาเดียวกัน\n- หากเลือกประเภทเป็น Holiday ไม่ต้องระบุ Request type\n- โปรดกรอกข้อมูลให้ครบถ้วน",
                  //     style: TextStyle(color: Colors.black54)),
                ],
              ),
            ),
          ),
        ),
        MySaveButtons(
          text: "Save",
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              alertDialogInfo();
            }
          },
        )
      ],
    );
  }
}

class OtTypeData {
  final String id;
  final String name;
  OtTypeData({
    required this.id,
    required this.name,
  });
}

class RequestTypeData {
  final String id;
  final String name;
  RequestTypeData({
    required this.id,
    required this.name,
  });
}

class HourSelect {
  final String id;
  HourSelect({
    required this.id,
  });
}

class MinuteSelect {
  final String id;
  MinuteSelect({
    required this.id,
  });
}
