// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginData loginData;
  String message;
  bool status;

  LoginModel({
    required this.loginData,
    required this.message,
    required this.status,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        loginData: LoginData.fromJson(json["loginData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "loginData": loginData.toJson(),
        "message": message,
        "status": status,
      };
}

class LoginData {
  String personId;
  String employeeId;
  String departmentCode;
  String token;

  LoginData({
    required this.personId,
    required this.employeeId,
    required this.departmentCode,
    required this.token,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        personId: json["personId"],
        employeeId: json["employeeId"],
        departmentCode: json["departmentCode"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "personId": personId,
        "employeeId": employeeId,
        "departmentCode": departmentCode,
        "token": token,
      };
}
