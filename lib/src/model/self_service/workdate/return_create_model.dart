import 'dart:convert';

ReturnManualWorkDateRequestModel returnManualWorkDateRequestModelFromJson(
        String str) =>
    ReturnManualWorkDateRequestModel.fromJson(json.decode(str));

String returnManualWorkDateRequestModelToJson(
        ReturnManualWorkDateRequestModel data) =>
    json.encode(data.toJson());

class ReturnManualWorkDateRequestModel {
  ManualWorkDateRequestData manualWorkDateRequestData;
  String message;
  bool status;

  ReturnManualWorkDateRequestModel({
    required this.manualWorkDateRequestData,
    required this.message,
    required this.status,
  });

  factory ReturnManualWorkDateRequestModel.fromJson(
          Map<String, dynamic> json) =>
      ReturnManualWorkDateRequestModel(
        manualWorkDateRequestData: ManualWorkDateRequestData.fromJson(
            json["manualWorkDateRequestData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "manualWorkDateRequestData": manualWorkDateRequestData.toJson(),
        "message": message,
        "status": status,
      };
}

class ManualWorkDateRequestData {
  String manualWorkDateRequestId;
  ManualWorkDateTypeData manualWorkDateTypeData;
  String employeeId;
  String firstName;
  String lastName;
  String positionId;
  String positionName;
  String departmentId;
  String departmentName;
  String date;
  String startTime;
  String endTime;
  String decription;
  String status;

  ManualWorkDateRequestData({
    required this.manualWorkDateRequestId,
    required this.manualWorkDateTypeData,
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.positionId,
    required this.positionName,
    required this.departmentId,
    required this.departmentName,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.decription,
    required this.status,
  });

  factory ManualWorkDateRequestData.fromJson(Map<String, dynamic> json) =>
      ManualWorkDateRequestData(
        manualWorkDateRequestId: json["manualWorkDateRequestId"],
        manualWorkDateTypeData:
            ManualWorkDateTypeData.fromJson(json["manualWorkDateTypeData"]),
        employeeId: json["employeeId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        positionId: json["positionId"],
        positionName: json["positionName"],
        departmentId: json["departmentId"],
        departmentName: json["departmentName"],
        date: json["date"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        decription: json["decription"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "manualWorkDateRequestId": manualWorkDateRequestId,
        "manualWorkDateTypeData": manualWorkDateTypeData.toJson(),
        "employeeId": employeeId,
        "firstName": firstName,
        "lastName": lastName,
        "positionId": positionId,
        "positionName": positionName,
        "departmentId": departmentId,
        "departmentName": departmentName,
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
        "decription": decription,
        "status": status,
      };
}

class ManualWorkDateTypeData {
  String manualWorkDateTypeId;
  String manualWorkDateTypeNameTh;

  ManualWorkDateTypeData({
    required this.manualWorkDateTypeId,
    required this.manualWorkDateTypeNameTh,
  });

  factory ManualWorkDateTypeData.fromJson(Map<String, dynamic> json) =>
      ManualWorkDateTypeData(
        manualWorkDateTypeId: json["manualWorkDateTypeId"],
        manualWorkDateTypeNameTh: json["manualWorkDateTypeNameTH"],
      );

  Map<String, dynamic> toJson() => {
        "manualWorkDateTypeId": manualWorkDateTypeId,
        "manualWorkDateTypeNameTH": manualWorkDateTypeNameTh,
      };
}
