import 'dart:convert';

UpdatePositionOrgModel updatePositionOrgModelFromJson(String str) =>
    UpdatePositionOrgModel.fromJson(json.decode(str));

String updatePositionOrgModelToJson(UpdatePositionOrgModel data) =>
    json.encode(data.toJson());

class UpdatePositionOrgModel {
  String positionOrganizationId;
  String positionId;
  String organizationCode;
  String jobTitleId;
  String positionTypeId;
  String status;
  String parentPositionNodeId;
  String parentPositionBusinessNodeId;
  String roleId;
  String startingSalary;
  String validFromDate;
  String endDate;
  String modifiedBy;
  String comment;

  UpdatePositionOrgModel({
    required this.positionOrganizationId,
    required this.positionId,
    required this.organizationCode,
    required this.jobTitleId,
    required this.positionTypeId,
    required this.status,
    required this.parentPositionNodeId,
    required this.parentPositionBusinessNodeId,
    required this.roleId,
    required this.startingSalary,
    required this.validFromDate,
    required this.endDate,
    required this.modifiedBy,
    required this.comment,
  });

  factory UpdatePositionOrgModel.fromJson(Map<String, dynamic> json) =>
      UpdatePositionOrgModel(
        positionOrganizationId: json["positionOrganizationId"],
        positionId: json["positionId"],
        organizationCode: json["organizationCode"],
        jobTitleId: json["jobTitleId"],
        positionTypeId: json["positionTypeId"],
        status: json["status"],
        parentPositionNodeId: json["parentPositionNodeId"],
        parentPositionBusinessNodeId: json["parentPositionBusinessNodeId"],
        roleId: json["roleId"],
        startingSalary: json["startingSalary"],
        validFromDate: json["validFromDate"],
        endDate: json["endDate"],
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "positionOrganizationId": positionOrganizationId,
        "positionId": positionId,
        "organizationCode": organizationCode,
        "jobTitleId": jobTitleId,
        "positionTypeId": positionTypeId,
        "status": status,
        "parentPositionNodeId": parentPositionNodeId,
        "parentPositionBusinessNodeId": parentPositionBusinessNodeId,
        "roleId": roleId,
        "startingSalary": startingSalary,
        "validFromDate": validFromDate,
        "endDate": endDate,
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}
