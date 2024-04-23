import 'dart:convert';

NewPromoteModel newPromoteModelFromJson(String str) =>
    NewPromoteModel.fromJson(json.decode(str));

String newPromoteModelToJson(NewPromoteModel data) =>
    json.encode(data.toJson());

class NewPromoteModel {
  String promoteTypeId;
  String employeeId;
  String staffTypeId;
  String baseSalary;
  String positionOrganizationId;
  String startDate;
  String endDate;
  String createBy;

  NewPromoteModel({
    required this.promoteTypeId,
    required this.employeeId,
    required this.staffTypeId,
    required this.baseSalary,
    required this.positionOrganizationId,
    required this.startDate,
    required this.endDate,
    required this.createBy,
  });

  factory NewPromoteModel.fromJson(Map<String, dynamic> json) =>
      NewPromoteModel(
        promoteTypeId: json["promoteTypeId"],
        employeeId: json["employeeId"],
        staffTypeId: json["staffTypeId"],
        baseSalary: json["baseSalary"],
        positionOrganizationId: json["positionOrganizationId"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        createBy: json["createBy"],
      );

  Map<String, dynamic> toJson() => {
        "promoteTypeId": promoteTypeId,
        "employeeId": employeeId,
        "staffTypeId": staffTypeId,
        "baseSalary": baseSalary,
        "positionOrganizationId": positionOrganizationId,
        "startDate": startDate,
        "endDate": endDate,
        "createBy": createBy,
      };
}
