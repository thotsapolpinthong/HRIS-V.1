// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee_self_service/user_leave_menu.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_by_id_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model.dart/leave_quota_employee_model.dart';
import 'package:hris_app_prototype/src/services/api_employee_service.dart';

class UserMenuService extends StatefulWidget {
  final EmployeeIdModel? employeeData;

  const UserMenuService({
    Key? key,
    required this.employeeData,
  }) : super(key: key);

  @override
  State<UserMenuService> createState() => _UserMenuServiceState();
}

class _UserMenuServiceState extends State<UserMenuService> {
  bool isLoading = false;
  LeaveQuotaByEmployeeModel? quotaData;
  double vacationLeave = 0;
  double bussinessLeave = 0;
  double sickLeave = 0;

  fetchData() async {
    quotaData = await ApiEmployeeService.getLeaveQuotaById(
        widget.employeeData!.employeeData[0].employeeId);
    if (quotaData != null) {
      for (var element in quotaData!.leaveSetupData) {
        // if (element.leaveTypeData.leaveTypeId == "L001") {
        //   double amount = double.parse(element.leaveAmount);
        //   vacationLeave += amount;
        // } else if (element.leaveTypeData.leaveTypeId == "L002") {
        //   bussinessLeave = double.parse(element.leaveAmount);
        // } else {}

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
      setState(() {
        vacationLeave;
        bussinessLeave;
        quotaData;
        isLoading = false;
      });
    } else {}
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
                  Hero(
                    tag: "ot",
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      child: InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const OTManage())),
                        child: const SizedBox(
                          width: 340,
                          height: 540,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text("ข้อมูลบันทึกการทำงานล่วงเวลา"),
                                  subtitle: Text("OT"),
                                ),
                                Expanded(child: Text("test")),
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
                  Hero(
                    tag: "time",
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      child: InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const TimeStampManage())),
                        child: const SizedBox(
                          width: 340,
                          height: 540,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text("ข้อมูลบันทึกเวลาเข้า ออกงาน"),
                                  subtitle: Text("Time Stamp"),
                                ),
                                Expanded(child: Text("test")),
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
                ]),
              ),
            ),
    ));
  }
}

class OTManage extends StatefulWidget {
  const OTManage({super.key});

  @override
  State<OTManage> createState() => _OTManageState();
}

class _OTManageState extends State<OTManage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ข้อมูลบันทึกการทำงานล่วงเวลา"),
      ),
      body: Hero(
          tag: "ot",
          child: Column(
            children: [
              Container(
                color: Colors.amber,
              ),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("pop"))
            ],
          )),
    );
  }
}

class TimeStampManage extends StatefulWidget {
  const TimeStampManage({super.key});

  @override
  State<TimeStampManage> createState() => _TimeStampManageState();
}

class _TimeStampManageState extends State<TimeStampManage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ข้อมูลบันทึกเวลาเข้า ออกงาน"),
      ),
      body: Hero(
          tag: "time",
          child: Column(
            children: [
              Container(
                color: Colors.amber,
              ),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("pop"))
            ],
          )),
    );
  }
}
