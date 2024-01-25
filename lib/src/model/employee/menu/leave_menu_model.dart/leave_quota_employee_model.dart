import 'dart:convert';

LeaveQuotaByEmployeeModel leaveQuotaByEmployeeModelFromJson(String str) =>
    LeaveQuotaByEmployeeModel.fromJson(json.decode(str));

String leaveQuotaByEmployeeModelToJson(LeaveQuotaByEmployeeModel data) =>
    json.encode(data.toJson());

class LeaveQuotaByEmployeeModel {
  List<LeaveSetupDatum> leaveSetupData;
  String message;
  bool status;

  LeaveQuotaByEmployeeModel({
    required this.leaveSetupData,
    required this.message,
    required this.status,
  });

  factory LeaveQuotaByEmployeeModel.fromJson(Map<String, dynamic> json) =>
      LeaveQuotaByEmployeeModel(
        leaveSetupData: List<LeaveSetupDatum>.from(
            json["leaveSetupData"].map((x) => LeaveSetupDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "leaveSetupData":
            List<dynamic>.from(leaveSetupData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class LeaveSetupDatum {
  String leaveSetupId;
  String employeeId;
  LeaveTypeData leaveTypeData;
  String year;
  String leaveAmount;
  String validFrom;
  String validTo;

  LeaveSetupDatum({
    required this.leaveSetupId,
    required this.employeeId,
    required this.leaveTypeData,
    required this.year,
    required this.leaveAmount,
    required this.validFrom,
    required this.validTo,
  });

  factory LeaveSetupDatum.fromJson(Map<String, dynamic> json) =>
      LeaveSetupDatum(
        leaveSetupId: json["leaveSetupId"],
        employeeId: json["employeeId"],
        leaveTypeData: LeaveTypeData.fromJson(json["leaveTypeData"]),
        year: json["year"],
        leaveAmount: json["leaveAmount"],
        validFrom: json["validFrom"],
        validTo: json["validTo"],
      );

  Map<String, dynamic> toJson() => {
        "leaveSetupId": leaveSetupId,
        "employeeId": employeeId,
        "leaveTypeData": leaveTypeData.toJson(),
        "year": year,
        "leaveAmount": leaveAmount,
        "validFrom": validFrom,
        "validTo": validTo,
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
