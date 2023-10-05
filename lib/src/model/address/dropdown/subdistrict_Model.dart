// To parse this JSON data, do
//
//     final subdistrictModel = subdistrictModelFromJson(jsonString);

import 'dart:convert';

SubdistrictModel subdistrictModelFromJson(String str) =>
    SubdistrictModel.fromJson(json.decode(str));

String subdistrictModelToJson(SubdistrictModel data) =>
    json.encode(data.toJson());

class SubdistrictModel {
  List<SubDistrictDatum> subDistrictData;
  String message;
  bool status;

  SubdistrictModel({
    required this.subDistrictData,
    required this.message,
    required this.status,
  });

  factory SubdistrictModel.fromJson(Map<String, dynamic> json) =>
      SubdistrictModel(
        subDistrictData: List<SubDistrictDatum>.from(
            json["subDistrictData"].map((x) => SubDistrictDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "subDistrictData":
            List<dynamic>.from(subDistrictData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class SubDistrictDatum {
  String subDistrictId;
  String districtId;
  String subDistrictNameTh;
  String subDistrictNameEn;

  SubDistrictDatum({
    required this.subDistrictId,
    required this.districtId,
    required this.subDistrictNameTh,
    required this.subDistrictNameEn,
  });

  factory SubDistrictDatum.fromJson(Map<String, dynamic> json) =>
      SubDistrictDatum(
        subDistrictId: json["subDistrictId"],
        districtId: json["districtId"],
        subDistrictNameTh: json["subDistrictNameTh"],
        subDistrictNameEn: json["subDistrictNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "subDistrictId": subDistrictId,
        "districtId": districtId,
        "subDistrictNameTh": subDistrictNameTh,
        "subDistrictNameEn": subDistrictNameEn,
      };
}
