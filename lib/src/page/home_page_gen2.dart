// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/homepage_bloc/homepage_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee/datatable_employee.dart';
import 'package:hris_app_prototype/src/component/homepage/SlideBar.dart';
import 'package:hris_app_prototype/src/component/payroll/1_lot/lot_management_menu.dart';
import 'package:hris_app_prototype/src/component/payroll/2_to_payroll/to_payroll_menu.dart';
import 'package:hris_app_prototype/src/component/payroll/3_salary/salary_management_menu.dart';
import 'package:hris_app_prototype/src/component/payroll/4_tax_deduction/tax_deduction_menu.dart';
import 'package:hris_app_prototype/src/component/payroll/5_payroll/payroll_menu.dart';
import 'package:hris_app_prototype/src/component/personal/datatable_personal.dart';
import 'package:hris_app_prototype/src/component/time_attendance/half_break/lunch_break_table.dart';
import 'package:hris_app_prototype/src/component/time_attendance/workdate_spacial/workdate_sp_table.dart';
import 'package:hris_app_prototype/src/page/dashboard.dart';
import 'package:hris_app_prototype/src/page/employee_self_sevice/employee_self_service_layout.dart';
import 'package:hris_app_prototype/src/page/organization/organization_layout.dart';
import 'package:hris_app_prototype/src/page/role_permission/role_permission_layout.dart';
import 'package:hris_app_prototype/src/component/time_attendance/shift/shift_layout.dart';
import 'package:hris_app_prototype/src/component/time_attendance/time_attendance_layout.dart';
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
        return const DataTablePerson(
          employee: false,
        );
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
      case 10:
        return RolePermissionLayout();
      default:
        throw Container();
    }
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SizedBox(width: 260, child: SlideBar()),
      backgroundColor: mythemecolor,
      body: BlocBuilder<HomepageBloc, HomepageState>(
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
                      child: Column(
                        children: [
                          Gap(10),
                          WindowTitleBarBox(
                            child: Row(
                              children: [
                                Expanded(child: MoveWindow()),
                                MinimizeWindowButton(
                                    colors: WindowButtonColors(
                                        iconNormal: mytextcolors)),
                                MaximizeWindowButton(
                                  colors: WindowButtonColors(
                                      iconNormal: mytextcolors),
                                  animate: true,
                                ),
                                CloseWindowButton(
                                    colors: WindowButtonColors(
                                        iconNormal: mytextcolors,
                                        mouseOver: myredcolors))
                              ],
                            ),
                          ),
                          Expanded(
                            child: MenuExpand(
                              child: mainMenuPage(state.pageNumber),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              //Side Menu
              const SlideBar(),
            ],
          );
        },
      ),
    );
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
      padding: const EdgeInsets.fromLTRB(0, 0, 5, 5),
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
