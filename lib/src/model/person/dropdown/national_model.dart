// To parse this JSON data, do
//
//     final nationalityModel = nationalityModelFromJson(jsonString);
import 'dart:convert';

NationalityModel nationalityModelFromJson(String str) =>
    NationalityModel.fromJson(json.decode(str));

String nationalityModelToJson(NationalityModel data) =>
    json.encode(data.toJson());

class NationalityModel {
  List<NationalityDatum> nationalityData;
  String message;
  bool status;

  NationalityModel({
    required this.nationalityData,
    required this.message,
    required this.status,
  });

  factory NationalityModel.fromJson(Map<String, dynamic> json) =>
      NationalityModel(
        nationalityData: List<NationalityDatum>.from(
            json["nationalityData"].map((x) => NationalityDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "nationalityData":
            List<dynamic>.from(nationalityData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class NationalityDatum {
  String nationalityId;
  String nationalityTh;
  String nationalityEn;

  NationalityDatum({
    required this.nationalityId,
    required this.nationalityTh,
    required this.nationalityEn,
  });

  factory NationalityDatum.fromJson(Map<String, dynamic> json) =>
      NationalityDatum(
        nationalityId: json["nationalityId"],
        nationalityTh: json["nationalityNameTh"],
        nationalityEn: json["nationalityNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "nationalityId": nationalityId,
        "nationalityNameTh": nationalityTh,
        "nationalityNameEn": nationalityEn,
      };
}
