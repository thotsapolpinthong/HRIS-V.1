// To parse this JSON data, do
//
//     final workdateSpaecialModel = workdateSpaecialModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

WorkdateSpaecialModel workdateSpaecialModelFromJson(String str) =>
    WorkdateSpaecialModel.fromJson(json.decode(str));

String workdateSpaecialModelToJson(WorkdateSpaecialModel data) =>
    json.encode(data.toJson());

class WorkdateSpaecialModel {
  List<WorkDateSpecialDatum> workDateSpecialData;
  String message;
  bool status;

  WorkdateSpaecialModel({
    required this.workDateSpecialData,
    required this.message,
    required this.status,
  });

  factory WorkdateSpaecialModel.fromJson(Map<String, dynamic> json) =>
      WorkdateSpaecialModel(
        workDateSpecialData: List<WorkDateSpecialDatum>.from(
            json["workDateSpecialData"]
                .map((x) => WorkDateSpecialDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "workDateSpecialData":
            List<dynamic>.from(workDateSpecialData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class WorkDateSpecialDatum {
  int id;
  DateTime date;
  int shiftId;
  String endTime;
  bool status;

  WorkDateSpecialDatum({
    required this.id,
    required this.date,
    required this.shiftId,
    required this.endTime,
    required this.status,
  });

  factory WorkDateSpecialDatum.fromJson(Map<String, dynamic> json) =>
      WorkDateSpecialDatum(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        shiftId: json["shiftId"],
        endTime: json["endTime"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "shiftId": shiftId,
        "endTime": endTime,
        "status": status,
      };
}
