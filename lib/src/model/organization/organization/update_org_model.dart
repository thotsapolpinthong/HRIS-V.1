import 'dart:convert';

UpdateOrganizationByIdModel updateOrganizationByIdModelFromJson(String str) =>
    UpdateOrganizationByIdModel.fromJson(json.decode(str));

String updateOrganizationByIdModelToJson(UpdateOrganizationByIdModel data) =>
    json.encode(data.toJson());

class UpdateOrganizationByIdModel {
  String organizationId;
  String organizationCode;
  String deparmentId;
  String parentOrganizationNodeId;
  String parentOrganizationBusinessNodeId;
  String organizationTypeId;
  String organizationStatus;
  String validFrom;
  String endDate;
  String modifiedBy;
  String comment;

  UpdateOrganizationByIdModel({
    required this.organizationId,
    required this.organizationCode,
    required this.deparmentId,
    required this.parentOrganizationNodeId,
    required this.parentOrganizationBusinessNodeId,
    required this.organizationTypeId,
    required this.organizationStatus,
    required this.validFrom,
    required this.endDate,
    required this.modifiedBy,
    required this.comment,
  });

  factory UpdateOrganizationByIdModel.fromJson(Map<String, dynamic> json) =>
      UpdateOrganizationByIdModel(
        organizationId: json["organizationId"],
        organizationCode: json["organizationCode"],
        deparmentId: json["deparmentId"],
        parentOrganizationNodeId: json["parentOrganizationNodeId"],
        parentOrganizationBusinessNodeId:
            json["parentOrganizationBusinessNodeId"],
        organizationTypeId: json["organizationTypeId"],
        organizationStatus: json["organizationStatus"],
        validFrom: json["validFrom"],
        endDate: json["endDate"],
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "organizationId": organizationId,
        "organizationCode": organizationCode,
        "deparmentId": deparmentId,
        "parentOrganizationNodeId": parentOrganizationNodeId,
        "parentOrganizationBusinessNodeId": parentOrganizationBusinessNodeId,
        "organizationTypeId": organizationTypeId,
        "organizationStatus": organizationStatus,
        "validFrom": validFrom,
        "endDate": endDate,
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}
