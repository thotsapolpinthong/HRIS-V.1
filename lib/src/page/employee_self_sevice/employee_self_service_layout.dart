import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee_self_service/menu_menager.dart';
import 'package:hris_app_prototype/src/component/employee_self_service/menu_user.dart';
import 'package:hris_app_prototype/src/model/Login/login_model.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';
import 'package:hris_app_prototype/src/services/api_employee_service.dart';
import 'package:hris_app_prototype/src/services/api_role_permission.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeSelfServiceLayout extends StatefulWidget {
  const EmployeeSelfServiceLayout({super.key});

  @override
  State<EmployeeSelfServiceLayout> createState() =>
      _EmployeeSelfServiceLayoutState();
}

class _EmployeeSelfServiceLayoutState extends State<EmployeeSelfServiceLayout> {
  int isExpandedPage = 1;
  EmployeeDatum? _employeeData;
  LoginData? _loginData;

  fetchDataLogin() async {
    _loginData = await ApiRolesService.getUserData();
    setState(() {
      if (_loginData != null) {
        _loginData;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: myredcolors,
            content: const Text("Load Role Permissions Fail")));
      }
    });
  }

  fetchData() async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    _employeeData = await ApiEmployeeService.fetchDataEmployeeId(employeeId);

    setState(() {
      _employeeData;
    });
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
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Close")));
        });
  }

  @override
  void initState() {
    fetchDataLogin();
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
        body: _employeeData == null
            ? myLoadingScreen
            : Center(
                child: Column(
                children: [
                  const Text(
                    'Employee Self Service.',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Gap(4),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: Row(
                          children: [
                            Expanded(child: Container()),
                            if (_loginData?.role.roleId == 'R000000000' ||
                                _loginData?.role.roleId == 'R000000003' ||
                                _loginData?.role.roleId == 'R000000004')
                              Expanded(
                                child: SizedBox(
                                  height: 35,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: isExpandedPage == 0 ? 2 : 0,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.horizontal(
                                                    right: Radius.circular(10),
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
                            const Gap(5),
                            Expanded(
                              child: SizedBox(
                                height: 35,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: isExpandedPage == 1 ? 2 : 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.horizontal(
                                              right: Radius.circular(_loginData
                                                              ?.role.roleId ==
                                                          'R000000000' ||
                                                      _loginData?.role.roleId ==
                                                          'R000000002' ||
                                                      _loginData?.role.roleId ==
                                                          'R000000003' ||
                                                      _loginData?.role.roleId ==
                                                          'R000000005'
                                                  ? 0
                                                  : 10),
                                              left: Radius.circular(10))),
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
                            if (_loginData?.role.roleId == 'R000000000' ||
                                _loginData?.role.roleId == 'R000000002' ||
                                _loginData?.role.roleId == 'R000000003' ||
                                _loginData?.role.roleId == 'R000000005')
                              Expanded(
                                child: SizedBox(
                                  height: 35,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: isExpandedPage == 3 ? 2 : 0,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.horizontal(
                                                    right:
                                                        Radius.circular(10))),
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
                        flex: 19,
                        child: UserMenuService(employeeData: _employeeData))
                  else
                    Expanded(
                        flex: 19,
                        child: ManagerMenuService(employeeData: _employeeData))
                ],
              )),
      ),
    ));
  }
}
