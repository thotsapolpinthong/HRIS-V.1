// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_app_prototype/src/bloc/homepage_bloc/homepage_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee/datatable_employee.dart';
import 'package:hris_app_prototype/src/component/homepage/SlideBar.dart';
import 'package:hris_app_prototype/src/component/payroll/1_lot/lot_management_menu.dart';
import 'package:hris_app_prototype/src/component/payroll/2_to_payroll/to_payroll_menu.dart';
import 'package:hris_app_prototype/src/component/payroll/3_salary/salary_management_menu.dart';
import 'package:hris_app_prototype/src/component/payroll/4_tax_deduction/tax_deduction_menu.dart';
import 'package:hris_app_prototype/src/component/payroll/5_payroll/payroll_menu.dart';
import 'package:hris_app_prototype/src/component/time_attendance/half_break/lunch_break_table.dart';
import 'package:hris_app_prototype/src/component/time_attendance/workdate_spacial/workdate_sp_table.dart';
import 'package:hris_app_prototype/src/page/dashboard.dart';
import 'package:hris_app_prototype/src/page/employee_self_sevice/employee_self_service_layout.dart';
import 'package:hris_app_prototype/src/page/organization/organization_layout.dart';
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
  Widget mainMenuPage(double page) {
    switch (page) {
      case 0:
        return const PersonalPage();
      case 1:
        return const OrganizationLayout();
      case 2:
        return const DatatableEmployee(
          isSelected: false,
          isSelectedOne: false,
        );
      case 3:
        return const EmployeeSelfServiceLayout();
      case 4: //welfare
        return Container();
      case >= 5 && < 6:
        return payrollPage(page);
      case >= 6 && < 7:
        return timeAttendancePage(page);
      case 7: // report
        return Container();
      case 8:
        return const MyDashboard();
      case 9:
        return const OffSideLayout();
      default:
        throw Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SizedBox(width: 260, child: SlideBar()),
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
                  Expanded(
                      flex: state.expandMenu == false ? 19 : 5,
                      child: MenuExpand(
                        child: Stack(children: [
                          mainMenuPage(state.pageNumber),
                          // Center(
                          //   child: Container(
                          //     width: 100,
                          //     height: 100,
                          //     child: CircularProgressIndicator(
                          //       color: mythemecolor,
                          //       strokeWidth: 10,
                          //       strokeCap: StrokeCap.round,
                          //     ),
                          //   ),
                          // )
                        ]),
                      )),
                  // if (state.pageNumber == 8)
                  //   Expanded(
                  //       flex: state.expandMenu == false ? 19 : 5,
                  //       child: const MenuExpand(
                  //         child: MyDashboard(),
                  //       )),
                  // if (state.pageNumber == 0)
                  //   Expanded(
                  //     flex: state.expandMenu == false ? 19 : 5,
                  //     child: const MenuExpand(
                  //       child: PersonalPage(),
                  //     ),
                  //   ),
                  // if (state.pageNumber == 1)
                  //   Expanded(
                  //     flex: state.expandMenu == false ? 19 : 5,
                  //     child: const MenuExpand(
                  //       child: OrganizationLayout(),
                  //     ),
                  //   ),
                  // if (state.pageNumber == 2)
                  //   Expanded(
                  //     flex: state.expandMenu == false ? 19 : 5,
                  //     child: const MenuExpand(
                  //       child: DatatableEmployee(
                  //         isSelected: false,
                  //         isSelectedOne: false,
                  //       ),
                  //     ),
                  //   ),
                  // if (state.pageNumber == 3)
                  //   Expanded(
                  //     flex: state.expandMenu == false ? 19 : 5,
                  //     child: const MenuExpand(
                  //       child: EmployeeSelfServiceLayout(),
                  //     ),
                  //   ),
                  // if (state.pageNumber == 6)
                  //   Expanded(
                  //     flex: state.expandMenu == false ? 19 : 5,
                  //     child: const MenuExpand(
                  //       child: OffSideLayout(),
                  //     ),
                  //   ),
                  // if (state.pageNumber == 6.1)
                  //   Expanded(
                  //     flex: state.expandMenu == false ? 19 : 5,
                  //     child: const MenuExpand(
                  //       child: TimeAttendancePageLayout(
                  //         dashboard: false,
                  //       ),
                  //     ),
                  //   ),
                  // if (state.pageNumber == 6.2)
                  //   Expanded(
                  //     flex: state.expandMenu == false ? 19 : 5,
                  //     child: const MenuExpand(
                  //       child: ShiftLayout(),
                  //     ),
                  //   ),
                  // if (state.pageNumber == 6.3)
                  //   Expanded(
                  //     flex: state.expandMenu == false ? 19 : 5,
                  //     child: const MenuExpand(
                  //       child: WorkSPTable(),
                  //     ),
                  //   ),
                  // if (state.pageNumber == 6.4)
                  //   Expanded(
                  //     flex: state.expandMenu == false ? 19 : 5,
                  //     child: const MenuExpand(
                  //       child: LunchBreakTable(),
                  //     ),
                  //   ),
                  // if (state.pageNumber >= 5 && state.pageNumber < 6)
                  //   Expanded(
                  //     flex: state.expandMenu == false ? 19 : 5,
                  //     child: MenuExpand(
                  //       child: payrollPage(state.pageNumber),
                  //     ),
                  //   ),
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

  Widget payrollPage(double page) {
    switch (page) {
      case 5.1:
        return const LotManagement();
      case 5.2:
        return const ToPayroll();
      case 5.3:
        return const SalaryManagement();
      case 5.4:
        return const TaxDeductionManagement();
      case 5.5:
        return const Payrollmanagement();
      default:
        throw Container();
    }
  }

  Widget timeAttendancePage(double page) {
    switch (page) {
      case 6.1:
        return const TimeAttendancePageLayout(
          dashboard: false,
        );
      case 6.2:
        return const ShiftLayout();
      case 6.3:
        return const WorkSPTable();
      case 6.4:
        return const LunchBreakTable();
      default:
        throw Container();
    }
  }
}

class MenuExpand extends StatelessWidget {
  final Widget child;
  const MenuExpand({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: mygreycolors,
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black45,
                  offset: Offset(10.0, 10.0),
                  blurRadius: 10,
                  spreadRadius: 2.0),
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0,
                  spreadRadius: 0.0)
            ]),
        child: child,
      ),
    );
  }
}
