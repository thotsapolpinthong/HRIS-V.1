// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
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
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
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
                          margin: const EdgeInsets.fromLTRB(0, 20, 20, 5),
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
                        DrawerTitle(
                                color: state.pageNumber == 5
                                    ? mygreycolors
                                    : mythemecolor,
                                icon: Icons.attach_money_rounded,
                                iconcolor: state.pageNumber == 5
                                    ? Colors.black87
                                    : mytextcolors,
                                title: "PAYROLL**",
                                textColor: state.pageNumber == 5
                                    ? Colors.black87
                                    : mytextcolors,
                                onTap: () {
                                  context
                                      .read<HomepageBloc>()
                                      .add(PayrollPageEvent());
                                })
                            .animate()
                            .fadeIn(delay: 900.ms)
                            .slideY(begin: 1, duration: 200.ms),
                        DrawerTitle(
                                color: state.pageNumber == 6
                                    ? mygreycolors
                                    : mythemecolor,
                                icon: Icons.time_to_leave_sharp,
                                iconcolor: state.pageNumber == 6
                                    ? Colors.black87
                                    : mytextcolors,
                                title: "OFF-Side WORKING",
                                textColor: state.pageNumber == 6
                                    ? Colors.black87
                                    : mytextcolors,
                                onTap: () {
                                  context
                                      .read<HomepageBloc>()
                                      .add(TimePageEvent());
                                })
                            .animate()
                            .fadeIn(delay: 1000.ms)
                            .slideY(begin: 1, duration: 200.ms),
                        const DrawerTitleListTA()
                            .animate()
                            .fadeIn(delay: 1000.ms)
                            .slideY(begin: 1, duration: 200.ms),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                                  onPressed: () => Navigator.pop(context),
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
                                      color: mytextcolors, fontSize: 20),
                                ).animate().fadeIn(delay: 200.ms))
                    ],
                  ),
                )
              ],
            );
          },
        ),
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

class DrawerTitleListTA extends StatefulWidget {
  // final Color? color;
  // final Color? textColor;
  // final Color? iconcolor;
  // final IconData? icon;
  // final String title;
  //final VoidCallback onTap;
  const DrawerTitleListTA({
    super.key,
    // required this.color,
    // required this.textColor,
    // required this.icon,
    // required this.iconcolor,
    // required this.title,
    // required this.onTap,
  });

  @override
  State<DrawerTitleListTA> createState() => _DrawerTitleListTAState();
}

class _DrawerTitleListTAState extends State<DrawerTitleListTA> {
  bool isHovered = false;
  int isHoveredList = 0;
  bool customTileExpanded = false;
  final ExpansionTileController controller = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomepageBloc, HomepageState>(
      builder: (context, state) {
        return MouseRegion(
          onEnter: (detail) {
            setState(() {
              isHovered = true;
              controller.expand();
            });
          },
          onExit: (detail) {
            setState(() {
              isHovered = false;
              if (state.pageNumber != 61 || state.pageNumber != 62) {
                controller.collapse();
              } else {
                controller.expand();
              }
            });
          },
          child: Container(
            margin: const EdgeInsets.only(left: 4),
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(12)),
              color: isHovered
                  ? Colors.grey[350]
                  : state.pageNumber == 61 || state.pageNumber == 62
                      ? mygreycolors
                      : mythemecolor,
            ),
            child: ExpansionTile(
              controller: controller,
              controlAffinity: ListTileControlAffinity.leading,
              leading: Tooltip(
                message: 'TIME ATTENDANCE',
                preferBelow: false,
                child: Icon(
                  Icons.calendar_month_rounded,
                  color: isHovered
                      ? Colors.black87
                      : state.pageNumber == 61 || state.pageNumber == 62
                          ? Colors.black87
                          : mygreycolors,
                ),
              ),
              title: state.expandMenu == false
                  ? const Text("")
                  : Text(
                      'TIME ATTENDANCE',
                      style: TextStyle(
                          color: isHovered
                              ? Colors.black87
                              : state.pageNumber == 61 || state.pageNumber == 62
                                  ? Colors.black87
                                  : mytextcolors),
                    ).animate().fadeIn(delay: 100.ms),
              trailing: null,
              children: <Widget>[
                MouseRegion(
                  onEnter: (detail) {
                    setState(() {
                      isHoveredList = 1;
                    });
                  },
                  onExit: (detail) {
                    setState(() {
                      isHoveredList = 0;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 35),
                      // margin: const EdgeInsets.only(left: 4),
                      // decoration: BoxDecoration(
                      //   borderRadius: const BorderRadius.horizontal(
                      //       left: Radius.circular(8)),
                      //   color: isHoveredList == 1 ? mythemecolor : mygreycolors,
                      // ),
                      child: ListTile(
                        title: Tooltip(
                          preferBelow: false,
                          message: "บันทึกข้อมูลวันหยุดประจำปี",
                          child: state.expandMenu == false
                              ? Icon(
                                  Icons.calendar_today_rounded,
                                  color: state.pageNumber == 61
                                      ? mythemecolor
                                      : Colors.black54,
                                )
                              : Text(
                                  '-\t\tบันทึกข้อมูลวันหยุดประจำปี',
                                  style: TextStyle(
                                      color: isHoveredList == 1
                                          ? mythemecolor
                                          : state.pageNumber == 61
                                              ? mythemecolor
                                              : Colors.black87,
                                      fontWeight: isHoveredList == 1
                                          ? FontWeight.w500
                                          : null),
                                ),
                        ),
                        onTap: () {
                          context.read<HomepageBloc>().add(CalendarPageEvent());
                          controller.expand();
                          customTileExpanded = !customTileExpanded;
                        },
                      ),
                    ),
                  ),
                ),
                MouseRegion(
                  onEnter: (detail) {
                    setState(() {
                      isHoveredList = 2;
                    });
                  },
                  onExit: (detail) {
                    setState(() {
                      isHoveredList = 0;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ListTile(
                      title: Tooltip(
                        message: "กะการทำงาน (Shift)",
                        child: state.expandMenu == false
                            ? Icon(
                                Icons.watch_later_outlined,
                                color: state.pageNumber == 62
                                    ? mythemecolor
                                    : Colors.black54,
                              )
                            : Text(
                                '-\t\tกะการทำงาน (Shift)',
                                style: TextStyle(
                                    color: isHoveredList == 2
                                        ? mythemecolor
                                        : state.pageNumber == 62
                                            ? mythemecolor
                                            : Colors.black87),
                              ),
                      ),
                      onTap: () {
                        context.read<HomepageBloc>().add(ShiftPageEvent());
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
