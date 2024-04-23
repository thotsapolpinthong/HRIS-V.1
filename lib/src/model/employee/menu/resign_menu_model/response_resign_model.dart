import 'dart:convert';

ResponseResignModel responseResignModelFromJson(String str) =>
    ResponseResignModel.fromJson(json.decode(str));

String responseResignModelToJson(ResponseResignModel data) =>
    json.encode(data.toJson());

class ResponseResignModel {
  EmployeeDiscontinueData employeeDiscontinueData;
  String message;
  bool status;

  ResponseResignModel({
    required this.employeeDiscontinueData,
    required this.message,
    required this.status,
  });

  factory ResponseResignModel.fromJson(Map<String, dynamic> json) =>
      ResponseResignModel(
        employeeDiscontinueData:
            EmployeeDiscontinueData.fromJson(json["employeeDiscontinueData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "employeeDiscontinueData": employeeDiscontinueData.toJson(),
        "message": message,
        "status": status,
      };
}

class EmployeeDiscontinueData {
  String employeeDiscontinueId;
  EmployeeData employeeData;
  String endDate;
  String hrEndDate;
  String accEndDate;

  EmployeeDiscontinueData({
    required this.employeeDiscontinueId,
    required this.employeeData,
    required this.endDate,
    required this.hrEndDate,
    required this.accEndDate,
  });

  factory EmployeeDiscontinueData.fromJson(Map<String, dynamic> json) =>
      EmployeeDiscontinueData(
        employeeDiscontinueId: json["employeeDiscontinueId"],
        employeeData: EmployeeData.fromJson(json["employeeData"]),
        endDate: json["endDate"],
        hrEndDate: json["hrEndDate"],
        accEndDate: json["accEndDate"],
      );

  Map<String, dynamic> toJson() => {
        "employeeDiscontinueId": employeeDiscontinueId,
        "employeeData": employeeData.toJson(),
        "endDate": endDate,
        "hrEndDate": hrEndDate,
        "accEndDate": accEndDate,
      };
}

class EmployeeData {
  String employeeId;
  String firstName;
  String lastName;

  EmployeeData({
    required this.employeeId,
    required this.firstName,
    required this.lastName,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) => EmployeeData(
        employeeId: json["employeeId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "firstName": firstName,
        "lastName": lastName,
      };
}
