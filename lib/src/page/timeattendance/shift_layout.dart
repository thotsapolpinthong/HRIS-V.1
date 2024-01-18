import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/timeattendance_bloc/timeattendance_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee/datatable_employee.dart';
import 'package:hris_app_prototype/src/component/time_attendance/shift/create_update_shift.dart';
import 'package:hris_app_prototype/src/component/time_attendance/shift/shift_control/datatable_shift_control.dart';
import 'package:hris_app_prototype/src/component/time_attendance/shift/shift_table.dart';

class ShiftLayout extends StatefulWidget {
  const ShiftLayout({super.key});

  @override
  State<ShiftLayout> createState() => _ShiftLayoutState();
}

class _ShiftLayoutState extends State<ShiftLayout> {
  int isExpandedPage = 0;

  @override
  void initState() {
    super.initState();
  }

  void showDialogCreate() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: mygreycolors,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: isExpandedPage == 1
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('เพิ่มกะการทำงาน (Create Shift.)'),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            child: const Text(
                              'X',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    )
                  : null,
              content: isExpandedPage == 1
                  ? const SizedBox(
                      width: 560,
                      height: 360,
                      child: CreateUpdateShift(onEdit: false))
                  : SafeArea(
                      child: SizedBox(
                          width: 1200,
                          height: MediaQuery.of(context).size.height - 20,
                          child: const DatatableEmployee(
                            isSelected: true,
                          )),
                    ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeattendanceBloc, TimeattendanceState>(
      builder: (context, state) {
        if (state.isDataLoading == false) {}
        return SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Scaffold(
            floatingActionButton: isExpandedPage == 0
                ? null
                // Tooltip(
                //     message: 'เลือกพนักงาน',
                //     child: SizedBox(
                //       width: 50,
                //       height: 50,
                //       child: ElevatedButton(
                //           style: ElevatedButton.styleFrom(
                //               padding: const EdgeInsets.all(1),
                //               shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(12))),
                //           onPressed: () {
                //             showDialogCreate();
                //           },
                //           child: const Icon(Icons.add_rounded)),
                //     ).animate().shake(),
                //   )
                : SizedBox(
                    width: 50,
                    height: 50,
                    child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            onPressed: () {
                              showDialogCreate();
                            },
                            child: const Icon(Icons.more_time_rounded))
                        .animate()
                        .shake(),
                  ),
            body: Center(
              child: Column(
                children: [
                  const Text(
                    'กะการทำงาน (Shift).',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Gap(8),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Row(
                      children: [
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      isExpandedPage == 0
                                          ? Icons.watch_later_rounded
                                          : Icons.watch_later_outlined,
                                      color: isExpandedPage == 0
                                          ? Colors.white
                                          : Colors.grey[700],
                                    ),
                                    const Gap(20),
                                    Text(
                                      "ควบคุมกะทำงาน (Shift Control).",
                                      style: TextStyle(
                                          color: isExpandedPage == 0
                                              ? Colors.white
                                              : Colors.black54),
                                    ),
                                  ],
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
                                          right: Radius.circular(10))),
                                  backgroundColor: isExpandedPage == 1
                                      ? mythemecolor
                                      : Colors.grey[350],
                                ),
                                onPressed: () {
                                  setState(() {
                                    isExpandedPage = 1;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      isExpandedPage == 1
                                          ? Icons.settings
                                          : Icons.settings,
                                      color: isExpandedPage == 1
                                          ? Colors.white
                                          : Colors.grey[700],
                                    ),
                                    const Gap(20),
                                    Text(
                                      "ตั้งค่ากะการทำงาน (Shift Setting).",
                                      style: TextStyle(
                                          color: isExpandedPage == 1
                                              ? Colors.white
                                              : Colors.black54),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isExpandedPage == 0) const ShiftControlDataTable(),
                  if (isExpandedPage == 1) const ShiftDataTable(),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
