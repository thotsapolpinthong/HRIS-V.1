import 'dart:convert';

DeleteFamilyModel deleteFamilyModelFromJson(String str) =>
    DeleteFamilyModel.fromJson(json.decode(str));

String deleteFamilyModelToJson(DeleteFamilyModel data) =>
    json.encode(data.toJson());

class DeleteFamilyModel {
  String familyMemberId;
  String personId;
  String modifiedBy;
  String comment;

  DeleteFamilyModel({
    required this.familyMemberId,
    required this.personId,
    required this.modifiedBy,
    required this.comment,
  });

  factory DeleteFamilyModel.fromJson(Map<String, dynamic> json) =>
      DeleteFamilyModel(
        familyMemberId: json["familyMemberId"],
        personId: json["personId"],
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "familyMemberId": familyMemberId,
        "personId": personId,
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}
