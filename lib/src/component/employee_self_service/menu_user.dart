// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee_self_service/user_leave_menu.dart';
import 'package:hris_app_prototype/src/component/employee_self_service/user_manual_workdate_menu.dart';
import 'package:hris_app_prototype/src/component/employee_self_service/user_ot_menu.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model/leave_quota_employee_model.dart';
import 'package:hris_app_prototype/src/model/self_service/ot/ot_time_count_model.dart';
import 'package:hris_app_prototype/src/services/api_employee_self_service.dart';
import 'package:hris_app_prototype/src/services/api_employee_service.dart';
import 'package:lottie/lottie.dart';

class UserMenuService extends StatefulWidget {
  final EmployeeDatum? employeeData;

  const UserMenuService({
    Key? key,
    required this.employeeData,
  }) : super(key: key);

  @override
  State<UserMenuService> createState() => _UserMenuServiceState();
}

class _UserMenuServiceState extends State<UserMenuService> {
  bool isLoading = false;
  //leave
  LeaveQuotaByEmployeeModel? quotaData;
  double vacationLeave = 0;
  double bussinessLeave = 0;
  double sickLeave = 0;

//ot
  OtTimeCountModel? otTimeCountData;
  double holiday = 0;
  double otNormal = 0;
  double otHoliday = 0;
  double otSpecial = 0;

  fetchData() async {
    quotaData = await ApiEmployeeService.getLeaveQuotaById(
        widget.employeeData!.employeeId);
    otTimeCountData = await ApiEmployeeSelfService.getOtTimeCount(
        widget.employeeData!.employeeId);
    if (quotaData != null) {
      for (var element in quotaData!.leaveSetupData) {
        switch (element.leaveTypeData.leaveTypeId) {
          case "L001":
            double amount = double.parse(element.leaveAmount);
            vacationLeave += amount;
            break;
          case "L002":
            double amount = double.parse(element.leaveAmount);
            bussinessLeave += amount;
            break;
          case "L003":
            double amount = double.parse(element.leaveAmount);
            sickLeave += amount;
            break;
        }
      }
    } else {}
    if (otTimeCountData != null) {
      holiday = otTimeCountData!.overTimeCountData.holidayTotalAmount;
      otNormal = otTimeCountData!.overTimeCountData.otNormalTotalAmount;
      otHoliday = otTimeCountData!.overTimeCountData.otHolidayTotalAmount;
      otSpecial = otTimeCountData!.overTimeCountData.otSpecialTotalAmount;
    } else {}
    setState(() {
      isLoading = false;
    });
  }

