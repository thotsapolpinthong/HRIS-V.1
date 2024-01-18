import 'dart:convert';

DeletePositionOrgByIdModel deletePositionOrgByIdModelFromJson(String str) =>
    DeletePositionOrgByIdModel.fromJson(json.decode(str));

String deletePositionOrgByIdModelToJson(DeletePositionOrgByIdModel data) =>
    json.encode(data.toJson());

class DeletePositionOrgByIdModel {
  String positionOrganizationId;
  String modifiedBy;
  String comment;

  DeletePositionOrgByIdModel({
    required this.positionOrganizationId,
    required this.modifiedBy,
    required this.comment,
  });

  factory DeletePositionOrgByIdModel.fromJson(Map<String, dynamic> json) =>
      DeletePositionOrgByIdModel(
        positionOrganizationId: json["positionOrganizationId"],
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "positionOrganizationId": positionOrganizationId,
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}
