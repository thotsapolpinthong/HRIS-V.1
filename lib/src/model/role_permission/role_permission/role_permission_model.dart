import 'dart:convert';

RolePermissionsModel rolePermissionsModelFromJson(String str) =>
    RolePermissionsModel.fromJson(json.decode(str));

String rolePermissionsModelToJson(RolePermissionsModel data) =>
    json.encode(data.toJson());

class RolePermissionsModel {
  List<RolePermissionDatum> rolePermissionData;
  String message;
  bool status;

  RolePermissionsModel({
    required this.rolePermissionData,
    required this.message,
    required this.status,
  });

  factory RolePermissionsModel.fromJson(Map<String, dynamic> json) =>
      RolePermissionsModel(
        rolePermissionData: List<RolePermissionDatum>.from(
            json["rolePermissionData"]
                .map((x) => RolePermissionDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "rolePermissionData":
            List<dynamic>.from(rolePermissionData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class RolePermissionDatum {
  String rolePermissionId;
  String roleId;
  PermissionData permissionData;
  bool canRead;
  bool canWrite;
  bool canDelete;

  RolePermissionDatum({
    required this.rolePermissionId,
    required this.roleId,
    required this.permissionData,
    required this.canRead,
    required this.canWrite,
    required this.canDelete,
  });

  factory RolePermissionDatum.fromJson(Map<String, dynamic> json) =>
      RolePermissionDatum(
        rolePermissionId: json["rolePermissionId"],
        roleId: json["roleId"],
        permissionData: PermissionData.fromJson(json["permissionData"]),
        canRead: json["canRead"],
        canWrite: json["canWrite"],
        canDelete: json["canDelete"],
      );

  Map<String, dynamic> toJson() => {
        "rolePermissionId": rolePermissionId,
        "roleId": roleId,
        "permissionData": permissionData.toJson(),
        "canRead": canRead,
        "canWrite": canWrite,
        "canDelete": canDelete,
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
