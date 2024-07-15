import 'dart:convert';

UpdateEmployeeSalaryModel updateEmployeeSalaryModelFromJson(String str) =>
    UpdateEmployeeSalaryModel.fromJson(json.decode(str));

String updateEmployeeSalaryModelToJson(UpdateEmployeeSalaryModel data) =>
    json.encode(data.toJson());

class UpdateEmployeeSalaryModel {
  int id;
  String employeeId;
  int employeeTypeId;
  String bankNumber;
  double salary;
  int wage;
  String status;
  String modifyBy;
  String comment;

  UpdateEmployeeSalaryModel({
    required this.id,
    required this.employeeId,
    required this.employeeTypeId,
    required this.bankNumber,
    required this.salary,
    required this.wage,
    required this.status,
    required this.modifyBy,
    required this.comment,
  });

  factory UpdateEmployeeSalaryModel.fromJson(Map<String, dynamic> json) =>
      UpdateEmployeeSalaryModel(
        id: json["id"],
        employeeId: json["employeeId"],
        employeeTypeId: json["employeeTypeId"],
        bankNumber: json["bankNumber"],
        salary: json["salary"],
        wage: json["wage"],
        status: json["status"],
        modifyBy: json["modifyBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employeeId": employeeId,
        "employeeTypeId": employeeTypeId,
        "bankNumber": bankNumber,
        "salary": salary,
        "wage": wage,
        "status": status,
        "modifyBy": modifyBy,
        "comment": comment,
      };
}
