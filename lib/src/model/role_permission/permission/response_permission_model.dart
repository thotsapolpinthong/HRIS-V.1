import 'dart:convert';

ResponsePermissionModel responsePermissionModelFromJson(String str) =>
    ResponsePermissionModel.fromJson(json.decode(str));

String responsePermissionModelToJson(ResponsePermissionModel data) =>
    json.encode(data.toJson());

class ResponsePermissionModel {
  PermissionData permissionData;
  String message;
  bool status;

  ResponsePermissionModel({
    required this.permissionData,
    required this.message,
    required this.status,
  });

  factory ResponsePermissionModel.fromJson(Map<String, dynamic> json) =>
      ResponsePermissionModel(
        permissionData: PermissionData.fromJson(json["permissionData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "permissionData": permissionData.toJson(),
        "message": message,
        "status": status,
      };
}

class PermissionData {
  String permissionId;
  String permissionName;

  PermissionData({
    required this.permissionId,
    required this.permissionName,
  });

  factory PermissionData.fromJson(Map<String, dynamic> json) => PermissionData(
        permissionId: json["permissionId"],
        permissionName: json["permissionName"],
      );

  Map<String, dynamic> toJson() => {
        "permissionId": permissionId,
        "permissionName": permissionName,
      };
}
