import 'dart:convert';

GetShiftControlModel getShiftControlModelFromJson(String str) =>
    GetShiftControlModel.fromJson(json.decode(str));

String getShiftControlModelToJson(GetShiftControlModel data) =>
    json.encode(data.toJson());

class GetShiftControlModel {
  List<ShiftAssignmentDatum> shiftAssignmentData;
  String message;
  bool status;

  GetShiftControlModel({
    required this.shiftAssignmentData,
    required this.message,
    required this.status,
  });

  factory GetShiftControlModel.fromJson(Map<String, dynamic> json) =>
      GetShiftControlModel(
        shiftAssignmentData: List<ShiftAssignmentDatum>.from(
            json["shiftAssignmentData"]
                .map((x) => ShiftAssignmentDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "shiftAssignmentData":
            List<dynamic>.from(shiftAssignmentData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class ShiftAssignmentDatum {
  String shiftControlId;
  ShiftDatam shiftData;
  EmployeeDatam employeeData;
  String validFrom;
  String endDate;
  String noted;

  ShiftAssignmentDatum({
    required this.shiftControlId,
    required this.shiftData,
    required this.employeeData,
    required this.validFrom,
    required this.endDate,
    required this.noted,
  });

  factory ShiftAssignmentDatum.fromJson(Map<String, dynamic> json) =>
      ShiftAssignmentDatum(
        shiftControlId: json["shiftControlId"],
        shiftData: ShiftDatam.fromJson(json["shiftData"]),
        employeeData: EmployeeDatam.fromJson(json["employeeData"]),
        validFrom: json["validFrom"],
        endDate: json["endDate"],
        noted: json["noted"],
      );

  Map<String, dynamic> toJson() => {
        "shiftControlId": shiftControlId,
        "shiftData": shiftData.toJson(),
        "employeeData": employeeData.toJson(),
        "validFrom": validFrom,
        "endDate": endDate,
        "noted": noted,
      };
}

class EmployeeDatam {
  String employeeId;
  String firstName;
  String lastName;
  String positionName;
  String departmentName;

  EmployeeDatam({
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.positionName,
    required this.departmentName,
  });

  factory EmployeeDatam.fromJson(Map<String, dynamic> json) => EmployeeDatam(
        employeeId: json["employeeId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        positionName: json["positionName"],
        departmentName: json["departmentName"],
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "firstName": firstName,
        "lastName": lastName,
        "positionName": positionName,
        "departmentName": departmentName,
      };
}

class ShiftDatam {
  String shiftId;
  String shiftName;
  String startTime;
  String endTime;
  String validFrom;
  String endDate;
  String shiftStatus;

  ShiftDatam({
    required this.shiftId,
    required this.shiftName,
    required this.startTime,
    required this.endTime,
    required this.validFrom,
    required this.endDate,
    required this.shiftStatus,
  });

  factory ShiftDatam.fromJson(Map<String, dynamic> json) => ShiftDatam(
        shiftId: json["shiftId"],
        shiftName: json["shiftName"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        validFrom: json["validFrom"],
        endDate: json["endDate"],
        shiftStatus: json["shiftStatus"],
      );

  Map<String, dynamic> toJson() => {
        "shiftId": shiftId,
        "shiftName": shiftName,
        "startTime": startTime,
        "endTime": endTime,
        "validFrom": validFrom,
        "endDate": endDate,
        "shiftStatus": shiftStatus,
      };
}
