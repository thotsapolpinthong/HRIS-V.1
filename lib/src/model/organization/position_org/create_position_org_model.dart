import 'dart:convert';

CreatePositionOrganizationModel createPositionOrganizationModelFromJson(
        String str) =>
    CreatePositionOrganizationModel.fromJson(json.decode(str));

String createPositionOrganizationModelToJson(
        CreatePositionOrganizationModel data) =>
    json.encode(data.toJson());

class CreatePositionOrganizationModel {
  String positionId;
  String organizationCode;
  String jobTitleId;
  String positionTypeId;
  String parentPositionNodeId;
  String parentPositionBusinessNodeId;
  String startingSalary;
  String validFromDate;
  String endDate;

  CreatePositionOrganizationModel({
    required this.positionId,
    required this.organizationCode,
    required this.jobTitleId,
    required this.positionTypeId,
    required this.parentPositionNodeId,
    required this.parentPositionBusinessNodeId,
    required this.startingSalary,
    required this.validFromDate,
    required this.endDate,
  });

  factory CreatePositionOrganizationModel.fromJson(Map<String, dynamic> json) =>
      CreatePositionOrganizationModel(
        positionId: json["positionId"],
        organizationCode: json["organizationCode"],
        jobTitleId: json["jobTitleId"],
        positionTypeId: json["positionTypeId"],
        parentPositionNodeId: json["parentPositionNodeId"],
        parentPositionBusinessNodeId: json["parentPositionBusinessNodeId"],
        startingSalary: json["startingSalary"],
        validFromDate: json["validFromDate"],
        endDate: json["endDate"],
      );

  Map<String, dynamic> toJson() => {
        "positionId": positionId,
        "organizationCode": organizationCode,
        "jobTitleId": jobTitleId,
        "positionTypeId": positionTypeId,
        "parentPositionNodeId": parentPositionNodeId,
        "parentPositionBusinessNodeId": parentPositionBusinessNodeId,
        "startingSalary": startingSalary,
        "validFromDate": validFromDate,
        "endDate": endDate,
      };
}
