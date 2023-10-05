import 'dart:convert';

DeleteEducationModel deleteEducationModelFromJson(String str) =>
    DeleteEducationModel.fromJson(json.decode(str));

String deleteEducationModelToJson(DeleteEducationModel data) =>
    json.encode(data.toJson());

class DeleteEducationModel {
  String educationId;
  String personId;
  String modifiedBy;
  String comment;

  DeleteEducationModel({
    required this.educationId,
    required this.personId,
    required this.modifiedBy,
    required this.comment,
  });

  factory DeleteEducationModel.fromJson(Map<String, dynamic> json) =>
      DeleteEducationModel(
        educationId: json["educationId"],
        personId: json["personId"],
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "educationId": educationId,
        "personId": personId,
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}
