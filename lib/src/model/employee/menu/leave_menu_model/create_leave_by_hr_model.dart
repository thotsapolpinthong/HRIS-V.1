import 'dart:convert';

LeaveRequestHrModel leaveRequestHrModelFromJson(String str) =>
    LeaveRequestHrModel.fromJson(json.decode(str));

String leaveRequestHrModelToJson(LeaveRequestHrModel data) =>
    json.encode(data.toJson());

class LeaveRequestHrModel {
  String employeeId;
  String leaveTypeId;
  List<String> leaveDate;
  String startTime;
  String endTime;
  String leaveDescription;
  String approveBy;
  String createBy;

  LeaveRequestHrModel({
    required this.employeeId,
    required this.leaveTypeId,
    required this.leaveDate,
    required this.startTime,
    required this.endTime,
    required this.leaveDescription,
    required this.approveBy,
    required this.createBy,
  });

  factory LeaveRequestHrModel.fromJson(Map<String, dynamic> json) =>
      LeaveRequestHrModel(
        employeeId: json["employeeId"],
        leaveTypeId: json["leaveTypeId"],
        leaveDate: List<String>.from(json["leaveDate"].map((x) => x)),
        startTime: json["startTime"],
        endTime: json["endTime"],
        leaveDescription: json["leaveDescription"],
        approveBy: json["approveBy"],
        createBy: json["createBy"],
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "leaveTypeId": leaveTypeId,
        "leaveDate": List<dynamic>.from(leaveDate.map((x) => x)),
        "startTime": startTime,
        "endTime": endTime,
        "leaveDescription": leaveDescription,
        "approveBy": approveBy,
        "createBy": createBy,
      };
}
