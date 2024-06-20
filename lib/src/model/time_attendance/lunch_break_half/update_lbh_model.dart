import 'dart:convert';

UpdateLunchBreakModel updateLunchBreakModelFromJson(String str) =>
    UpdateLunchBreakModel.fromJson(json.decode(str));

String updateLunchBreakModelToJson(UpdateLunchBreakModel data) =>
    json.encode(data.toJson());

class UpdateLunchBreakModel {
  int id;
  String startDate;
  String endDate;
  String employeeId;
  bool status;
  String modifyBy;
  String comment;

  UpdateLunchBreakModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.employeeId,
    required this.status,
    required this.modifyBy,
    required this.comment,
  });

  factory UpdateLunchBreakModel.fromJson(Map<String, dynamic> json) =>
      UpdateLunchBreakModel(
        id: json["id"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        employeeId: json["employeeId"],
        status: json["status"],
        modifyBy: json["modifyBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startDate": startDate,
        "endDate": endDate,
        "employeeId": employeeId,
        "status": status,
        "modifyBy": modifyBy,
        "comment": comment,
      };
}
