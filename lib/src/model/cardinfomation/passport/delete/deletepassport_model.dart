import 'dart:convert';

DeletePassportModel deletePassportModelFromJson(String str) =>
    DeletePassportModel.fromJson(json.decode(str));

String deletePassportModelToJson(DeletePassportModel data) =>
    json.encode(data.toJson());

class DeletePassportModel {
  String id;
  String modifiedBy;
  String comment;

  DeletePassportModel({
    required this.id,
    required this.modifiedBy,
    required this.comment,
  });

  factory DeletePassportModel.fromJson(Map<String, dynamic> json) =>
      DeletePassportModel(
        id: json["id"],
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}
