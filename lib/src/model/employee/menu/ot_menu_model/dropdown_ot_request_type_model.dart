import 'dart:convert';

OverTimeRequestTypeModel overTimeRequestTypeModelFromJson(String str) =>
    OverTimeRequestTypeModel.fromJson(json.decode(str));

String overTimeRequestTypeModelToJson(OverTimeRequestTypeModel data) =>
    json.encode(data.toJson());

class OverTimeRequestTypeModel {
  List<OverTimeRequestTypeDatum> overTimeRequestTypeData;
  String message;
  bool status;

  OverTimeRequestTypeModel({
    required this.overTimeRequestTypeData,
    required this.message,
    required this.status,
  });

  factory OverTimeRequestTypeModel.fromJson(Map<String, dynamic> json) =>
      OverTimeRequestTypeModel(
        overTimeRequestTypeData: List<OverTimeRequestTypeDatum>.from(
            json["overTimeRequestTypeData"]
                .map((x) => OverTimeRequestTypeDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "overTimeRequestTypeData":
            List<dynamic>.from(overTimeRequestTypeData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class OverTimeRequestTypeDatum {
  String otRequestTypeId;
  String oTrequestTypeName;

  OverTimeRequestTypeDatum({
    required this.otRequestTypeId,
    required this.oTrequestTypeName,
  });

  factory OverTimeRequestTypeDatum.fromJson(Map<String, dynamic> json) =>
      OverTimeRequestTypeDatum(
        otRequestTypeId: json["otRequestTypeId"],
        oTrequestTypeName: json["oTrequestTypeName"],
      );

  Map<String, dynamic> toJson() => {
        "otRequestTypeId": otRequestTypeId,
        "oTrequestTypeName": oTrequestTypeName,
      };
}
