import 'dart:convert';

EmployeeApproveModel employeeApproveModelFromJson(String str) =>
    EmployeeApproveModel.fromJson(json.decode(str));

String employeeApproveModelToJson(EmployeeApproveModel data) =>
    json.encode(data.toJson());

class EmployeeApproveModel {
  String employeeId;
  String firstName;
  String lastName;

  EmployeeApproveModel({
    required this.employeeId,
    required this.firstName,
    required this.lastName,
  });

  factory EmployeeApproveModel.fromJson(Map<String, dynamic> json) =>
      EmployeeApproveModel(
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
