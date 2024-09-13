// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'package:hris_app_prototype/src/model/role_permission/role_permission/role_permission_model.dart';
import 'package:hris_app_prototype/src/model/role_permission/roles/roles_model.dart';

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
  RoleDatum role;
  List<RolePermissionDatum> rolePermission;
  String token;

  LoginData({
    required this.personId,
    required this.employeeId,
    required this.departmentCode,
    required this.role,
    required this.rolePermission,
    required this.token,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        personId: json["personId"],
        employeeId: json["employeeId"],
        departmentCode: json["departmentCode"],
        role: RoleDatum.fromJson(json["role"]),
        rolePermission: List<RolePermissionDatum>.from(
            json["rolePermission"].map((x) => RolePermissionDatum.fromJson(x))),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "personId": personId,
        "employeeId": employeeId,
        "departmentCode": departmentCode,
        "role": role.toJson(),
        "rolePermission":
            List<dynamic>.from(rolePermission.map((x) => x.toJson())),
        "token": token,
      };
}
