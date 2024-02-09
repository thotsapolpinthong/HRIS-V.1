import 'dart:convert';

LeaveRequestDataModel leaveRequestDataModelFromJson(String str) =>
    LeaveRequestDataModel.fromJson(json.decode(str));

String leaveRequestDataModelToJson(LeaveRequestDataModel data) =>
    json.encode(data.toJson());

class LeaveRequestDataModel {
  LeaveRequestData leaveRequestData;
  String message;
  bool status;

  LeaveRequestDataModel({
    required this.leaveRequestData,
    required this.message,
    required this.status,
  });

  factory LeaveRequestDataModel.fromJson(Map<String, dynamic> json) =>
      LeaveRequestDataModel(
        leaveRequestData: LeaveRequestData.fromJson(json["leaveRequestData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "leaveRequestData": leaveRequestData.toJson(),
        "message": message,
        "status": status,
      };
}

class LeaveRequestData {
  String leaveRequestId;
  String employeeId;
  String personId;
  String firstName;
  String lastName;
  String positionId;
  String positionName;
  String departmentId;
  String departmentName;
  LeaveTypeData leaveTypeData;
  String leaveQuota;
  List<String> leaveDate;
  String startTime;
  String endTime;
  String leaveAmount;
  String leaveDecription;
  String status;

  LeaveRequestData({
    required this.leaveRequestId,
    required this.employeeId,
    required this.personId,
    required this.firstName,
    required this.lastName,
    required this.positionId,
    required this.positionName,
    required this.departmentId,
    required this.departmentName,
    required this.leaveTypeData,
    required this.leaveQuota,
    required this.leaveDate,
    required this.startTime,
    required this.endTime,
    required this.leaveAmount,
    required this.leaveDecription,
    required this.status,
  });

  factory LeaveRequestData.fromJson(Map<String, dynamic> json) =>
      LeaveRequestData(
        leaveRequestId: json["leaveRequestId"],
        employeeId: json["employeeId"],
        personId: json["personId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        positionId: json["positionId"],
        positionName: json["positionName"],
        departmentId: json["departmentId"],
        departmentName: json["departmentName"],
        leaveTypeData: LeaveTypeData.fromJson(json["leaveTypeData"]),
        leaveQuota: json["leaveQuota"],
        leaveDate: List<String>.from(json["leaveDate"].map((x) => x)),
        startTime: json["startTime"],
        endTime: json["endTime"],
        leaveAmount: json["leaveAmount"],
        leaveDecription: json["leaveDecription"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "leaveRequestId": leaveRequestId,
        "employeeId": employeeId,
        "personId": personId,
        "firstName": firstName,
        "lastName": lastName,
        "positionId": positionId,
        "positionName": positionName,
        "departmentId": departmentId,
        "departmentName": departmentName,
        "leaveTypeData": leaveTypeData.toJson(),
        "leaveQuota": leaveQuota,
        "leaveDate": List<dynamic>.from(leaveDate.map((x) => x)),
        "startTime": startTime,
        "endTime": endTime,
        "leaveAmount": leaveAmount,
        "leaveDecription": leaveDecription,
        "status": status,
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
