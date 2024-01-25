import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee_self_service/menu_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeSelfServiceLayout extends StatefulWidget {
  const EmployeeSelfServiceLayout({super.key});

  @override
  State<EmployeeSelfServiceLayout> createState() =>
      _EmployeeSelfServiceLayoutState();
}

class _EmployeeSelfServiceLayoutState extends State<EmployeeSelfServiceLayout> {
  int isExpandedPage = 0;

  fetchData() async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
  }

  @override
  void initState() {
    fetchData();
    super.initState();
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
              const Expanded(flex: 19, child: UserMenuService())
            else
              Expanded(flex: 19, child: Container())
          ],
        )),
      ),
    ));
  }
}
