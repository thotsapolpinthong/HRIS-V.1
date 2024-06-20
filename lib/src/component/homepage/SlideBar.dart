import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/homepage_bloc/homepage_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';

class SlideBar extends StatefulWidget {
  const SlideBar({super.key});

  @override
  State<SlideBar> createState() => _SlideBarState();
}

class _SlideBarState extends State<SlideBar> {
  bool isHovered = false;
  bool expandMenuPayroll = false;
  bool isHoveredTimeattendance = false;
  bool expandMenuTimeattendance = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<HomepageBloc, HomepageState>(
          builder: (context, state) {
            double width = MediaQuery.of(context).size.width;
            return SizedBox(
              width: state.expandMenu == false ? 70 : width / 6,
              child: Drawer(
                elevation: 0,
                child: Container(
                  color: mythemecolor,
                  child: BlocBuilder<HomepageBloc, HomepageState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 10),
                                child: IconButton(
                                    onPressed: () {
                                      context
                                          .read<HomepageBloc>()
                                          .add(ExpandedMenuEvent());
                                    },
                                    icon: Tooltip(
                                      message: "Show/Hide Main Menu",
                                      child: Icon(
                                        state.expandMenu == false
                                            ? Icons.menu_rounded
                                            : Icons.menu_open_rounded,
                                        color: mytextcolors,
                                        size: 30,
                                      ).animate().fade(),
                                    )),
                              ),
                              if (state.expandMenu)
                                Expanded(
                                  child: Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 20, 20, 5),
                                    child: Text(
                                      "HRIS STEC.",
                                      style: TextStyle(
                                          color: mytextcolors,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ).animate().fadeIn(delay: 100.ms),
                                  ),
                                ),
                            ],
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  DrawerTitle(
                                          color: state.pageNumber == 8
                                              ? mygreycolors
                                              : mythemecolor,
                                          icon: Icons.dashboard_rounded,
                                          iconcolor: state.pageNumber == 8
                                              ? Colors.black87
                                              : mytextcolors,
                                          title: "DASHBOARD",
                                          textColor: state.pageNumber == 8
                                              ? Colors.black87
                                              : mytextcolors,
                                          onTap: () {
                                            context
                                                .read<HomepageBloc>()
                                                .add(DashboardPageEvent());
                                          })
                                      .animate()
                                      .fadeIn(delay: 300.ms)
                                      .slideY(begin: 1, duration: 200.ms),
                                  DrawerTitle(
                                          color: state.pageNumber == 0
                                              ? mygreycolors
                                              : mythemecolor,
                                          icon: Icons.person,
                                          iconcolor: state.pageNumber == 0
                                              ? Colors.black87
                                              : mytextcolors,
                                          title: "PERSONAL",
                                          textColor: state.pageNumber == 0
                                              ? Colors.black87
                                              : mytextcolors,
                                          onTap: () {
                                            context
                                                .read<HomepageBloc>()
                                                .add(PersonPageEvent());
                                          })
                                      .animate()
                                      .fadeIn(delay: 400.ms)
                                      .slideY(begin: 1, duration: 200.ms),
                                  DrawerTitle(
                                          color: state.pageNumber == 1
                                              ? mygreycolors
                                              : mythemecolor,
                                          icon: Icons.bar_chart_rounded,
                                          iconcolor: state.pageNumber == 1
                                              ? Colors.black87
                                              : mytextcolors,
                                          title: "ORGANIZATION",
                                          textColor: state.pageNumber == 1
                                              ? Colors.black87
                                              : mytextcolors,
                                          onTap: () {
                                            context
                                                .read<HomepageBloc>()
                                                .add(OrgPageEvent());
                                          })
                                      .animate()
                                      .fadeIn(delay: 500.ms)
                                      .slideY(begin: 1, duration: 200.ms),
                                  DrawerTitle(
                                          color: state.pageNumber == 2
                                              ? mygreycolors
                                              : mythemecolor,
                                          icon: Icons.supervisor_account_rounded,
                                          iconcolor: state.pageNumber == 2
                                              ? Colors.black87
                                              : mytextcolors,
                                          title: "EMPLOYEE",
                                          textColor: state.pageNumber == 2
                                              ? Colors.black87
                                              : mytextcolors,
                                          onTap: () {
                                            context
                                                .read<HomepageBloc>()
                                                .add(EmployeePageEvent());
                                          })
                                      .animate()
                                      .fadeIn(delay: 600.ms)
                                      .slideY(begin: 1, duration: 200.ms),
                                  DrawerTitle(
                                          color: state.pageNumber == 3
                                              ? mygreycolors
                                              : mythemecolor,
                                          icon: Icons.emoji_people_rounded,
                                          iconcolor: state.pageNumber == 3
                                              ? Colors.black87
                                              : mytextcolors,
                                          title: "EMPLOYEE SELF SERVICES",
                                          textColor: state.pageNumber == 3
                                              ? Colors.black87
                                              : mytextcolors,
                                          onTap: () {
                                            context
                                                .read<HomepageBloc>()
                                                .add(EssPageEvent());
                                          })
                                      .animate()
                                      .fadeIn(delay: 700.ms)
                                      .slideY(begin: 1, duration: 200.ms),
                                  // DrawerTitle(
                                  //         color: state.pageNumber == 4
                                  //             ? mygreycolors
                                  //             : mythemecolor,
                                  //         icon: Icons.badge_rounded,
                                  //         iconcolor: state.pageNumber == 4
                                  //             ? Colors.black87
                                  //             : mytextcolors,
                                  //         title: "WELFARE",
                                  //         textColor: state.pageNumber == 4
                                  //             ? Colors.black87
                                  //             : mytextcolors,
                                  //         onTap: () {
                                  //           context
                                  //               .read<HomepageBloc>()
                                  //               .add(WelfarePageEvent());
                                  //         })
                                  //     .animate()
                                  //     .fadeIn(delay: 800.ms)
                                  //     .slideY(begin: 1, duration: 200.ms),
                                  MouseRegion(
                                    onEnter: (event) {
                                      setState(() {
                                        isHovered = true;
                                      });
                                    },
                                    onExit: (event) {
                                      setState(() {
                                        isHovered = false;
                                      });
                                    },
                                    child: DrawerTitle(
                                            color:
                                                state.pageNumber > 5 &&
                                                        state.pageNumber < 6
                                                    ? mygreycolors
                                                    : isHovered ==
                                                                true ||
                                                            expandMenuPayroll ==
                                                                true
                                                        ? Colors.white
                                                        : mythemecolor,
                                            icon: Icons.attach_money_rounded,
                                            iconcolor:
                                                state
                                                                .pageNumber >
                                                            5 &&
                                                        state.pageNumber < 6
                                                    ? Colors.black87
                                                    : isHovered ==
                                                                true ||
                                                            expandMenuPayroll ==
                                                                true
                                                        ? Colors.black87
                                                        : mytextcolors,
                                            title: "PAYROLL**",
                                            textColor:
                                                state
                                                                .pageNumber >
                                                            5 &&
                                                        state.pageNumber < 6
                                                    ? Colors.black87
                                                    : isHovered ==
                                                                true ||
                                                            expandMenuPayroll ==
                                                                true
                                                        ? Colors.black87
                                                        : mytextcolors,
                                            onTap: () {
                                              setState(() {
                                                isHovered = true;
                                              });
                                            })
                                        .animate()
                                        .fadeIn(delay: 900.ms)
                                        .slideY(begin: 1, duration: 200.ms),
                                  ),
                                  DrawerTitle(
                                          color: state.pageNumber == 9
                                              ? mygreycolors
                                              : mythemecolor,
                                          icon: Icons.time_to_leave_sharp,
                                          iconcolor: state.pageNumber == 9
                                              ? Colors.black87
                                              : mytextcolors,
                                          title: "OFF-Side WORKING",
                                          textColor: state.pageNumber == 9
                                              ? Colors.black87
                                              : mytextcolors,
                                          onTap: () {
                                            context
                                                .read<HomepageBloc>()
                                                .add(TripPageEvent());
                                          })
                                      .animate()
                                      .fadeIn(delay: 1000.ms)
                                      .slideY(begin: 1, duration: 200.ms),
                                  MouseRegion(
                                    onEnter: (event) {
                                      setState(() {
                                        isHoveredTimeattendance = true;
                                      });
                                    },
                                    onExit: (event) {
                                      setState(() {
                                        isHoveredTimeattendance = false;
                                      });
                                    },
                                    child: DrawerTitle(
                                            color: state.pageNumber > 6 &&
                                                    state.pageNumber < 7
                                                ? mygreycolors
                                                : isHoveredTimeattendance ==
                                                            true ||
                                                        expandMenuTimeattendance ==
                                                            true
                                                    ? Colors.white
                                                    : mythemecolor,
                                            icon: Icons.calendar_month_rounded,
                                            iconcolor: state
                                                            .pageNumber >
                                                        6 &&
                                                    state.pageNumber < 7
                                                ? Colors.black87
                                                : isHoveredTimeattendance ==
                                                            true ||
                                                        expandMenuTimeattendance ==
                                                            true
                                                    ? Colors.black87
                                                    : mytextcolors,
                                            title: "TIME ATTENDANCE",
                                            textColor: state
                                                            .pageNumber >
                                                        6 &&
                                                    state.pageNumber < 7
                                                ? Colors.black87
                                                : isHoveredTimeattendance ==
                                                            true ||
                                                        expandMenuTimeattendance ==
                                                            true
                                                    ? Colors.black87
                                                    : mytextcolors,
                                            onTap: () {
                                              setState(() {
                                                isHoveredTimeattendance = true;
                                              });
                                            })
                                        .animate()
                                        .fadeIn(delay: 900.ms)
                                        .slideY(begin: 1, duration: 200.ms),
                                  ),

                                  DrawerTitle(
                                          color: state.pageNumber == 7
                                              ? mygreycolors
                                              : mythemecolor,
                                          icon: Icons.picture_as_pdf_rounded,
                                          iconcolor: state.pageNumber == 7
                                              ? Colors.black87
                                              : mytextcolors,
                                          title: "REPORT**",
                                          textColor: state.pageNumber == 7
                                              ? Colors.black87
                                              : mytextcolors,
                                          onTap: () {
                                            context
                                                .read<HomepageBloc>()
                                                .add(ReportPageEvent());
                                          })
                                      .animate()
                                      .fadeIn(delay: 1100.ms)
                                      .slideY(begin: 1, duration: 200.ms),
                                ],
                              ),
                            ),
                          ),
                          state.expandMenu == false
                              ? CircleAvatar(
                                  radius: 25,
                                  backgroundColor: mygreycolors,
                                  child: Text(
                                    'Hi',
                                    style: TextStyle(color: mythemecolor),
                                  ))
                              : Card(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.horizontal(
                                          right: Radius.circular(12))),
                                  color: mygreycolors,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: mythemecolor,
                                        child: const Text(
                                          'Hi',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    //  CircleAvatar(
                                    //   radius: 25,
                                    //   backgroundColor: mythemecolor,
                                    //   backgroundImage: const AssetImage("assets/profile.jpg"),
                                    //   // child: Image.asset("assets/profile.jpg"),
                                    // ),
                                    title: Text(
                                      "Thotsapol Pinthong",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    subtitle: TextThai(
                                        text: "โปรแกรมเมอร์",
                                        textStyle: TextStyle(fontSize: 13)),
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 4, 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Transform.flip(
                                      flipX: true,
                                      child: Tooltip(
                                        message: "LOGOUT",
                                        child: IconButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            icon: Icon(
                                              Icons.exit_to_app_rounded,
                                              color: mytextcolors,
                                              size: 30,
                                            )),
                                      )),
                                ),
                                const Gap(2),
                                Align(
                                    alignment: Alignment.bottomLeft,
                                    child: state.expandMenu == false
                                        ? null
                                        : Text(
                                            "LOGOUT",
                                            style: TextStyle(
                                                color: mytextcolors,
                                                fontSize: 20),
                                          ).animate().fadeIn(delay: 200.ms))
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
        if (isHovered == true || expandMenuPayroll == true) payrollSubmenu(),
        if (isHoveredTimeattendance == true || expandMenuTimeattendance == true)
          timeattendanceSubMenu()
      ],
    );
  }

  Widget payrollSubmenu() {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          expandMenuPayroll = true;
        });
      },
      onExit: (event) {
        setState(() {
          expandMenuPayroll = false;
        });
      },
      child: Card(
        margin: const EdgeInsets.all(0),
        elevation: 6,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(12))),
        child: Container(
          width: 300,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.horizontal(right: Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<HomepageBloc, HomepageState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const Gap(5),
                      const Text(
                        "Payroll Menu.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ).animate().fadeIn(),
                      const Gap(10),
                      DrawerTitleSubmenu(
                          color: state.pageNumber == 5.1
                              ? mythemecolor
                              : Colors.white,
                          textColor: state.pageNumber == 5.1
                              ? Colors.white
                              : Colors.black87,
                          title: "1. LOT MANAGEMENT",
                          onTap: () {
                            context
                                .read<HomepageBloc>()
                                .add(SubPayroll1PageEvent());
                          }),
                      DrawerTitleSubmenu(
                          color: state.pageNumber == 5.2
                              ? mythemecolor
                              : Colors.white,
                          textColor: state.pageNumber == 5.2
                              ? Colors.white
                              : Colors.black87,
                          title: "2. SEND TO PAYROLL",
                          onTap: () => context
                              .read<HomepageBloc>()
                              .add(SubPayrollPage2Event())),
                      DrawerTitleSubmenu(
                          color: Colors.white,
                          textColor: Colors.black87,
                          title: "3. ประมวลผลข้อมูลการจ่ายเงินเดือน (Payroll)",
                          onTap: () {}),
                      DrawerTitleSubmenu(
                          color: Colors.white,
                          textColor: Colors.black87,
                          title: "4. พิมพ์สลิปเงินเดือน",
                          onTap: () {}),
                      DrawerTitleSubmenu(
                          color: Colors.white,
                          textColor: Colors.black87,
                          title: "5. บันทึกข้อมูลการชำระเงินกู้ กยศ.",
                          onTap: () {}),
                      DrawerTitleSubmenu(
                          color: Colors.white,
                          textColor: Colors.black87,
                          title: "6. บันทึกการปรับอัตราเงินเดือน",
                          onTap: () {}),
                      DrawerTitleSubmenu(
                          color: Colors.white,
                          textColor: Colors.black87,
                          title: "7. สรุปการจ่ายเงินพนักงานรายบุคคล",
                          onTap: () {}),
                      DrawerTitleSubmenu(
                          color: Colors.white,
                          textColor: Colors.black87,
                          title: "8. สรุปการจ่ายเงินพนักงานรายแผนก",
                          onTap: () {}),
                      DrawerTitleSubmenu(
                          color: Colors.white,
                          textColor: Colors.black87,
                          title: "9. รายงานข้อมูลเงินเดือนพนักงาน",
                          onTap: () {}),
                      DrawerTitleSubmenu(
                          color: Colors.white,
                          textColor: Colors.black87,
                          title: "10. สรุปการจ่ายเงินเดือนพนักงาน",
                          onTap: () {}),
                      DrawerTitleSubmenu(
                          color: Colors.white,
                          textColor: Colors.black87,
                          title: "11. พิมพ์เอกสารทวิ 50",
                          onTap: () {}),
                      DrawerTitleSubmenu(
                          color: Colors.white,
                          textColor: Colors.black87,
                          title: "12. ออกใบกำกับภาษี/หนังสือรับรองเงินเดือน",
                          onTap: () {}),
                      DrawerTitleSubmenu(
                          color: Colors.white,
                          textColor: Colors.black87,
                          title:
                              "13. Export ข้อมูล ภงด.1/ ภงด.1ก. (ส่งสรรพากร)",
                          onTap: () {}),
                      DrawerTitleSubmenu(
                          color: Colors.white,
                          textColor: Colors.black87,
                          title: "14. Export ข้อมูลประกันสังคม SSO",
                          onTap: () {}),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget timeattendanceSubMenu() {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          expandMenuTimeattendance = true;
        });
      },
      onExit: (event) {
        setState(() {
          expandMenuTimeattendance = false;
        });
      },
      child: BlocBuilder<HomepageBloc, HomepageState>(
        builder: (context, state) {
          return Container(
            width: 250,
            height: MediaQuery.of(context).size.height - 500,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.horizontal(right: Radius.circular(12)),
            ),
            child: Card(
              margin: const EdgeInsets.all(0),
              elevation: 6,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(12))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Gap(5),
                      const Text(
                        "Time Attendance Menu.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ).animate().fadeIn(),
                      const Gap(10),
                      DrawerTitleSubmenu(
                          color: state.pageNumber == 6.1
                              ? mythemecolor
                              : Colors.white,
                          textColor: state.pageNumber == 6.1
                              ? Colors.white
                              : Colors.black87,
                          title: "1. บันทึกข้อมูลวันหยุดประจำปี",
                          onTap: () {
                            context
                                .read<HomepageBloc>()
                                .add(CalendarPageEvent());
                          }),
                      DrawerTitleSubmenu(
                          color: state.pageNumber == 6.2
                              ? mythemecolor
                              : Colors.white,
                          textColor: state.pageNumber == 6.2
                              ? Colors.white
                              : Colors.black87,
                          title: "2. กะการทำงาน (Shift)",
                          onTap: () {
                            context.read<HomepageBloc>().add(ShiftPageEvent());
                          }),
                      DrawerTitleSubmenu(
                          color: state.pageNumber == 6.3
                              ? mythemecolor
                              : Colors.white,
                          textColor: state.pageNumber == 6.3
                              ? Colors.white
                              : Colors.black87,
                          title: "3. บันทึกวันทำงานพิเศษ",
                          onTap: () {
                            context.read<HomepageBloc>().add(WorkSpPageEvent());
                          }),
                      DrawerTitleSubmenu(
                          color: state.pageNumber == 6.4
                              ? mythemecolor
                              : Colors.white,
                          textColor: state.pageNumber == 6.4
                              ? Colors.white
                              : Colors.black87,
                          title: "4. บันทึกพนักงานพักครึ่งชั่วโมง",
                          onTap: () {
                            context
                                .read<HomepageBloc>()
                                .add(HalfHlbPageEvent());
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DrawerTitle extends StatefulWidget {
  final Color? color;
  final Color? textColor;
  final Color? iconcolor;
  final IconData? icon;
  final String title;
  final VoidCallback onTap;
  const DrawerTitle({
    super.key,
    required this.color,
    required this.textColor,
    required this.icon,
    required this.iconcolor,
    required this.title,
    required this.onTap,
  });

  @override
  State<DrawerTitle> createState() => _DrawerTitleState();
}

class _DrawerTitleState extends State<DrawerTitle> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(onEnter: (detail) {
      setState(() {
        isHovered = true;
      });
    }, onExit: (detail) {
      setState(() {
        isHovered = false;
      });
    }, child: BlocBuilder<HomepageBloc, HomepageState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(left: 4),
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(12)),
            color: isHovered ? Colors.grey[350] : widget.color,
          ),
          child: ListTile(
            leading: Tooltip(
                message: widget.title,
                child: Icon(
                  widget.icon,
                  color: isHovered ? Colors.black87 : widget.iconcolor,
                )),
            title: state.expandMenu == false
                ? null
                : Text(
                    widget.title,
                    style: TextStyle(
                        color: isHovered ? Colors.black87 : widget.textColor),
                  ).animate().fadeIn(delay: 100.ms),
            onTap: widget.onTap,
          ),
        );
      },
    ));
  }
}

