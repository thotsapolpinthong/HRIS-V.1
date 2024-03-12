// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/selfservice_bloc/selfservice_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_address.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model/leave_employee_approve_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/manual_workdate_menu/create_manual_workdate_hr_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/manual_workdate_menu/manual_workdate_type_model.dart';
import 'package:hris_app_prototype/src/model/self_service/user_info/get_user_info_date_model.dart';
import 'package:hris_app_prototype/src/model/self_service/workdate/create_online_manual_workdate.dart';
import 'package:hris_app_prototype/src/model/time_attendance/shift/dropdown_shift_model.dart';
import 'package:hris_app_prototype/src/services/api_employee_self_service.dart';
import 'package:hris_app_prototype/src/services/api_employee_service.dart';
import 'package:hris_app_prototype/src/services/api_time_attendance_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class CreateManualWorkdate extends StatefulWidget {
  final EmployeeDatum employeeData;
  final int menuType;
  final String? date;
  final String calendarStartDate;
  final String calendarEndDate;
  final int formpage; //1 = selfeService, 2 = employee HR
  const CreateManualWorkdate({
    Key? key,
    required this.employeeData,
    required this.menuType,
    this.date,
    required this.calendarStartDate,
    required this.calendarEndDate,
    required this.formpage,
  }) : super(key: key);

  @override
  State<CreateManualWorkdate> createState() => _CreateManualWorkdateState();
}

class _CreateManualWorkdateState extends State<CreateManualWorkdate> {
  TextEditingController selectedDate = TextEditingController();
  // TextEditingController scanIn = TextEditingController();
  // TextEditingController scanOut = TextEditingController();
  //
  ManualWorkDateTypeModel? manualWorkDateTypeList;
  TextEditingController description = TextEditingController();
  String? typeId;
  List<TypeManualWorkdate> typeList = [
    TypeManualWorkdate(id: "A01", name: "เวลาเข้างาน"),
    TypeManualWorkdate(id: "A02", name: "เวลาออกงาน"),
    TypeManualWorkdate(id: "A03", name: "ลืมบัตร"),
  ];

