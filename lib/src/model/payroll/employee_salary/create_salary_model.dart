import 'dart:convert';

CreateEmployeeSalaryModel createEmployeeSalaryModelFromJson(String str) =>
    CreateEmployeeSalaryModel.fromJson(json.decode(str));

String createEmployeeSalaryModelToJson(CreateEmployeeSalaryModel data) =>
    json.encode(data.toJson());

class CreateEmployeeSalaryModel {
  String employeeId;
  int employeeTypeId;
  String bankNumber;
  int salary;
  int wage;
  String createBy;

  CreateEmployeeSalaryModel({
    required this.employeeId,
    required this.employeeTypeId,
    required this.bankNumber,
    required this.salary,
    required this.wage,
    required this.createBy,
  });

  factory CreateEmployeeSalaryModel.fromJson(Map<String, dynamic> json) =>
      CreateEmployeeSalaryModel(
        employeeId: json["employeeId"],
        employeeTypeId: json["employeeTypeId"],
        bankNumber: json["bankNumber"],
        salary: json["salary"],
        wage: json["wage"],
        createBy: json["createBy"],
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "employeeTypeId": employeeTypeId,
        "bankNumber": bankNumber,
        "salary": salary,
        "wage": wage,
        "createBy": createBy,
      };
}
