import 'dart:convert';

DeleteIdcardModel deleteIdcardModelFromJson(String str) =>
    DeleteIdcardModel.fromJson(json.decode(str));

String deleteIdcardModelToJson(DeleteIdcardModel data) =>
    json.encode(data.toJson());

class DeleteIdcardModel {
  String id;
  String modifiedBy;
  String comment;

  DeleteIdcardModel({
    required this.id,
    required this.modifiedBy,
    required this.comment,
  });

  factory DeleteIdcardModel.fromJson(Map<String, dynamic> json) =>
      DeleteIdcardModel(
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
