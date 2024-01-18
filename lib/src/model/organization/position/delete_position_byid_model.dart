import 'dart:convert';

DeletePositionByIdModel deletePositionByIdModelFromJson(String str) =>
    DeletePositionByIdModel.fromJson(json.decode(str));

String deletePositionByIdModelToJson(DeletePositionByIdModel data) =>
    json.encode(data.toJson());

class DeletePositionByIdModel {
  String positionId;
  String modifiedBy;
  String comment;

  DeletePositionByIdModel({
    required this.positionId,
    required this.modifiedBy,
    required this.comment,
  });

  factory DeletePositionByIdModel.fromJson(Map<String, dynamic> json) =>
      DeletePositionByIdModel(
        positionId: json["positionId"],
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "positionId": positionId,
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}
