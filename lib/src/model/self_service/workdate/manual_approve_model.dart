import 'dart:convert';

ManualWorkdateApproveModel manualWorkdateApproveModelFromJson(String str) =>
    ManualWorkdateApproveModel.fromJson(json.decode(str));

String manualWorkdateApproveModelToJson(ManualWorkdateApproveModel data) =>
    json.encode(data.toJson());

class ManualWorkdateApproveModel {
  String manualWorkDateRequestId;
  String approveBy;

  ManualWorkdateApproveModel({
    required this.manualWorkDateRequestId,
    required this.approveBy,
  });

  factory ManualWorkdateApproveModel.fromJson(Map<String, dynamic> json) =>
      ManualWorkdateApproveModel(
        manualWorkDateRequestId: json["manualWorkDateRequestId"],
        approveBy: json["approveBy"],
      );

  Map<String, dynamic> toJson() => {
        "manualWorkDateRequestId": manualWorkDateRequestId,
        "approveBy": approveBy,
      };
}
