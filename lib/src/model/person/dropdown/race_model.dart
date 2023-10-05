// To parse this JSON data, do
//
//     final raceModel = raceModelFromJson(jsonString);

import 'dart:convert';

RaceModel raceModelFromJson(String str) => RaceModel.fromJson(json.decode(str));

String raceModelToJson(RaceModel data) => json.encode(data.toJson());

class RaceModel {
  List<RaceDatum> raceData;
  String message;
  bool status;

  RaceModel({
    required this.raceData,
    required this.message,
    required this.status,
  });

  factory RaceModel.fromJson(Map<String, dynamic> json) => RaceModel(
        raceData: List<RaceDatum>.from(
            json["raceData"].map((x) => RaceDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "raceData": List<dynamic>.from(raceData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class RaceDatum {
  String raceId;
  String raceTh;
  dynamic raceEn;

  RaceDatum({
    required this.raceId,
    required this.raceTh,
    required this.raceEn,
  });

  factory RaceDatum.fromJson(Map<String, dynamic> json) => RaceDatum(
        raceId: json["raceId"],
        raceTh: json["raceNameTh"],
        raceEn: json["raceNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "raceId": raceId,
        "raceNameTh": raceTh,
        "raceNameEn": raceEn,
      };
}
