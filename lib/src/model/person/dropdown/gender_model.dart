//
//     final genderModel = genderModelFromJson(jsonString);

import 'dart:convert';

GenderModel genderModelFromJson(String str) =>
    GenderModel.fromJson(json.decode(str));

String genderModelToJson(GenderModel data) => json.encode(data.toJson());

class GenderModel {
  List<GenderDatum> genderData;
  String message;
  bool status;

  GenderModel({
    required this.genderData,
    required this.message,
    required this.status,
  });

  factory GenderModel.fromJson(Map<String, dynamic> json) => GenderModel(
        genderData: List<GenderDatum>.from(
            json["genderData"].map((x) => GenderDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "genderData": List<dynamic>.from(genderData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class GenderDatum {
  String genderId;
  String genderTh;
  String genderEn;

  GenderDatum({
    required this.genderId,
    required this.genderTh,
    required this.genderEn,
  });

  factory GenderDatum.fromJson(Map<String, dynamic> json) => GenderDatum(
        genderId: json["genderId"],
        genderTh: json["genderNameTh"],
        genderEn: json["genderNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "genderId": genderId,
        "genderNameTh": genderTh,
        "genderNameEn": genderEn,
      };
}
