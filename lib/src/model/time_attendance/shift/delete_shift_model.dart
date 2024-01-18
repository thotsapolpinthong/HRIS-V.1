import 'dart:convert';

DeleteShiftModel deleteShiftModelFromJson(String str) =>
    DeleteShiftModel.fromJson(json.decode(str));

String deleteShiftModelToJson(DeleteShiftModel data) =>
    json.encode(data.toJson());

class DeleteShiftModel {
  String shiftId;
  String modifiedBy;
  String comment;

  DeleteShiftModel({
    required this.shiftId,
    required this.modifiedBy,
    required this.comment,
  });

  factory DeleteShiftModel.fromJson(Map<String, dynamic> json) =>
      DeleteShiftModel(
        shiftId: json["shiftId"],
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "shiftId": shiftId,
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}