  //Shift Dropdown Data
  List<ShiftDatum>? shiftList;
  String? shiftId;
  String? shiftName;
  String? shiftStartTime; // สำหรับ ลืมเวลาเข้า
  String? shiftEndTime; //สำหรับ ลืมเวลาออก

//user info (time stamp)
  UserInfoDateModel? userInfoData;
//approve
  List<EmployeeApproveModel> approveList = [];
  String? approveId;

//Function ----------------------------------------------------
  Future<void> selectvalidFromDate() async {
    DateTime startDate = DateTime.parse(widget.calendarStartDate);
    DateTime endDate = DateTime.parse(widget.calendarEndDate);

    DateTime? picker = await showDatePicker(
      // selectableDayPredicate: (DateTime val) => val.weekday == 7 ? false : true,
      context: context,
      initialDate: endDate, // DateTime.now().subtract(const Duration(days: 1)),
      firstDate: startDate, //DateTime(1950),
      lastDate: endDate, // DateTime.now().subtract(const Duration(days: 1)),
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

  alertDialogInfo() {
    AwesomeDialog(
            width: 400,
            context: context,
            animType: AnimType.topSlide,
            dialogType: DialogType.info,
            title: 'Confirm',
            desc: 'ต้องการยื่นใบคำร้อง',
            btnOkColor: mythemecolor,
            btnOkOnPress: () {
              create();
            },
            btnCancelOnPress: () {})
        .show();
  }

  create() async {
    String? employeeId;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId");
    bool success = false;
    if (widget.formpage == 1) {
      CreateManualWorkDateOnlineModel createModel =
          CreateManualWorkDateOnlineModel(
              manualWorkDateTypeId: typeId.toString(),
              employeeId: widget.employeeData.employeeId,
              date: selectedDate.text,
              // times: typeId == "A01"
              //     ? shiftStartTime.toString()
              //     : shiftEndTime.toString(),
              startTime: typeId == "A02"
                  ? ""
                  : shiftStartTime.toString(), //ส่งเวลายกเว้น ประเภทลืมเวลาออก
              endTime: typeId == "A01"
                  ? ""
                  : shiftEndTime.toString(), //ส่งเวลายกเว้น ประเภทลืมเวลาเข้า
              decription: description.text,
              createBy: employeeId!);
      success = await ApiEmployeeSelfService.createManualWorkDateRequestOnline(
          createModel);
    } else {
      CreateManualWorkDateManualModel createModel =
          CreateManualWorkDateManualModel(
              manualWorkDateTypeId: typeId.toString(),
              employeeId: widget.employeeData.employeeId,
              date: selectedDate.text,
              startTime: typeId == "A02"
                  ? ""
                  : shiftStartTime.toString(), //ส่งเวลายกเว้น ประเภทลืมเวลาออก
              endTime: typeId == "A01" ? "" : shiftEndTime.toString(), //ส่
              decription: description.text,
              createBy: employeeId!,
              approveBy: approveId!);
      success = await ApiEmployeeSelfService.createManualWorkDateRequestManual(
          createModel);
    }

    alertDialog(success);
    if (success == true) {
      // ignore: use_build_context_synchronously
      context.read<SelfServiceBloc>().add(FetchDataManualWorkDateEvent(
          employeeId: widget.employeeData.employeeId));
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
                    ? 'ยื่นใบคำร้อง สำเร็จ'
                    : 'ยื่นใบคำร้อง ไม่สำเร็จ',
                //style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
      btnOkColor: success == true ? Colors.greenAccent : Colors.red,
      btnOkOnPress: () {
        fetchData();
        Navigator.pop(context);
      },
    ).show();
  }

  fetchData() async {
    manualWorkDateTypeList =
        await ApiEmployeeService.getManualWorkdateTypeDropdown();
    shiftList = await ApiTimeAtendanceService.getShiftDropdown();
    approveList = [
      await ApiEmployeeService.getEmployeeApprove(widget.employeeData
          .positionData.parentPositionBusinessNodeId.positionOrganizationId)
    ];
    setState(() {
      manualWorkDateTypeList;
      shiftList;
      approveList;
    });
  }

//ข้อมูลสแกนนิ้ว
  fetchDataUserInfo(String date) async {
    userInfoData = await ApiEmployeeSelfService.getUserInfoByDate(
        widget.employeeData.fingerScanId, date);
    setState(() {
      userInfoData;
      //เงื่อนไขตรวจสอบวันที่ไม่มีเวลาเข้า-ออกงาน
      if (widget.formpage == 1) {
        if (userInfoData != null) {
          String timeIn = userInfoData!.userInfoData.workTimeData.checkInTime;
          String timeOut = userInfoData!.userInfoData.workTimeData.checkOutTime;
          if ((timeIn == "" && timeOut != "") ||
              (timeIn != "" && timeOut == "") ||
              (timeIn != "" && timeOut != "")) {
            alertDialogUserInfo();
            selectedDate.text = "";
          }
        }
      }
    });
  }

  alertDialogUserInfo() {
    AwesomeDialog(
            width: 400,
            context: context,
            animType: AnimType.topSlide,
            dialogType: DialogType.error,
            title: 'เกิดข้อผิดพลาด',
            desc: 'มีการบันทึกเวลาเข้า-ออกแล้ว',
            btnOkColor: mythemecolor,
            btnOkOnPress: () {},
            btnCancelOnPress: () {})
        .show();
  }

//End Function ----------------------------------------------------
  @override
  void initState() {
    fetchData();
    switch (widget.menuType) {
      case 0: //กดจากตาราง ลืมเข้า
        typeId = "A01";
        description.text = "ลืมลงเวลาเข้างาน";
        selectedDate.text = widget.date ?? "";
        break;
      case 1: //กดจากตาราง ลืมออก
        typeId = "A02";
        description.text = "ลืมลงเวลาออกงาน";
        selectedDate.text = widget.date ?? "";
        break;
      case 2: //ลืมสแกนเข้า ณ วันปัจจุบัน
        typeId = "A01";
        description.text = "ลืมลงเวลาเข้างาน";
        selectedDate.text = DateTime.now().toString().split(" ")[0];
        break;
      case 3: //บัตรเสีย ลืมบัตร บัตรหาย
        typeId = "A03";
        description.text = "ลืมบัตร/บัตรเสีย";
        break;
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
              child: Column(
            children: [
              const Gap(5),
              Card(
                child: TextFormField(
                  controller: selectedDate,
                  autovalidateMode: AutovalidateMode.always,
                  validator: Validatorless.required('*กรุณากรอกข้อมูล'),
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: Icon(
                      Icons.calendar_today_rounded,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54),
                    ),
                  ),
                  readOnly: true,
                  onTap: widget.menuType == 0 ||
                          widget.menuType == 1 ||
                          widget.menuType == 2
                      ? null
                      : () {
                          selectvalidFromDate();
                        },
                ),
              ),
              const Gap(5),
              DropdownOrg(
                  labeltext: 'ManualWorkDate Type',
                  value: typeId,
                  items:
                      manualWorkDateTypeList?.manualWorkDateTypeData.map((e) {
                    return DropdownMenuItem<String>(
                      value: e.manualWorkDateTypeId.toString(),
                      onTap: () {
                        setState(() {
                          description.text = e.manualWorkDateTypeNameTh;
                        });
                      },
                      child: Container(
                          constraints:
                              const BoxConstraints(maxWidth: 180, minWidth: 70),
                          child: Text(
                              "${e.manualWorkDateTypeId} : ${e.manualWorkDateTypeNameTh}")),
                    );
                  }).toList(),
                  onChanged: widget.menuType == 4
                      ? (newValue) {
                          setState(() {
                            typeId = newValue.toString();
                          });
                        }
                      : null,
                  validator: null),
              const Gap(5),
              DropdownOrg(
                  labeltext: 'เลือกกะการทำงาน',
                  value: shiftId,
                  items: shiftList?.map((e) {
                    return DropdownMenuItem<String>(
                      value: e.shiftId.toString(),
                      onTap: () {
                        setState(() {
                          shiftStartTime = e.startTime;
                          shiftEndTime = e.endTime;
                        });
                      },
                      child: Container(
                          constraints:
                              const BoxConstraints(maxWidth: 270, minWidth: 70),
                          child: Text(
                              "${e.shiftName} : ${e.startTime} - ${e.endTime}")),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    shiftId = newValue.toString();
                  },
                  validator: null),
              const Gap(5),
              if (widget.formpage == 2) // form employee
                DropdownOrg(
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
              // Text("start $shiftStartTime"),
              // Text("end $shiftEndTime"),
              // Row(children: [
              //   Expanded(
              //       child: TextFormFieldGlobal(
              //           controller: scanIn,
              //           labelText: "Time Scan In",
              //           hintText: "",
              //           validatorless: null,
              //           enabled: false)),
              //   Expanded(
              //       child: TextFormFieldGlobal(
              //           controller: scanOut,
              //           labelText: "Time Scan Out",
              //           hintText: "",
              //           validatorless: null,
              //           enabled: false)),
              // ]),
            ],
          )),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
              onPressed: selectedDate.text == "" &&
                          typeId == "" &&
                          shiftStartTime == null ||
                      shiftEndTime == null
                  ? null
                  : () {
                      alertDialogInfo();
                    },
              child: SizedBox(
                width: 70,
                height: 35,
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
        ),
      ],
    );
  }
}

class TypeManualWorkdate {
  final String id;
  final String name;
  TypeManualWorkdate({
    required this.id,
    required this.name,
  });
}
