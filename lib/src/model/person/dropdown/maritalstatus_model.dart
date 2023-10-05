// To parse this JSON data, do
//
//     final maritalStatusModel = maritalStatusModelFromJson(jsonString);

import 'dart:convert';

MaritalStatusModel maritalStatusModelFromJson(String str) =>
    MaritalStatusModel.fromJson(json.decode(str));

String maritalStatusModelToJson(MaritalStatusModel data) =>
    json.encode(data.toJson());

class MaritalStatusModel {
  List<MaritalStatusDatum> maritalStatusData;
  String message;
  bool status;

  MaritalStatusModel({
    required this.maritalStatusData,
    required this.message,
    required this.status,
  });

  factory MaritalStatusModel.fromJson(Map<String, dynamic> json) =>
      MaritalStatusModel(
        maritalStatusData: List<MaritalStatusDatum>.from(
            json["maritalStatusData"]
                .map((x) => MaritalStatusDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "maritalStatusData":
            List<dynamic>.from(maritalStatusData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class MaritalStatusDatum {
  String maritalStatusId;
  String maritalStatusName;

  MaritalStatusDatum({
    required this.maritalStatusId,
    required this.maritalStatusName,
  });

  factory MaritalStatusDatum.fromJson(Map<String, dynamic> json) =>
      MaritalStatusDatum(
        maritalStatusId: json["maritalStatusId"],
        maritalStatusName: json["maritalStatusNameTh"],
      );

  Map<String, dynamic> toJson() => {
        "maritalStatusId": maritalStatusId,
        "maritalStatusNameTh": maritalStatusName,
      };
}
