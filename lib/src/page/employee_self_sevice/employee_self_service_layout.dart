import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee_self_service/menu_menager.dart';
import 'package:hris_app_prototype/src/component/employee_self_service/menu_user.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';
import 'package:hris_app_prototype/src/services/api_employee_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeSelfServiceLayout extends StatefulWidget {
  const EmployeeSelfServiceLayout({super.key});

  @override
  State<EmployeeSelfServiceLayout> createState() =>
      _EmployeeSelfServiceLayoutState();
}

class _EmployeeSelfServiceLayoutState extends State<EmployeeSelfServiceLayout> {
  int isExpandedPage = 0;
  EmployeeDatum? employeeData;

  fetchData() async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    employeeData = await ApiEmployeeService.fetchDataEmployeeId(employeeId);
  }

  showDialogNews() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                    backgroundColor: mygreycolors,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: TitleDialog(
                      title: "ข่าวประชาสัมพันธ์",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    content:
                        SizedBox(width: 1000, height: 800, child: Container()),
                  ));
        });
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              width: 1000, // MediaQuery.of(context).size.width - 140,
              height: 800, //MediaQuery.of(context).size.height - 120,
              padding: const EdgeInsets.all(20),
              child: Container(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Close"))));
        });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   showGeneralDialog(
    //       context: context,
    //       barrierDismissible: true,
    //       barrierLabel:
    //           MaterialLocalizations.of(context).modalBarrierDismissLabel,
    //       barrierColor: Colors.black45,
    //       transitionDuration: const Duration(milliseconds: 200),
    //       pageBuilder: (BuildContext buildContext, Animation animation,
    //           Animation secondaryAnimation) {
    //         return Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 25),
    //           child: Container(
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(40),
    //                 color: mygreycolors,
    //               ),
    //               padding: const EdgeInsets.all(20),
    //               child: Center(
    //                   child: ElevatedButton(
    //                       onPressed: () {
    //                         Navigator.pop(context);
    //                       },
    //                       child: Text("Close")))),
    //         );
    //       });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Scaffold(
        backgroundColor: mygreycolors,
        body: Center(
            child: Column(
          children: [
            const Text(
              'Employee Self Service.',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const Gap(4),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Row(
                    children: [
                      Expanded(child: Container()),
                      Expanded(
                        child: SizedBox(
                          height: 35,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: isExpandedPage == 0 ? 2 : 0,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(10))),
                                backgroundColor: isExpandedPage == 0
                                    ? mythemecolor
                                    : Colors.grey[350],
                              ),
                              onPressed: () {
                                setState(() {
                                  isExpandedPage = 0;
                                });
                              },
                              child: Text(
                                "Hr.",
                                style: TextStyle(
                                    color: isExpandedPage == 0
                                        ? Colors.white
                                        : Colors.black54),
                              )),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 35,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: isExpandedPage == 1 ? 2 : 0,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(0))),
                                backgroundColor: isExpandedPage == 1
                                    ? mythemecolor
                                    : Colors.grey[350],
                              ),
                              onPressed: () {
                                setState(() {
                                  isExpandedPage = 1;
                                });
                              },
                              child: Text(
                                "User.",
                                style: TextStyle(
                                    color: isExpandedPage == 1
                                        ? Colors.white
                                        : Colors.black54),
                              )),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 35,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: isExpandedPage == 3 ? 2 : 0,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(10))),
                                backgroundColor: isExpandedPage == 3
                                    ? mythemecolor
                                    : Colors.grey[350],
                              ),
                              onPressed: () {
                                setState(() {
                                  isExpandedPage = 3;
                                });
                              },
                              child: Text(
                                "Manager.",
                                style: TextStyle(
                                    color: isExpandedPage == 3
                                        ? Colors.white
                                        : Colors.black54),
                              )),
                        ),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                )),
            if (isExpandedPage == 0)
              Expanded(flex: 19, child: Container())
            else if (isExpandedPage == 1)
              Expanded(
                  flex: 19, child: UserMenuService(employeeData: employeeData))
            else
              Expanded(
                  flex: 19,
                  child: ManagerMenuService(employeeData: employeeData))
          ],
        )),
      ),
    ));
  }
}
