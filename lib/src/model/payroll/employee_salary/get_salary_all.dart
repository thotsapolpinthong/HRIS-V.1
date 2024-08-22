import 'dart:convert';

EmployeeSalaryModel employeeSalaryModelFromJson(String str) =>
    EmployeeSalaryModel.fromJson(json.decode(str));

String employeeSalaryModelToJson(EmployeeSalaryModel data) =>
    json.encode(data.toJson());

class EmployeeSalaryModel {
  List<EmployeeSalaryDatum> employeeSalaryData;
  String message;
  bool status;

  EmployeeSalaryModel({
    required this.employeeSalaryData,
    required this.message,
    required this.status,
  });

  factory EmployeeSalaryModel.fromJson(Map<String, dynamic> json) =>
      EmployeeSalaryModel(
        employeeSalaryData: List<EmployeeSalaryDatum>.from(
            json["employeeSalaryData"]
                .map((x) => EmployeeSalaryDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "employeeSalaryData":
            List<dynamic>.from(employeeSalaryData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class EmployeeSalaryDatum {
  int id;
  String employeeId;
  String firstName;
  String lastName;
  int employeeTypeId;
  String employeeTypeName;
  String bankNumber;
  double salary;
  int wage;
  String status;

  EmployeeSalaryDatum({
    required this.id,
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.employeeTypeId,
    required this.employeeTypeName,
    required this.bankNumber,
    required this.salary,
    required this.wage,
    required this.status,
  });

  factory EmployeeSalaryDatum.fromJson(Map<String, dynamic> json) =>
      EmployeeSalaryDatum(
        id: json["id"],
        employeeId: json["employeeId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        employeeTypeId: json["employeeTypeId"],
        employeeTypeName: json["employeeTypeName"],
        bankNumber: json["bankNumber"],
        salary: json["salary"],
        wage: json["wage"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employeeId": employeeId,
        "firstName": firstName,
        "lastName": lastName,
        "employeeTypeId": employeeTypeId,
        "employeeTypeName": employeeTypeName,
        "bankNumber": bankNumber,
        "salary": salary,
        "wage": wage,
        "status": status,
      };
}
