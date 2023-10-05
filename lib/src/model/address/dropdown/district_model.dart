// To parse this JSON data, do
//
//     final districtModel = districtModelFromJson(jsonString);

import 'dart:convert';

DistrictModel districtModelFromJson(String str) =>
    DistrictModel.fromJson(json.decode(str));

String districtModelToJson(DistrictModel data) => json.encode(data.toJson());

class DistrictModel {
  List<DistrictDatum> districtData;
  String message;
  bool status;

  DistrictModel({
    required this.districtData,
    required this.message,
    required this.status,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
        districtData: List<DistrictDatum>.from(
            json["districtData"].map((x) => DistrictDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "districtData": List<dynamic>.from(districtData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class DistrictDatum {
  String districtId;
  String provinceId;
  String districtNameTh;
  String districtNameEn;

  DistrictDatum({
    required this.districtId,
    required this.provinceId,
    required this.districtNameTh,
    required this.districtNameEn,
  });

  factory DistrictDatum.fromJson(Map<String, dynamic> json) => DistrictDatum(
        districtId: json["districtId"],
        provinceId: json["provinceId"],
        districtNameTh: json["districtNameTh"],
        districtNameEn: json["districtNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "districtId": districtId,
        "provinceId": provinceId,
        "districtNameTh": districtNameTh,
        "districtNameEn": districtNameEn,
      };
}
