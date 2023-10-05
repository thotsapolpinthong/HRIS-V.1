import 'dart:convert';

VitalStatusModel vitalStatusModelFromJson(String str) =>
    VitalStatusModel.fromJson(json.decode(str));

String vitalStatusModelToJson(VitalStatusModel data) =>
    json.encode(data.toJson());

class VitalStatusModel {
  List<VitalStatusDatum> vitalStatusData;
  String message;
  bool status;

  VitalStatusModel({
    required this.vitalStatusData,
    required this.message,
    required this.status,
  });

  factory VitalStatusModel.fromJson(Map<String, dynamic> json) =>
      VitalStatusModel(
        vitalStatusData: List<VitalStatusDatum>.from(
            json["vitalStatusData"].map((x) => VitalStatusDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "vitalStatusData":
            List<dynamic>.from(vitalStatusData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class VitalStatusDatum {
  String vitalStatusId;
  String vitalStatusName;

  VitalStatusDatum({
    required this.vitalStatusId,
    required this.vitalStatusName,
  });

  factory VitalStatusDatum.fromJson(Map<String, dynamic> json) =>
      VitalStatusDatum(
        vitalStatusId: json["vitalStatusId"],
        vitalStatusName: json["vitalStatusName"],
      );

  Map<String, dynamic> toJson() => {
        "vitalStatusId": vitalStatusId,
        "vitalStatusName": vitalStatusName,
      };
}
