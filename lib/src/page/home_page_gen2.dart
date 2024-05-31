import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_app_prototype/src/bloc/homepage_bloc/homepage_bloc.dart';
import 'package:hris_app_prototype/src/component/payroll/lot_management.dart';
import 'package:hris_app_prototype/src/page/employee_self_sevice/employee_self_service_layout.dart';
import 'package:hris_app_prototype/src/page/organization/organization_layout.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee/datatable_employee.dart';
import 'package:hris_app_prototype/src/component/homepage/SlideBar.dart';
import 'package:hris_app_prototype/src/page/dashboard.dart';
import 'package:hris_app_prototype/src/page/personal/personal_page.dart';
import 'package:hris_app_prototype/src/page/timeattendance/shift_layout.dart';
import 'package:hris_app_prototype/src/page/timeattendance/time_attendance_layout.dart';
import 'package:hris_app_prototype/src/page/trip/off-side_layout.dart';

class MyHomepage extends StatefulWidget {
  const MyHomepage({super.key});

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SizedBox(width: 260, child: SlideBar()),
      backgroundColor: mythemecolor,
      body: SafeArea(child: BlocBuilder<HomepageBloc, HomepageState>(
        builder: (context, state) {
          double width = MediaQuery.of(context).size.width;
          return Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Area Side Menu
                  Container(
                    width: state.expandMenu == false ? 70 : width / 6,
                  ),
                  //Main Body
                  if (state.pageNumber == 8)
                    Expanded(
                        flex: state.expandMenu == false ? 19 : 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                                color: mygreycolors,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(40))),
                            child: const MyDashboard(),
                          ),
                        )),
                  if (state.pageNumber == 0)
                    Expanded(
                        flex: state.expandMenu == false ? 19 : 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                                color: mygreycolors,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(40))),
                            child: const PersonalPage(),
                          ),
                        )),
                  if (state.pageNumber == 1)
                    Expanded(
                        flex: state.expandMenu == false ? 19 : 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: mygreycolors,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(40))),
                            child: const OrganizationLayout(),
                          ),
                        )),
                  if (state.pageNumber == 2)
                    Expanded(
                        flex: state.expandMenu == false ? 19 : 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                                color: mygreycolors,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(40))),
                            child: const DatatableEmployee(
                              isSelected: false,
                              isSelectedOne: false,
                            ),
                          ),
                        )),
                  if (state.pageNumber == 3)
                    Expanded(
                        flex: state.expandMenu == false ? 19 : 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                                color: mygreycolors,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(40))),
                            child: const EmployeeSelfServiceLayout(),
                          ),
                        )),
                  if (state.pageNumber == 6)
                    Expanded(
                        flex: state.expandMenu == false ? 19 : 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                                color: mygreycolors,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(40))),
                            child: const OffSideLayout(),
                          ),
                        )),
                  if (state.pageNumber == 61)
                    Expanded(
                        flex: state.expandMenu == false ? 19 : 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                                color: mygreycolors,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(40))),
                            child: const TimeAttendancePageLayout(
                              dashboard: false,
                            ),
                          ),
                        )),
                  if (state.pageNumber == 62)
                    Expanded(
                        flex: state.expandMenu == false ? 19 : 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                                color: mygreycolors,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(40))),
                            child: const ShiftLayout(),
                          ),
                        )),
                  if (state.pageNumber == 5.1)
                    Expanded(
                        flex: state.expandMenu == false ? 19 : 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                                color: mygreycolors,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(40))),
                            child: const LotManagement(),
                          ),
                        )),
                ],
              ),
              //Side Menu
              const SlideBar(),
            ],
          );
        },
      )),
    );
  }
}
