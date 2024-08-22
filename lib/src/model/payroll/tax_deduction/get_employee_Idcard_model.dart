import 'dart:convert';

EmployeeIdcardModel employeeIdcardModelFromJson(String str) =>
    EmployeeIdcardModel.fromJson(json.decode(str));

String employeeIdcardModelToJson(EmployeeIdcardModel data) =>
    json.encode(data.toJson());

class EmployeeIdcardModel {
  List<EmployeeIdcardDatum> employeeData;
  String message;
  bool status;

  EmployeeIdcardModel({
    required this.employeeData,
    required this.message,
    required this.status,
  });

  factory EmployeeIdcardModel.fromJson(Map<String, dynamic> json) =>
      EmployeeIdcardModel(
        employeeData: List<EmployeeIdcardDatum>.from(
            json["employeeData"].map((x) => EmployeeIdcardDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "employeeData": List<dynamic>.from(employeeData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class EmployeeIdcardDatum {
  String employeeId;
  String firstNameTh;
  String lastNameTh;
  String idCard;

  EmployeeIdcardDatum({
    required this.employeeId,
    required this.firstNameTh,
    required this.lastNameTh,
    required this.idCard,
  });

  factory EmployeeIdcardDatum.fromJson(Map<String, dynamic> json) =>
      EmployeeIdcardDatum(
        employeeId: json["employeeId"],
        firstNameTh: json["firstNameTh"],
        lastNameTh: json["lastNameTh"],
        idCard: json["idCard"],
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "firstNameTh": firstNameTh,
        "lastNameTh": lastNameTh,
        "idCard": idCard,
      };
}
