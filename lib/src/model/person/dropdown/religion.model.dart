// To parse this JSON data, do
//
//     final religionModel = religionModelFromJson(jsonString);

import 'dart:convert';

ReligionModel religionModelFromJson(String str) =>
    ReligionModel.fromJson(json.decode(str));

String religionModelToJson(ReligionModel data) => json.encode(data.toJson());

class ReligionModel {
  List<ReligionDatum> religionData;
  String message;
  bool status;

  ReligionModel({
    required this.religionData,
    required this.message,
    required this.status,
  });

  factory ReligionModel.fromJson(Map<String, dynamic> json) => ReligionModel(
        religionData: List<ReligionDatum>.from(
            json["religionData"].map((x) => ReligionDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "religionData": List<dynamic>.from(religionData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class ReligionDatum {
  String religionId;
  String religionTh;
  dynamic religionEn;

  ReligionDatum({
    required this.religionId,
    required this.religionTh,
    required this.religionEn,
  });

  factory ReligionDatum.fromJson(Map<String, dynamic> json) => ReligionDatum(
        religionId: json["religionId"],
        religionTh: json["religionNameTh"],
        religionEn: json["religionNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "religionId": religionId,
        "religionNameTh": religionTh,
        "religionNameEn": religionEn,
      };
}
