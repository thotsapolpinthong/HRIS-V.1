import 'dart:convert';

OverTimeTypeModel overTimeTypeModelFromJson(String str) =>
    OverTimeTypeModel.fromJson(json.decode(str));

String overTimeTypeModelToJson(OverTimeTypeModel data) =>
    json.encode(data.toJson());

class OverTimeTypeModel {
  List<OverTimeTypeDatum> overTimeTypeData;
  String message;
  bool status;

  OverTimeTypeModel({
    required this.overTimeTypeData,
    required this.message,
    required this.status,
  });

  factory OverTimeTypeModel.fromJson(Map<String, dynamic> json) =>
      OverTimeTypeModel(
        overTimeTypeData: List<OverTimeTypeDatum>.from(
            json["overTimeTypeData"].map((x) => OverTimeTypeDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "overTimeTypeData":
            List<dynamic>.from(overTimeTypeData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class OverTimeTypeDatum {
  String otTypeCode;
  String otTypeName;

  OverTimeTypeDatum({
    required this.otTypeCode,
    required this.otTypeName,
  });

  factory OverTimeTypeDatum.fromJson(Map<String, dynamic> json) =>
      OverTimeTypeDatum(
        otTypeCode: json["otTypeCode"],
        otTypeName: json["otTypeName"],
      );

  Map<String, dynamic> toJson() => {
        "otTypeCode": otTypeCode,
        "otTypeName": otTypeName,
      };
}
