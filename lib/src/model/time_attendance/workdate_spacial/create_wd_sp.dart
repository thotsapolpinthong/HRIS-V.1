import 'dart:convert';

CreateWorkdateSpModel createWorkdateSpModelFromJson(String str) =>
    CreateWorkdateSpModel.fromJson(json.decode(str));

String createWorkdateSpModelToJson(CreateWorkdateSpModel data) =>
    json.encode(data.toJson());

class CreateWorkdateSpModel {
  String date;
  int shiftId;
  String endTime;
  String createBy;

  CreateWorkdateSpModel({
    required this.date,
    required this.shiftId,
    required this.endTime,
    required this.createBy,
  });

  factory CreateWorkdateSpModel.fromJson(Map<String, dynamic> json) =>
      CreateWorkdateSpModel(
        date: json["date"],
        shiftId: json["shiftId"],
        endTime: json["endTime"],
        createBy: json["createBy"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "shiftId": shiftId,
        "endTime": endTime,
        "createBy": createBy,
      };
}
