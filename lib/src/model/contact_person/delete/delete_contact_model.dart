import 'dart:convert';

DeleteContactModel deleteContactModelFromJson(String str) =>
    DeleteContactModel.fromJson(json.decode(str));

String deleteContactModelToJson(DeleteContactModel data) =>
    json.encode(data.toJson());

class DeleteContactModel {
  String contactPersonInfoId;
  String personId;
  String modifiedBy;
  String comment;

  DeleteContactModel({
    required this.contactPersonInfoId,
    required this.personId,
    required this.modifiedBy,
    required this.comment,
  });

  factory DeleteContactModel.fromJson(Map<String, dynamic> json) =>
      DeleteContactModel(
        contactPersonInfoId: json["contactPersonInfoId"],
        personId: json["personId"],
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "contactPersonInfoId": contactPersonInfoId,
        "personId": personId,
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}
