import 'dart:convert';

CreateOrganizationModel createOrganizationModelFromJson(String str) =>
    CreateOrganizationModel.fromJson(json.decode(str));

String createOrganizationModelToJson(CreateOrganizationModel data) =>
    json.encode(data.toJson());

class CreateOrganizationModel {
  String deparmentId;
  String parentOrganizationNodeId;
  String parentOrganizationBusinessNodeId;
  String organizationTypeId;
  String organizationStatus;
  String validFrom;
  String endDate;

  CreateOrganizationModel({
    required this.deparmentId,
    required this.parentOrganizationNodeId,
    required this.parentOrganizationBusinessNodeId,
    required this.organizationTypeId,
    required this.organizationStatus,
    required this.validFrom,
    required this.endDate,
  });

  factory CreateOrganizationModel.fromJson(Map<String, dynamic> json) =>
      CreateOrganizationModel(
        deparmentId: json["deparmentId"],
        parentOrganizationNodeId: json["parentOrganizationNodeId"],
        parentOrganizationBusinessNodeId:
            json["parentOrganizationBusinessNodeId"],
        organizationTypeId: json["organizationTypeId"],
        organizationStatus: json["organizationStatus"],
        validFrom: json["validFrom"],
        endDate: json["endDate"],
      );

  Map<String, dynamic> toJson() => {
        "deparmentId": deparmentId,
        "parentOrganizationNodeId": parentOrganizationNodeId,
        "parentOrganizationBusinessNodeId": parentOrganizationBusinessNodeId,
        "organizationTypeId": organizationTypeId,
        "organizationStatus": organizationStatus,
        "validFrom": validFrom,
        "endDate": endDate,
      };
}
