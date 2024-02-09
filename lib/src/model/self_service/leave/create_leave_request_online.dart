import 'dart:convert';

LeaveQuotaOnlineByEmployeeModel leaveQuotaOnlineByEmployeeModelFromJson(
        String str) =>
    LeaveQuotaOnlineByEmployeeModel.fromJson(json.decode(str));

String leaveQuotaOnlineByEmployeeModelToJson(
        LeaveQuotaOnlineByEmployeeModel data) =>
    json.encode(data.toJson());

class LeaveQuotaOnlineByEmployeeModel {
  String employeeId;
  String leaveTypeId;
  List<String> leaveDate;
  String startTime;
  String endTime;
  String leaveDescription;
  String createBy;

  LeaveQuotaOnlineByEmployeeModel({
    required this.employeeId,
    required this.leaveTypeId,
    required this.leaveDate,
    required this.startTime,
    required this.endTime,
    required this.leaveDescription,
    required this.createBy,
  });

  factory LeaveQuotaOnlineByEmployeeModel.fromJson(Map<String, dynamic> json) =>
      LeaveQuotaOnlineByEmployeeModel(
        employeeId: json["employeeId"],
        leaveTypeId: json["leaveTypeId"],
        leaveDate: List<String>.from(json["leaveDate"].map((x) => x)),
        startTime: json["startTime"],
        endTime: json["endTime"],
        leaveDescription: json["leaveDescription"],
        createBy: json["createBy"],
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "leaveTypeId": leaveTypeId,
        "leaveDate": List<dynamic>.from(leaveDate.map((x) => x)),
        "startTime": startTime,
        "endTime": endTime,
        "leaveDescription": leaveDescription,
        "createBy": createBy,
      };
}
