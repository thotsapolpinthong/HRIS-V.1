import 'dart:convert';

ManualWorkdateRejectModel manualWorkdateRejectModelFromJson(String str) =>
    ManualWorkdateRejectModel.fromJson(json.decode(str));

String manualWorkdateRejectModelToJson(ManualWorkdateRejectModel data) =>
    json.encode(data.toJson());

class ManualWorkdateRejectModel {
  String manualWorkDateRequestId;
  String rejectBy;
  String comment;

  ManualWorkdateRejectModel({
    required this.manualWorkDateRequestId,
    required this.rejectBy,
    required this.comment,
  });

  factory ManualWorkdateRejectModel.fromJson(Map<String, dynamic> json) =>
      ManualWorkdateRejectModel(
        manualWorkDateRequestId: json["manualWorkDateRequestId"],
        rejectBy: json["rejectBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "manualWorkDateRequestId": manualWorkDateRequestId,
        "rejectBy": rejectBy,
        "comment": comment,
      };
}
