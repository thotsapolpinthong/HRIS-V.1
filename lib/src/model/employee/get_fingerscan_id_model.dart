import 'dart:convert';

FingerScanModel fingerScanModelFromJson(String str) =>
    FingerScanModel.fromJson(json.decode(str));

String fingerScanModelToJson(FingerScanModel data) =>
    json.encode(data.toJson());

class FingerScanModel {
  String fingerScanId;
  String message;
  bool status;

  FingerScanModel({
    required this.fingerScanId,
    required this.message,
    required this.status,
  });

  factory FingerScanModel.fromJson(Map<String, dynamic> json) =>
      FingerScanModel(
        fingerScanId: json["fingerScanId"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "fingerScanId": fingerScanId,
        "message": message,
        "status": status,
      };
}
