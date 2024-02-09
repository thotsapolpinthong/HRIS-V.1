import 'dart:convert';

LeaveApproveModel leaveApproveModelFromJson(String str) =>
    LeaveApproveModel.fromJson(json.decode(str));

String leaveApproveModelToJson(LeaveApproveModel data) =>
    json.encode(data.toJson());

class LeaveApproveModel {
  String leaveRequestId;
  String approveBy;

  LeaveApproveModel({
    required this.leaveRequestId,
    required this.approveBy,
  });

  factory LeaveApproveModel.fromJson(Map<String, dynamic> json) =>
      LeaveApproveModel(
        leaveRequestId: json["leaveRequestId"],
        approveBy: json["approveBy"],
      );

  Map<String, dynamic> toJson() => {
        "leaveRequestId": leaveRequestId,
        "approveBy": approveBy,
      };
}

LeaveRejectModel leaveRejectModelFromJson(String str) =>
    LeaveRejectModel.fromJson(json.decode(str));

String leaveRejectModelToJson(LeaveRejectModel data) =>
    json.encode(data.toJson());

class LeaveRejectModel {
  String leaveRequestId;
  String rejectBy;
  String comment;

  LeaveRejectModel({
    required this.leaveRequestId,
    required this.rejectBy,
    required this.comment,
  });

  factory LeaveRejectModel.fromJson(Map<String, dynamic> json) =>
      LeaveRejectModel(
        leaveRequestId: json["leaveRequestId"],
        rejectBy: json["rejectBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "leaveRequestId": leaveRequestId,
        "rejectBy": rejectBy,
        "comment": comment,
      };
}
