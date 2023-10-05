// To parse this JSON data, do
//
//     final bloodGroupModel = bloodGroupModelFromJson(jsonString);

import 'dart:convert';

BloodGroupModel bloodGroupModelFromJson(String str) =>
    BloodGroupModel.fromJson(json.decode(str));

String bloodGroupModelToJson(BloodGroupModel data) =>
    json.encode(data.toJson());

class BloodGroupModel {
  List<BloodGroupDatum> bloodGroupData;
  String message;
  bool status;

  BloodGroupModel({
    required this.bloodGroupData,
    required this.message,
    required this.status,
  });

  factory BloodGroupModel.fromJson(Map<String, dynamic> json) =>
      BloodGroupModel(
        bloodGroupData: List<BloodGroupDatum>.from(
            json["bloodData"].map((x) => BloodGroupDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  String? get text => null;

  Map<String, dynamic> toJson() => {
        "bloodData": List<dynamic>.from(bloodGroupData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class BloodGroupDatum {
  String bloodId;
  String bloodGroupNameTh;
  String bloodGroupNameEn;

  BloodGroupDatum({
    required this.bloodId,
    required this.bloodGroupNameTh,
    required this.bloodGroupNameEn,
  });

  factory BloodGroupDatum.fromJson(Map<String, dynamic> json) =>
      BloodGroupDatum(
        bloodId: json["bloodId"],
        bloodGroupNameTh: json["bloodNameTh"],
        bloodGroupNameEn: json["bloodNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "bloodId": bloodId,
        "bloodNameTh": bloodGroupNameTh,
        "bloodNameEn": bloodGroupNameEn,
      };
}
