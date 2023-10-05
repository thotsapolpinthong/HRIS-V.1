import 'dart:convert';

ProvinceModel provinceModelFromJson(String str) =>
    ProvinceModel.fromJson(json.decode(str));

String provinceModelToJson(ProvinceModel data) => json.encode(data.toJson());

class ProvinceModel {
  List<ProvinceDatum> provinceData;
  String message;
  bool status;

  ProvinceModel({
    required this.provinceData,
    required this.message,
    required this.status,
  });

  factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
        provinceData: List<ProvinceDatum>.from(
            json["provinceData"].map((x) => ProvinceDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "provinceData": List<dynamic>.from(provinceData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class ProvinceDatum {
  String provinceId;
  String regionId;
  String provinceNameTh;
  String provinceNameEn;

  ProvinceDatum({
    required this.provinceId,
    required this.regionId,
    required this.provinceNameTh,
    required this.provinceNameEn,
  });

  factory ProvinceDatum.fromJson(Map<String, dynamic> json) => ProvinceDatum(
        provinceId: json["provinceId"],
        regionId: json["regionId"],
        provinceNameTh: json["provinceNameTh"],
        provinceNameEn: json["provinceNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "provinceId": provinceId,
        "regionId": regionId,
        "provinceNameTh": provinceNameTh,
        "provinceNameEn": provinceNameEn,
      };

  static provinceModelFromJson(data) {}
}
