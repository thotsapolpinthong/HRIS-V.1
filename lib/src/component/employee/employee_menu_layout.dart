import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/employee/menu/leave/menu_leave.dart';
import 'package:hris_app_prototype/src/component/employee/menu/ot/menu_ot.dart';
import 'package:hris_app_prototype/src/component/homepage/SlideBar.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';

class EmployeeMenuLayout extends StatefulWidget {
  final EmployeeDatum employeeData;
  const EmployeeMenuLayout({super.key, required this.employeeData});

  @override
  State<EmployeeMenuLayout> createState() => _EmployeeMenuLayoutState();
}

class _EmployeeMenuLayoutState extends State<EmployeeMenuLayout> {
  int pageNumber = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Scaffold(
        body: Row(
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(5),
                    const Text(
                      " MENU.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    const Gap(15),
                    DrawerTitle(
                      color:
                          pageNumber == 0 ? Colors.blueGrey[200] : Colors.white,
                      textColor: Colors.black,
                      icon: Icons.edit,
                      iconcolor: Colors.black,
                      title: "ปรับตำแหน่ง (Promote)",
                      onTap: () {
                        setState(() {
                          pageNumber = 0;
                        });
                      },
                    ),
                    const Gap(5),
                    DrawerTitle(
                      color:
                          pageNumber == 1 ? Colors.blueGrey[200] : Colors.white,
                      textColor: Colors.black,
                      icon: Icons.edit,
                      iconcolor: Colors.black,
                      title: "ย้ายตำแหน่งงาน (Transfer)",
                      onTap: () {
                        setState(() {
                          pageNumber = 1;
                        });
                      },
                    ),
                    const Gap(5),
                    DrawerTitle(
                      color:
                          pageNumber == 2 ? Colors.blueGrey[200] : Colors.white,
                      textColor: Colors.black,
                      icon: Icons.edit,
                      iconcolor: Colors.black,
                      title: "สิ้นสุดการเป็นพนักงาน",
                      onTap: () {
                        setState(() {
                          pageNumber = 2;
                        });
                      },
                    ),
                    const Gap(5),
                    DrawerTitle(
                      color:
                          pageNumber == 3 ? Colors.blueGrey[200] : Colors.white,
                      textColor: Colors.black,
                      icon: Icons.edit,
                      iconcolor: Colors.black,
                      title: "บันทึกการทำงานล่วงเวลา",
                      onTap: () {
                        setState(() {
                          pageNumber = 3;
                        });
                      },
                    ),
                    const Gap(5),
                    DrawerTitle(
                      color:
                          pageNumber == 4 ? Colors.blueGrey[200] : Colors.white,
                      textColor: Colors.black,
                      icon: Icons.edit,
                      iconcolor: Colors.black,
                      title: "บันทึกการลา",
                      onTap: () {
                        setState(() {
                          pageNumber = 4;
                        });
                      },
                    ),
                    const Gap(5),
                    DrawerTitle(
                      color:
                          pageNumber == 5 ? Colors.blueGrey[200] : Colors.white,
                      textColor: Colors.black,
                      icon: Icons.edit,
                      iconcolor: Colors.black,
                      title: "Manual Workdate",
                      onTap: () {
                        setState(() {
                          pageNumber = 5;
                        });
                      },
                    ),
                    const Gap(5),
                    DrawerTitle(
                      color:
                          pageNumber == 6 ? Colors.blueGrey[200] : Colors.white,
                      textColor: Colors.black,
                      icon: Icons.edit,
                      iconcolor: Colors.black,
                      title: "การประเมิน",
                      onTap: () {
                        setState(() {
                          pageNumber = 6;
                        });
                      },
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Card(
                          color: Colors.blueGrey[200],
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: SingleChildScrollView(
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Gap(10),
                                      const Text(
                                        "Employee Info",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // const Icon(
                                      //   CupertinoIcons.person_alt_circle,
                                      //   size: 60,
                                      // ),
                                      const Gap(6),
                                      Text(
                                          "รหัสพนักงาน :  ${widget.employeeData.employeeId}"),
                                      Text(
                                          "ชื่อ : ${widget.employeeData.personData.titleName.titleNameTh} ${widget.employeeData.personData.fisrtNameTh} ${widget.employeeData.personData.lastNameTh}"),
                                      Text(
                                          "ประเภท : ${widget.employeeData.staffTypeData.description}"),
                                      Text(
                                          "แผนก : ${widget.employeeData.positionData.organizationData.departMentData.deptNameEn}"),
                                      Text(
                                          "ตำแหน่ง : ${widget.employeeData.positionData.positionData.positionNameTh}"),
                                      Text(
                                          "กะการทำงาน : ${widget.employeeData.shiftData.shiftName} \n${widget.employeeData.shiftData.startTime} - ${widget.employeeData.shiftData.endTime}"), //
                                    ],
                                  ),
                                ),
                                const Positioned(
                                  left: 145,
                                  child: Icon(
                                    CupertinoIcons.person_alt_circle,
                                    size: 120,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
                    const Gap(8)
                  ],
                )),
            if (pageNumber == 0)
              Expanded(flex: 4, child: Text("$pageNumber"))
            else if (pageNumber == 1)
              Expanded(flex: 4, child: Text("$pageNumber"))
            else if (pageNumber == 2)
              Expanded(flex: 4, child: Text("$pageNumber"))
            else if (pageNumber == 3)
              Expanded(
                  flex: 4,
                  child: EmployeeOtMenu(employeeData: widget.employeeData))
            else if (pageNumber == 4)
              Expanded(
                  flex: 4,
                  child: EmployeeLeaveMenu(employeeData: widget.employeeData))
            else if (pageNumber == 5)
              Expanded(flex: 4, child: Text("$pageNumber"))
            else
              Expanded(flex: 4, child: Text("$pageNumber")),
            // Expanded(
            //     flex: 4,
            //     child: Padding(
            //       padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
            //       child: Container(
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(20),
            //             color: Colors.white),
            //       ),
            //     ))
          ],
        ),
      ),
    ));
  }
}
