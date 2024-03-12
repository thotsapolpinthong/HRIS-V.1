// To parse this JSON data, do
//
//     final userInfoDateModel = userInfoDateModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserInfoDateModel userInfoDateModelFromJson(String str) =>
    UserInfoDateModel.fromJson(json.decode(str));

String userInfoDateModelToJson(UserInfoDateModel data) =>
    json.encode(data.toJson());

class UserInfoDateModel {
  UserInfoData userInfoData;
  String message;
  bool status;

  UserInfoDateModel({
    required this.userInfoData,
    required this.message,
    required this.status,
  });

  factory UserInfoDateModel.fromJson(Map<String, dynamic> json) =>
      UserInfoDateModel(
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
  WorkTimeData workTimeData;

  UserInfoData({
    required this.userId,
    required this.workTimeData,
  });

  factory UserInfoData.fromJson(Map<String, dynamic> json) => UserInfoData(
        userId: json["userId"],
        workTimeData: WorkTimeData.fromJson(json["workTimeData"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "workTimeData": workTimeData.toJson(),
      };
}

class WorkTimeData {
  String date;
  String checkInTime;
  String checkOutTime;

  WorkTimeData({
    required this.date,
    required this.checkInTime,
    required this.checkOutTime,
  });

  factory WorkTimeData.fromJson(Map<String, dynamic> json) => WorkTimeData(
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