class DrawerTitleSubmenu extends StatefulWidget {
  final Color? color;
  final Color? textColor;
  final String title;
  final VoidCallback onTap;
  const DrawerTitleSubmenu({
    super.key,
    required this.color,
    required this.textColor,
    required this.title,
    required this.onTap,
  });

  @override
  State<DrawerTitleSubmenu> createState() => _DrawerTitleSubmenuState();
}

class _DrawerTitleSubmenuState extends State<DrawerTitleSubmenu> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(onEnter: (detail) {
      setState(() {
        isHovered = true;
      });
    }, onExit: (detail) {
      setState(() {
        isHovered = false;
      });
    }, child: BlocBuilder<HomepageBloc, HomepageState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(left: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isHovered ? mythemecolor : widget.color,
          ),
          child: ListTile(
            title: state.expandMenu == false
                ? null
                : TextThai(
                    text: widget.title,
                    textStyle: TextStyle(
                        color: isHovered ? Colors.white : widget.textColor,
                        fontSize: 14),
                  ).animate().fadeIn(delay: 0.2.ms),
            onTap: widget.onTap,
          ),
        );
      },
    ));
  }
}

class DrawerTitleListTA extends StatefulWidget {
  final Color color;
  const DrawerTitleListTA({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  State<DrawerTitleListTA> createState() => _DrawerTitleListTAState();
}

class _DrawerTitleListTAState extends State<DrawerTitleListTA> {
  int isHoveredList = 0;
  bool customTileExpanded = false;

  final ExpansionTileController controller = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomepageBloc, HomepageState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(left: 4),
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(12)),
            color: widget.color,
          ),
          child: ExpansionTile(
            controller: controller,
            controlAffinity: ListTileControlAffinity.leading,
            leading: Tooltip(
              message: 'TIME ATTENDANCE',
              preferBelow: false,
              child: Icon(
                Icons.calendar_month_rounded,
                color: state.pageNumber == 61 || state.pageNumber == 62
                    ? Colors.black87
                    : mygreycolors,
              ),
            ),
            title: state.expandMenu == false
                ? const Text("")
                : Text(
                    'TIME ATTENDANCE',
                    style: TextStyle(
                        color: state.pageNumber == 61 || state.pageNumber == 62
                            ? Colors.black87
                            : mytextcolors),
                  ).animate().fadeIn(delay: 100.ms),
            trailing: null,
            children: const <Widget>[],
            //   MouseRegion(
            //     onEnter: (detail) {
            //       setState(() {
            //         isHoveredList = 1;
            //       });
            //     },
            //     onExit: (detail) {
            //       setState(() {
            //         isHoveredList = 0;
            //       });
            //     },
            //     child: Padding(
            //       padding: const EdgeInsets.only(left: 20),
            //       child: Container(
            //         constraints: const BoxConstraints(maxHeight: 35),
            //         // margin: const EdgeInsets.only(left: 4),
            //         // decoration: BoxDecoration(
            //         //   borderRadius: const BorderRadius.horizontal(
            //         //       left: Radius.circular(8)),
            //         //   color: isHoveredList == 1 ? mythemecolor : mygreycolors,
            //         // ),
            //         child: ListTile(
            //           title: Tooltip(
            //             preferBelow: false,
            //             message: "บันทึกข้อมูลวันหยุดประจำปี",
            //             child: state.expandMenu == false
            //                 ? Icon(
            //                     Icons.calendar_today_rounded,
            //                     color: state.pageNumber == 61
            //                         ? mythemecolor
            //                         : Colors.black54,
            //                   )
            //                 : Text(
            //                     '-\t\tบันทึกข้อมูลวันหยุดประจำปี',
            //                     style: TextStyle(
            //                         color: isHoveredList == 1
            //                             ? mythemecolor
            //                             : state.pageNumber == 61
            //                                 ? mythemecolor
            //                                 : Colors.black87,
            //                         fontWeight: isHoveredList == 1
            //                             ? FontWeight.w500
            //                             : null),
            //                   ),
            //           ),
            //           onTap: () {
            //             context.read<HomepageBloc>().add(CalendarPageEvent());
            //             controller.expand();
            //             customTileExpanded = !customTileExpanded;
            //           },
            //         ),
            //       ),
            //     ),
            //   ),
            //   MouseRegion(
            //     onEnter: (detail) {
            //       setState(() {
            //         isHoveredList = 2;
            //       });
            //     },
            //     onExit: (detail) {
            //       setState(() {
            //         isHoveredList = 0;
            //       });
            //     },
            //     child: Padding(
            //       padding: const EdgeInsets.only(left: 20),
            //       child: ListTile(
            //         title: Tooltip(
            //           message: "กะการทำงาน (Shift)",
            //           child: state.expandMenu == false
            //               ? Icon(
            //                   Icons.watch_later_outlined,
            //                   color: state.pageNumber == 62
            //                       ? mythemecolor
            //                       : Colors.black54,
            //                 )
            //               : Text(
            //                   '-\t\tกะการทำงาน (Shift)',
            //                   style: TextStyle(
            //                       color: isHoveredList == 2
            //                           ? mythemecolor
            //                           : state.pageNumber == 62
            //                               ? mythemecolor
            //                               : Colors.black87),
            //                 ),
            //         ),
            //         onTap: () {
            //           context.read<HomepageBloc>().add(ShiftPageEvent());
            //         },
            //       ),
            //     ),
            //   ),
            // ],
          ),
        );
      },
    );
  }
}
