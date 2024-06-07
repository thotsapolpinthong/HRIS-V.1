import 'dart:convert';

TimeRecordModel timeRecordModelFromJson(String str) =>
    TimeRecordModel.fromJson(json.decode(str));

String timeRecordModelToJson(TimeRecordModel data) =>
    json.encode(data.toJson());

class TimeRecordModel {
  List<TimeRecordDatum> timeRecordData;
  String message;
  bool status;

  TimeRecordModel({
    required this.timeRecordData,
    required this.message,
    required this.status,
  });

  factory TimeRecordModel.fromJson(Map<String, dynamic> json) =>
      TimeRecordModel(
        timeRecordData: List<TimeRecordDatum>.from(
            json["timeRecordData"].map((x) => TimeRecordDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "timeRecordData":
            List<dynamic>.from(timeRecordData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class TimeRecordDatum {
  String employeeId;
  String firstName;
  String lastName;
  String departmentName;
  String positionName;
  String staffType;
  String nWorkDate;
  String foodAllowance;
  String? normalOt;
  String? holidayOt;
  String? workHoliday;

  TimeRecordDatum({
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.departmentName,
    required this.positionName,
    required this.staffType,
    required this.nWorkDate,
    required this.foodAllowance,
    required this.normalOt,
    required this.holidayOt,
    required this.workHoliday,
  });

  factory TimeRecordDatum.fromJson(Map<String, dynamic> json) =>
      TimeRecordDatum(
        employeeId: json["employeeId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        departmentName: json["departmentName"],
        positionName: json["positionName"],
        staffType: json["staffType"],
        nWorkDate: json["nWorkDate"],
        foodAllowance: json["foodAllowance"],
        normalOt: json["normalOt"],
        holidayOt: json["holidayOt"],
        workHoliday: json["workHoliday"],
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "firstName": firstName,
        "lastName": lastName,
        "departmentName": departmentName,
        "positionName": positionName,
        "staffType": staffType,
        "nWorkDate": nWorkDate,
        "foodAllowance": foodAllowance,
        "normalOt": normalOt,
        "holidayOt": holidayOt,
        "workHoliday": workHoliday,
      };
}
