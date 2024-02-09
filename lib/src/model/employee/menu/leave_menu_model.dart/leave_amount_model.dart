import 'dart:convert';

LeaveRequestAmountModel leaveRequestAmountModelFromJson(String str) =>
    LeaveRequestAmountModel.fromJson(json.decode(str));

String leaveRequestAmountModelToJson(LeaveRequestAmountModel data) =>
    json.encode(data.toJson());

class LeaveRequestAmountModel {
  List<LeaveRequestDatum> leaveRequestData;
  String message;
  bool status;

  LeaveRequestAmountModel({
    required this.leaveRequestData,
    required this.message,
    required this.status,
  });

  factory LeaveRequestAmountModel.fromJson(Map<String, dynamic> json) =>
      LeaveRequestAmountModel(
        leaveRequestData: List<LeaveRequestDatum>.from(
            json["leaveRequestData"].map((x) => LeaveRequestDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "leaveRequestData":
            List<dynamic>.from(leaveRequestData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class LeaveRequestDatum {
  LeaveTypeData leaveTypeData;
  String leaveAmount;

  LeaveRequestDatum({
    required this.leaveTypeData,
    required this.leaveAmount,
  });

  factory LeaveRequestDatum.fromJson(Map<String, dynamic> json) =>
      LeaveRequestDatum(
        leaveTypeData: LeaveTypeData.fromJson(json["leaveTypeData"]),
        leaveAmount: json["leaveAmount"],
      );

  Map<String, dynamic> toJson() => {
        "leaveTypeData": leaveTypeData.toJson(),
        "leaveAmount": leaveAmount,
      };
}

class LeaveTypeData {
  String leaveTypeId;
  String leaveTypeNameTh;

  LeaveTypeData({
    required this.leaveTypeId,
    required this.leaveTypeNameTh,
  });

  factory LeaveTypeData.fromJson(Map<String, dynamic> json) => LeaveTypeData(
        leaveTypeId: json["leaveTypeId"],
        leaveTypeNameTh: json["leaveTypeNameTh"],
      );

  Map<String, dynamic> toJson() => {
        "leaveTypeId": leaveTypeId,
        "leaveTypeNameTh": leaveTypeNameTh,
      };
}
