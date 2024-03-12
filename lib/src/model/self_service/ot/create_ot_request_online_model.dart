import 'dart:convert';

CreateOtRequestModel createOtRequestModelFromJson(String str) =>
    CreateOtRequestModel.fromJson(json.decode(str));

String createOtRequestModelToJson(CreateOtRequestModel data) =>
    json.encode(data.toJson());

class CreateOtRequestModel {
  String employeeId;
  String oTrequestTypeId;
  String otTypeId;
  String date;
  String startTime;
  String endTime;
  String otDescription;
  String createBy;

  CreateOtRequestModel({
    required this.employeeId,
    required this.oTrequestTypeId,
    required this.otTypeId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.otDescription,
    required this.createBy,
  });

  factory CreateOtRequestModel.fromJson(Map<String, dynamic> json) =>
      CreateOtRequestModel(
        employeeId: json["employeeId"],
        oTrequestTypeId: json["oTrequestTypeId"],
        otTypeId: json["otTypeId"],
        date: json["date"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        otDescription: json["otDescription"],
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
        "createBy": createBy,
      };
}
