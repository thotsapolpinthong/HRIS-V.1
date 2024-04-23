import 'dart:convert';

TriperTypeDropdownModel triperTypeDropdownModelFromJson(String str) =>
    TriperTypeDropdownModel.fromJson(json.decode(str));

String triperTypeDropdownModelToJson(TriperTypeDropdownModel data) =>
    json.encode(data.toJson());

class TriperTypeDropdownModel {
  List<TriperTypeDatum> triperTypeData;
  String message;
  bool status;

  TriperTypeDropdownModel({
    required this.triperTypeData,
    required this.message,
    required this.status,
  });

  factory TriperTypeDropdownModel.fromJson(Map<String, dynamic> json) =>
      TriperTypeDropdownModel(
        triperTypeData: List<TriperTypeDatum>.from(
            json["triperTypeData"].map((x) => TriperTypeDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "triperTypeData":
            List<dynamic>.from(triperTypeData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class TriperTypeDatum {
  String triperTypeId;
  String triperTypeName;

  TriperTypeDatum({
    required this.triperTypeId,
    required this.triperTypeName,
  });

  factory TriperTypeDatum.fromJson(Map<String, dynamic> json) =>
      TriperTypeDatum(
        triperTypeId: json["triperTypeId"],
        triperTypeName: json["triperTypeName"],
      );

  Map<String, dynamic> toJson() => {
        "triperTypeId": triperTypeId,
        "triperTypeName": triperTypeName,
      };
}
