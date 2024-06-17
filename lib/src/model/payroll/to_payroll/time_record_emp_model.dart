import 'dart:convert';

TimeRecordEmpModel timeRecordEmpModelFromJson(String str) =>
    TimeRecordEmpModel.fromJson(json.decode(str));

String timeRecordEmpModelToJson(TimeRecordEmpModel data) =>
    json.encode(data.toJson());

class TimeRecordEmpModel {
  List<EmployeeWorkTime> employeeWorkTime;
  String message;
  bool status;

  TimeRecordEmpModel({
    required this.employeeWorkTime,
    required this.message,
    required this.status,
  });

  factory TimeRecordEmpModel.fromJson(Map<String, dynamic> json) =>
      TimeRecordEmpModel(
        employeeWorkTime: List<EmployeeWorkTime>.from(
            json["employeeWorkTime"].map((x) => EmployeeWorkTime.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "employeeWorkTime":
            List<dynamic>.from(employeeWorkTime.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class EmployeeWorkTime {
  String date;
  String departmentName;
  String positionName;
  String employeeId;
  String titleName;
  String firstName;
  String lastName;
  String staffType;
  String? checkIn;
  String? checkOut;
  String? holiday;
  String? trip;
  String? leaveType;
  String? nLeave;
  String? normalOt;
  String? holidayOt;
  String? workHoliday;

  EmployeeWorkTime({
    required this.date,
    required this.departmentName,
    required this.positionName,
    required this.employeeId,
    required this.titleName,
    required this.firstName,
    required this.lastName,
    required this.staffType,
    required this.checkIn,
    required this.checkOut,
    required this.holiday,
    required this.trip,
    required this.leaveType,
    required this.nLeave,
    required this.normalOt,
    required this.holidayOt,
    required this.workHoliday,
  });

  factory EmployeeWorkTime.fromJson(Map<String, dynamic> json) =>
      EmployeeWorkTime(
        date: json["date"],
        departmentName: json["departmentName"],
        positionName: json["positionName"],
        employeeId: json["employeeId"],
        titleName: json["titleName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        staffType: json["staffType"],
        checkIn: json["checkIn"],
        checkOut: json["checkOut"],
        holiday: json["holiday"],
        trip: json["trip"],
        leaveType: json["leaveType"],
        nLeave: json["nLeave"],
        normalOt: json["normalOt"],
        holidayOt: json["holidayOt"],
        workHoliday: json["workHoliday"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "departmentName": departmentName,
        "positionName": positionName,
        "employeeId": employeeId,
        "titleName": titleName,
        "firstName": firstName,
        "lastName": lastName,
        "staffType": staffType,
        "checkIn": checkIn,
        "checkOut": checkOut,
        "holiday": holiday,
        "trip": trip,
        "leaveType": leaveType,
        "nLeave": nLeave,
        "normalOt": normalOt,
        "holidayOt": holidayOt,
        "workHoliday": workHoliday,
      };
}
