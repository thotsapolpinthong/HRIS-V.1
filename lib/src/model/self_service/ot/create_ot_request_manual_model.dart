import 'dart:convert';

CreateOtRequestManualModel createOtRequestManualModelFromJson(String str) =>
    CreateOtRequestManualModel.fromJson(json.decode(str));

String createOtRequestManualModelToJson(CreateOtRequestManualModel data) =>
    json.encode(data.toJson());

class CreateOtRequestManualModel {
  String employeeId;
  String oTrequestTypeId;
  String otTypeId;
  String date;
  String startTime;
  String endTime;
  String otDescription;
  String approveBy;
  String createBy;

  CreateOtRequestManualModel({
    required this.employeeId,
    required this.oTrequestTypeId,
    required this.otTypeId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.otDescription,
    required this.approveBy,
    required this.createBy,
  });

  factory CreateOtRequestManualModel.fromJson(Map<String, dynamic> json) =>
      CreateOtRequestManualModel(
        employeeId: json["employeeId"],
        oTrequestTypeId: json["oTrequestTypeId"],
        otTypeId: json["otTypeId"],
        date: json["date"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        otDescription: json["otDescription"],
        approveBy: json["approveBy"],
        createBy: json["createBy"],
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "oTrequestTypeId": oTrequestTypeId,
        "otTypeId": otTypeId,
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
        "otDescription": otDescription,
        "approveBy": approveBy,
        "createBy": createBy,
      };
}
