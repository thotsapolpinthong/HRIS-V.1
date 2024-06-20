import 'dart:convert';

CreateLunchBreakModel createLunchBreakModelFromJson(String str) =>
    CreateLunchBreakModel.fromJson(json.decode(str));

String createLunchBreakModelToJson(CreateLunchBreakModel data) =>
    json.encode(data.toJson());

class CreateLunchBreakModel {
  String startDate;
  String endDate;
  List<String> employeeId;
  String organizationCode;
  String createBy;

  CreateLunchBreakModel({
    required this.startDate,
    required this.endDate,
    required this.employeeId,
    required this.organizationCode,
    required this.createBy,
  });

  factory CreateLunchBreakModel.fromJson(Map<String, dynamic> json) =>
      CreateLunchBreakModel(
        startDate: json["startDate"],
        endDate: json["endDate"],
        employeeId: List<String>.from(json["employeeId"].map((x) => x)),
        organizationCode: json["organizationCode"],
        createBy: json["createBy"],
      );

  Map<String, dynamic> toJson() => {
        "startDate": startDate,
        "endDate": endDate,
        "employeeId": List<dynamic>.from(employeeId.map((x) => x)),
        "organizationCode": organizationCode,
        "createBy": createBy,
      };
}
