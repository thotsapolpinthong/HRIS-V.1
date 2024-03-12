import 'dart:convert';

OtApproveModel otApproveModelFromJson(String str) =>
    OtApproveModel.fromJson(json.decode(str));

String otApproveModelToJson(OtApproveModel data) => json.encode(data.toJson());

class OtApproveModel {
  String otRequestId;
  String approveBy;

  OtApproveModel({
    required this.otRequestId,
    required this.approveBy,
  });

  factory OtApproveModel.fromJson(Map<String, dynamic> json) => OtApproveModel(
        otRequestId: json["otRequestId"],
        approveBy: json["approveBy"],
      );

  Map<String, dynamic> toJson() => {
        "otRequestId": otRequestId,
        "approveBy": approveBy,
      };
}
