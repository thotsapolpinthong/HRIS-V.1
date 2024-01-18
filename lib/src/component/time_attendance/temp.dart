import 'package:flutter/material.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/model/time_attendance/get_holiday_data_model.dart';
import 'package:hris_app_prototype/src/services/api_time_attendance_service.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class temp extends StatefulWidget {
  const temp({super.key});

  @override
  State<temp> createState() => _tempState();
}

class _tempState extends State<temp> {
  Map<DateTime, List<HolidayDatum>> selectedEvents = {};
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  HolidayDataModel? maindata;
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  List<HolidayDatum> _getEventsfromDay(DateTime date) {
    date = dateFormat.parse(date.toString());
    return selectedEvents[date] ?? [];
  }

  fetchData() async {
    maindata = await ApiTimeAtendanceService.fetchDataTableEmployee();
    // if (data != null) {
    //   events = {
    //     for (var event in data) DateTime.parse(event.date): [event]
    //   };
    // } else {}
    if (maindata != null) {
      for (var e in maindata!.holidayData) {
        // DateTime date = DateTime.parse(e.date);
        DateTime dateTime = DateTime.parse(e.date);
        if (selectedEvents[dateTime] != null) {
          selectedEvents[dateTime]?.add(
            HolidayDatum(
                holidayId: e.holidayId,
                crop: e.crop,
                date: e.date,
                holidayNameTh: e.holidayNameTh,
                holidayNameEn: e.holidayNameEn,
                validFrom: e.validFrom,
                endDate: e.endDate,
                holidayFlag: true,
                note: e.note),
          );
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
                holidayFlag: true,
                note: e.note),
          ];
        }
      }
    }

    setState(() {
      selectedEvents;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (maindata != null) {}
    return SafeArea(
        child: Scaffold(
      body: maindata == null
          ? myLoadingScreen
          : Column(
              children: [
                TableCalendar(
                  focusedDay: selectedDay,
                  firstDay: DateTime(1990),
                  lastDay: DateTime(9999),
                  calendarFormat: format,
                  onFormatChanged: (CalendarFormat _format) {
                    setState(() {
                      format = _format;
                    });
                  },
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  daysOfWeekVisible: true,

                  //Day changed
                  onDaySelected: (DateTime selectDay, DateTime focusday) {
                    setState(() {
                      selectDay = dateFormat.parse(selectDay.toString());
                      selectedDay = selectDay;
                      focusedDay = focusday;
                    });
                    print(focusedDay);
                  },
                  selectedDayPredicate: (DateTime date) {
                    return isSameDay(selectedDay, date);
                  },
                  eventLoader: _getEventsfromDay,

                  //format calendar
                ),
                ..._getEventsfromDay(selectedDay)
                    .map((HolidayDatum e) => ListTile(
                          title: Column(
                            children: [
                              Text(e.holidayNameTh),
                              Text(e.crop),
                            ],
                          ),
                        ))
              ],
            ),
    ));
  }
}
