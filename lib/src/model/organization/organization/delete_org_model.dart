import 'dart:convert';

DeleteOrganizationByIdModel deleteOrganizationByIdModelFromJson(String str) =>
    DeleteOrganizationByIdModel.fromJson(json.decode(str));

String deleteOrganizationByIdModelToJson(DeleteOrganizationByIdModel data) =>
    json.encode(data.toJson());

class DeleteOrganizationByIdModel {
  String organizationId;
  String modifiedBy;
  String comment;

  DeleteOrganizationByIdModel({
    required this.organizationId,
    required this.modifiedBy,
    required this.comment,
  });

  factory DeleteOrganizationByIdModel.fromJson(Map<String, dynamic> json) =>
      DeleteOrganizationByIdModel(
        organizationId: json["organizationId"],
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "organizationId": organizationId,
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}
