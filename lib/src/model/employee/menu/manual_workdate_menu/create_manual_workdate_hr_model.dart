import 'dart:convert';

CreateManualWorkDateManualModel createManualWorkDateManualModelFromJson(
        String str) =>
    CreateManualWorkDateManualModel.fromJson(json.decode(str));

String createManualWorkDateManualModelToJson(
        CreateManualWorkDateManualModel data) =>
    json.encode(data.toJson());

class CreateManualWorkDateManualModel {
  String manualWorkDateTypeId;
  String employeeId;
  String date;
  String startTime;
  String endTime;
  String decription;
  String createBy;
  String approveBy;

  CreateManualWorkDateManualModel({
    required this.manualWorkDateTypeId,
    required this.employeeId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.decription,
    required this.createBy,
    required this.approveBy,
  });

  factory CreateManualWorkDateManualModel.fromJson(Map<String, dynamic> json) =>
      CreateManualWorkDateManualModel(
        manualWorkDateTypeId: json["manualWorkDateTypeId"],
        employeeId: json["employeeId"],
        date: json["date"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        decription: json["decription"],
        createBy: json["createBy"],
        approveBy: json["approveBy"],
      );

  Map<String, dynamic> toJson() => {
        "manualWorkDateTypeId": manualWorkDateTypeId,
        "employeeId": employeeId,
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
        "decription": decription,
        "createBy": createBy,
        "approveBy": approveBy,
      };
}
