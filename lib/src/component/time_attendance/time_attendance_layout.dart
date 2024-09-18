import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/timeattendance_bloc/timeattendance_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/time_attendance/create_update_calendar.dart';
import 'package:hris_app_prototype/src/component/time_attendance/datatable_calendar.dart';
import 'package:hris_app_prototype/src/model/time_attendance/get_holiday_data_model.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class TimeAttendancePageLayout extends StatefulWidget {
  final bool dashboard;
  const TimeAttendancePageLayout({super.key, required this.dashboard});

  @override
  State<TimeAttendancePageLayout> createState() =>
      _TimeAttendancePageLayoutState();
}

class _TimeAttendancePageLayoutState extends State<TimeAttendancePageLayout> {
  Map<DateTime, List<HolidayDatum>> selectedEvents = {};
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  HolidayDataModel? maindata;

  int isExpandedPage = 0;

  void showDialogCreate() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: mygreycolors,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('เพิ่มข้อมูลวันหยุด (Create Holiday.)'),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
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
              ),
              content: const SizedBox(
                width: 560,
                height: 600,
                child: Column(
                  children: [
                    Expanded(
                        child: CreateUpdateCalendar(
                      onEdit: false,
                    )),
                  ],
                ),
              ));
        });
  }

  List<HolidayDatum> _getEventsfromDay(DateTime date) {
    date = dateFormat.parse(date.toString());
    return selectedEvents[date] ?? [];
  }

  @override
  void initState() {
    super.initState();
    context.read<TimeattendanceBloc>().add(FetchDataTimeAttendanceEvent());
  }

  @override
  void dispose() {
    maindata == null;
    super.dispose();
  }

  fetchData(HolidayDataModel? data) async {
    // maindata = await ApiTimeAtendanceService.fetchDataTableEmployee();
    // if (data != null) {
    //   events = {
    //     for (var event in data) DateTime.parse(event.date): [event]
    //   };
    // } else {}
    if (data?.status == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              data?.message ?? "ไม่มีข้อความแสดงข้อผิดพลาด",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: myambercolors,
          ),
        );
      });
    }
    if (data != null) {
      for (var e in data.holidayData) {
        String formattedDate = DateFormat("yyyy-MM-dd")
            .format(DateFormat("d/M/yyyy").parse(e.date));
        DateTime dateTime = DateFormat("yyyy-MM-dd").parse(formattedDate);
        if (selectedEvents[dateTime] != null) {
          // selectedEvents[dateTime]?.add(
          //   HolidayDatum(
          //       holidayId: e.holidayId,
          //       crop: e.crop,
          //       date: e.date,
          //       holidayNameTh: e.holidayNameTh,
          //       holidayNameEn: e.holidayNameEn,
          //       validFrom: e.validFrom,
          //       endDate: e.endDate,
          //       holidayFlag: e.holidayFlag,
          //       note: e.note),
          // );
        } else {
          selectedEvents[dateTime] = [
            HolidayDatum(
                holidayId: e.holidayId,
                crop: e.crop,
                date: e.date,
                holidayNameTh: e.holidayNameTh,
                holidayNameEn: e.holidayNameEn,
                validFrom: e.validFrom,
                endDate: e.endDate,
                holidayFlag: e.holidayFlag,
                note: e.note),
          ];
        }
      }
    }

    // setState(() {
    //   selectedEvents;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeattendanceBloc, TimeattendanceState>(
      builder: (context, state) {
        if (maindata == null) {
          maindata = state.holidayData;
          fetchData(maindata);
        } else {
          if (state.isDataLoading == false && maindata != null) {
            maindata = null;
            maindata = state.holidayData;
            fetchData(maindata);
          }
        }
        return SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            floatingActionButton: widget.dashboard == true
                ? null
                : isExpandedPage == 0
                    ? MyFloatingButton(
                            onPressed: () {
                              showDialogCreate();
                            },
                            icon:
                                const Icon(CupertinoIcons.calendar_badge_plus))
                        .animate()
                        .shake()
                    : null,
            body: Center(
              child: Column(
                children: [
                  if (widget.dashboard == false)
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
                                            ? Icons.calendar_month_rounded
                                            : Icons.calendar_month_outlined,
                                        color: isExpandedPage == 0
                                            ? Colors.white
                                            : Colors.grey[700],
                                      ),
                                      const Gap(20),
                                      Text(
                                        "ปฏิทิน - (Calendar).",
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
                                            ? Icons.table_chart_rounded
                                            : Icons.table_chart_outlined,
                                        color: isExpandedPage == 1
                                            ? Colors.white
                                            : Colors.grey[700],
                                      ),
                                      const Gap(20),
                                      Text(
                                        "ตาราง - (Table).",
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
                  const Gap(2),
                  if (isExpandedPage == 0)
                    state.isDataLoading == true
                        ? myLoadingScreen
                        : Expanded(
                            flex: 5,
                            child: Card(
                              elevation: 2,
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 50),
                              child: SingleChildScrollView(
                                child: TableCalendar(
                                  firstDay: DateTime.utc(1950),
                                  lastDay: DateTime.utc(9999, 12, 31),
                                  locale: "en_US",
                                  weekendDays: const [DateTime.sunday],
                                  pageJumpingEnabled: true,
                                  focusedDay: focusedDay,
                                  calendarFormat: format,
                                  startingDayOfWeek: StartingDayOfWeek.monday,
                                  daysOfWeekVisible: true,
                                  weekNumbersVisible: true,
                                  onFormatChanged: (CalendarFormat formatt) {
                                    setState(() {
                                      format = formatt;
                                    });
                                  },
                                  //Day changed
                                  onDaySelected:
                                      (DateTime selectDay, DateTime focusday) {
                                    setState(() {
                                      selectDay = dateFormat
                                          .parse(selectDay.toString());
                                      selectedDay = selectDay;
                                      focusedDay = focusday;
                                    });
                                    //print(focusedDay);
                                  },
                                  selectedDayPredicate: (DateTime date) {
                                    return isSameDay(selectedDay, date);
                                  },
                                  eventLoader: _getEventsfromDay,
                                  rowHeight: 62,
                                  //Calendar Style
                                  daysOfWeekStyle: const DaysOfWeekStyle(
                                      weekendStyle:
                                          TextStyle(color: Colors.red)),
                                  headerStyle: HeaderStyle(
                                    headerPadding: const EdgeInsets.all(2),
                                    headerMargin:
                                        const EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                        color: mythemecolor,
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                top: Radius.circular(12))),
                                    titleTextStyle: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                    formatButtonTextStyle:
                                        const TextStyle(color: Colors.white),
                                    formatButtonDecoration: BoxDecoration(
                                      border: Border.all(color: myambercolors!),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    leftChevronIcon: const Icon(
                                      Icons.chevron_left_rounded,
                                      color: Colors.white,
                                    ),
                                    rightChevronIcon: const Icon(
                                      Icons.chevron_right_rounded,
                                      color: Colors.white,
                                    ),
                                    formatButtonVisible: true,
                                    titleCentered: true,
                                    formatButtonShowsNext: false,
                                  ),
                                  calendarStyle: CalendarStyle(
                                      outsideDecoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      defaultDecoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      todayDecoration: BoxDecoration(
                                          color: Colors.amberAccent[100],
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      selectedDecoration: BoxDecoration(
                                          color: myambercolors,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      weekendDecoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      weekendTextStyle:
                                          const TextStyle(color: Colors.red),
                                      markerSize: 7,
                                      cellMargin: EdgeInsets.symmetric(
                                          horizontal: widget.dashboard == false
                                              ? 40
                                              : 15,
                                          vertical: 6),
                                      markerDecoration: BoxDecoration(
                                          color: mythemecolor,
                                          shape: BoxShape.circle)),
                                ),
                              ),
                            ),
                          ),
                  // if (widget.dashboard == false && isExpandedPage == 0)
                  //   Text(focusedDay.toString().split(" ")[0]),
                  if (widget.dashboard == false && isExpandedPage == 0)
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 48),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      _getEventsfromDay(selectedDay).length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    HolidayDatum e =
                                        _getEventsfromDay(selectedDay)[index];
                                    return Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      constraints: const BoxConstraints(
                                          maxHeight: 200, maxWidth: 440),
                                      child: Card(
                                        color: myambercolors,
                                        elevation: 3,
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: ListTile(
                                          title: Column(
                                            children: [
                                              Expanded(
                                                  child: Card(
                                                elevation: 3,
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        2, 6, 2, 0),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          TextThai(
                                                            text:
                                                                e.holidayNameTh,
                                                            textAlign: TextAlign
                                                                .center,
                                                            textStyle:
                                                                const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        18),
                                                          ),
                                                          Text(
                                                            e.holidayNameEn,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[700]),
                                                          ),
                                                          Card(
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        5),
                                                            color: Colors
                                                                .amberAccent,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10),
                                                              child: TextThai(
                                                                text: e.holidayFlag ==
                                                                        true
                                                                    ? "วันหยุดตามประกาศบริษัท"
                                                                    : "วันหยุดพิเศษ",
                                                                textStyle:
                                                                    TextStyle(
                                                                        color:
                                                                            mythemecolor),
                                                              ),
                                                            ),
                                                          ),
                                                          Text(e.note ==
                                                                  "No data"
                                                              ? "หมายเหตุ : - "
                                                              : "หมายเหตุ : ${e.note}"),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                              Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 16,
                                                      vertical: 8),
                                                  child: Text("- ${e.date} -"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )),
                        ],
                      ),
                    ),
                  if (isExpandedPage == 1) const CalendarDataTable()
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
