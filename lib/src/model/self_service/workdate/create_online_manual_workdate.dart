import 'dart:convert';

CreateManualWorkDateOnlineModel createManualWorkDateOnlineModelFromJson(
        String str) =>
    CreateManualWorkDateOnlineModel.fromJson(json.decode(str));

String createManualWorkDateOnlineModelToJson(
        CreateManualWorkDateOnlineModel data) =>
    json.encode(data.toJson());

class CreateManualWorkDateOnlineModel {
  String manualWorkDateTypeId;
  String employeeId;
  String date;
  String startTime;
  String endTime;
  String decription;
  String createBy;

  CreateManualWorkDateOnlineModel({
    required this.manualWorkDateTypeId,
    required this.employeeId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.decription,
    required this.createBy,
  });

  factory CreateManualWorkDateOnlineModel.fromJson(Map<String, dynamic> json) =>
      CreateManualWorkDateOnlineModel(
        manualWorkDateTypeId: json["manualWorkDateTypeId"],
        employeeId: json["employeeId"],
        date: json["date"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        decription: json["decription"],
        createBy: json["createBy"],
      );

  Map<String, dynamic> toJson() => {
        "manualWorkDateTypeId": manualWorkDateTypeId,
        "employeeId": employeeId,
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
        "decription": decription,
        "createBy": createBy,
      };
}
