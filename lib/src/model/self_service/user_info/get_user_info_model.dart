// To parse this JSON data, do
//
//     final userInfoEmployeeModel = userInfoEmployeeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserInfoEmployeeModel userInfoEmployeeModelFromJson(String str) =>
    UserInfoEmployeeModel.fromJson(json.decode(str));

String userInfoEmployeeModelToJson(UserInfoEmployeeModel data) =>
    json.encode(data.toJson());

class UserInfoEmployeeModel {
  UserInfoData userInfoData;
  String message;
  bool status;

  UserInfoEmployeeModel({
    required this.userInfoData,
    required this.message,
    required this.status,
  });

  factory UserInfoEmployeeModel.fromJson(Map<String, dynamic> json) =>
      UserInfoEmployeeModel(
        userInfoData: UserInfoData.fromJson(json["userInfoData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "userInfoData": userInfoData.toJson(),
        "message": message,
        "status": status,
      };
}

class UserInfoData {
  String userId;
  List<WorkTimeDatum> workTimeData;

  UserInfoData({
    required this.userId,
    required this.workTimeData,
  });

  factory UserInfoData.fromJson(Map<String, dynamic> json) => UserInfoData(
        userId: json["userId"],
        workTimeData: List<WorkTimeDatum>.from(
            json["workTimeData"].map((x) => WorkTimeDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "workTimeData": List<dynamic>.from(workTimeData.map((x) => x.toJson())),
      };
}

class WorkTimeDatum {
  String date;
  String checkInTime;
  String checkOutTime;

  WorkTimeDatum({
    required this.date,
    required this.checkInTime,
    required this.checkOutTime,
  });

  factory WorkTimeDatum.fromJson(Map<String, dynamic> json) => WorkTimeDatum(
        date: json["date"],
        checkInTime: json["checkInTime"],
        checkOutTime: json["checkOutTime"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "checkInTime": checkInTime,
        "checkOutTime": checkOutTime,
      };
}