  showDialoge() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                    backgroundColor: mygreycolors,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: TitleDialog(
                      title: "บันทึกข้อมูลวันลา",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    content: const SizedBox(
                        width: 460, height: 360, child: Text("test")),
                  ));
        });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    isLoading = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // backgroundColor: Colors.amber,
      body: isLoading == true
          ? myLoadingScreen
          : Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Hero(
                    tag: "leave",
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      child: InkWell(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LeaveManage(
                                      employeeData: widget.employeeData,
                                      vacationLeave: vacationLeave,
                                      bussinessLeave: bussinessLeave,
                                      sickLeave: sickLeave,
                                    ))),
                        child: SizedBox(
                          width: 340,
                          height: 540,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const ListTile(
                                  title: Text("ข้อมูลบันทึกการลา"),
                                  subtitle: Text("Leave"),
                                ),
                                const Text(
                                  "Quota : รายปี",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Expanded(
                                          child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        color: mygreycolors,
                                        child: Center(
                                          child: ListTile(
                                            leading: const Icon(
                                              Icons.airplane_ticket_outlined,
                                              size: 40,
                                            ),
                                            title: const Text(
                                                "Vacation Leave.\nลาพักผ่อนประจำปี"),
                                            subtitle: Text(
                                                "คงเหลือ $vacationLeave วัน"),
                                            trailing: Icon(
                                              vacationLeave >= 1
                                                  ? Icons.check_box_rounded
                                                  : Icons
                                                      .indeterminate_check_box_rounded,
                                              color: vacationLeave >= 1
                                                  ? Colors.greenAccent
                                                  : Colors.amber,
                                              size: 40,
                                            ),
                                          ),
                                        ),
                                      )),
                                      Expanded(
                                          child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        color: mygreycolors,
                                        child: Center(
                                          child: ListTile(
                                            leading: const Icon(
                                                Icons.card_travel_rounded,
                                                size: 40),
                                            title: const Text(
                                                "Bussiness Leave\nลากิจ"),
                                            subtitle: Text(
                                                "คงเหลือ $bussinessLeave วัน"),
                                            trailing: Icon(
                                                bussinessLeave >= 1
                                                    ? Icons.check_box_rounded
                                                    : Icons
                                                        .indeterminate_check_box_rounded,
                                                color: bussinessLeave >= 1
                                                    ? Colors.greenAccent
                                                    : Colors.amber,
                                                size: 40),
                                          ),
                                        ),
                                      )),
                                      Expanded(
                                          child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        color: mygreycolors,
                                        child: Center(
                                          child: ListTile(
                                            leading: const Icon(
                                                Icons.sick_outlined,
                                                size: 40),
                                            title: const Text(
                                                "Sick Leave\nลาป่วย"),
                                            subtitle:
                                                Text("คงเหลือ $sickLeave วัน"),
                                            trailing: Icon(
                                                sickLeave >= 1
                                                    ? Icons.check_box_rounded
                                                    : Icons
                                                        .indeterminate_check_box_rounded,
                                                color: sickLeave >= 1
                                                    ? Colors.greenAccent
                                                    : Colors.amber,
                                                size: 40),
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                )),
                                // Align(
                                //     alignment: Alignment.bottomRight,
                                //     child: ElevatedButton(
                                //         onPressed: () {}, child: Text("ขอใบลาออนไลน์")))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OTManage(
                                employeeData: widget.employeeData,
                                otTimeCountData: otTimeCountData,
                              ))),
                      child: SizedBox(
                        width: 340,
                        height: 540,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const ListTile(
                                title: Text("ข้อมูลบันทึกการทำงานล่วงเวลา"),
                                subtitle: Text("OT"),
                              ),
                              const Text(
                                "OT : รายเดือน",
                                style: TextStyle(fontSize: 18),
                              ),
                              const Gap(8),
                              Expanded(
                                  child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: mygreycolors,
                                child: Center(
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.weekend_rounded,
                                      size: 34,
                                    ),
                                    title: const Text("Holiday"),
                                    subtitle: const Text("ทำงานวันหยุด"),
                                    trailing: SizedBox(
                                      child: Column(
                                        children: [
                                          Text(
                                            holiday.toStringAsFixed(2),
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: holiday == 0
                                                    ? Colors.black54
                                                    : Colors.greenAccent[700]),
                                          ),
                                          const Text(
                                            "ชั่วโมง",
                                            style: TextStyle(
                                                color: Colors.black54),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                              Expanded(
                                  child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: mygreycolors,
                                child: Center(
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.work_outline_rounded,
                                      size: 34,
                                    ),
                                    title: const Text("OT-normal"),
                                    subtitle: const Text("โอทีวันทำงาน"),
                                    trailing: SizedBox(
                                      child: Column(
                                        children: [
                                          Text(
                                            otNormal.toStringAsFixed(2),
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: otNormal == 0
                                                    ? Colors.black54
                                                    : Colors.greenAccent[700]),
                                          ),
                                          const Text(
                                            "ชั่วโมง",
                                            style: TextStyle(
                                                color: Colors.black54),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                              Expanded(
                                  child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: mygreycolors,
                                child: Center(
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.work_history_rounded,
                                      size: 34,
                                    ),
                                    title: const Text("OT-holiday"),
                                    subtitle: const Text("โอทีในวันหยุด"),
                                    trailing: SizedBox(
                                      child: Column(
                                        children: [
                                          Text(
                                            otHoliday.toStringAsFixed(2),
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: otHoliday == 0
                                                    ? Colors.black54
                                                    : Colors.greenAccent[700]),
                                          ),
                                          const Text(
                                            "ชั่วโมง",
                                            style: TextStyle(
                                                color: Colors.black54),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                              Expanded(
                                  child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: mygreycolors,
                                child: Center(
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.workspace_premium_rounded,
                                      size: 34,
                                    ),
                                    title: const Text("OT-special"),
                                    subtitle: const Text("โอทีแบบเหมา"),
                                    trailing: SizedBox(
                                      child: Column(
                                        children: [
                                          Text(
                                            otSpecial.toStringAsFixed(2),
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: otSpecial == 0
                                                    ? Colors.black54
                                                    : Colors.greenAccent[700]),
                                          ),
                                          const Text(
                                            "ชั่วโมง",
                                            style: TextStyle(
                                                color: Colors.black54),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                              // Align(
                              //     alignment: Alignment.bottomRight,
                              //     child: ElevatedButton(
                              //         onPressed: () {}, child: Text("ขอใบลาออนไลน์")))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Hero(
                    tag: "time",
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      child: InkWell(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ManualWorkDateManage(
                                      employeeData: widget.employeeData,
                                    ))),
                        child: SizedBox(
                          width: 340,
                          height: 540,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text("ข้อมูลบันทึกเวลาเข้า ออกงาน"),
                                  subtitle: Text("Manual work date"),
                                ),
                                Expanded(
                                  child: Lottie.asset(
                                      'assets/manualworkdate.json',
                                      frameRate: FrameRate(59)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
    ));
  }
}
