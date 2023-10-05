import 'dart:convert';

DeletepersonModel deletepersonModelFromJson(String str) =>
    DeletepersonModel.fromJson(json.decode(str));

String deletepersonModelToJson(DeletepersonModel data) =>
    json.encode(data.toJson());

class DeletepersonModel {
  String personId;
  String comment;
  String modifiedBy;

  DeletepersonModel({
    required this.personId,
    required this.comment,
    required this.modifiedBy,
  });

  factory DeletepersonModel.fromJson(Map<String, dynamic> json) =>
      DeletepersonModel(
        personId: json["personId"],
        comment: json["comment"],
        modifiedBy: json["modifiedBy"],
      );

  Map<String, dynamic> toJson() => {
        "personId": personId,
        "comment": comment,
        "modifiedBy": modifiedBy,
      };
}
