import 'dart:convert';

UpdateWorkdateSpModel updateWorkdateSpModelFromJson(String str) =>
    UpdateWorkdateSpModel.fromJson(json.decode(str));

String updateWorkdateSpModelToJson(UpdateWorkdateSpModel data) =>
    json.encode(data.toJson());

class UpdateWorkdateSpModel {
  int id;
  String date;
  int shiftId;
  String endTime;
  bool status;
  String modifyBy;
  String comment;

  UpdateWorkdateSpModel({
    required this.id,
    required this.date,
    required this.shiftId,
    required this.endTime,
    required this.status,
    required this.modifyBy,
    required this.comment,
  });

  factory UpdateWorkdateSpModel.fromJson(Map<String, dynamic> json) =>
      UpdateWorkdateSpModel(
        id: json["id"],
        date: json["date"],
        shiftId: json["shiftId"],
        endTime: json["endTime"],
        status: json["status"],
        modifyBy: json["modifyBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "shiftId": shiftId,
        "endTime": endTime,
        "status": status,
        "modifyBy": modifyBy,
        "comment": comment,
      };
}
