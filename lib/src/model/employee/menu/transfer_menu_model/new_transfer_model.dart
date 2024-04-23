import 'dart:convert';

NewTransferModel newTransferModelFromJson(String str) =>
    NewTransferModel.fromJson(json.decode(str));

String newTransferModelToJson(NewTransferModel data) =>
    json.encode(data.toJson());

class NewTransferModel {
  String staffTypeId;
  String positionOrganizationId;
  String employeeId;
  String baseSalary;
  String startDate;
  String createBy;

  NewTransferModel({
    required this.staffTypeId,
    required this.positionOrganizationId,
    required this.employeeId,
    required this.baseSalary,
    required this.startDate,
    required this.createBy,
  });

  factory NewTransferModel.fromJson(Map<String, dynamic> json) =>
      NewTransferModel(
        staffTypeId: json["staffTypeId"],
        positionOrganizationId: json["positionOrganizationId"],
        employeeId: json["employeeId"],
        baseSalary: json["baseSalary"],
        startDate: json["startDate"],
        createBy: json["createBy"],
      );

  Map<String, dynamic> toJson() => {
        "staffTypeId": staffTypeId,
        "positionOrganizationId": positionOrganizationId,
        "employeeId": employeeId,
        "baseSalary": baseSalary,
        "startDate": startDate,
        "createBy": createBy,
      };
}
