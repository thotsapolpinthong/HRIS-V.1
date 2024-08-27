import 'dart:convert';

import 'package:hris_app_prototype/src/model/role_permission/permission_model.dart';

RolePermissionModel rolePermissionModelFromJson(String str) =>
    RolePermissionModel.fromJson(json.decode(str));

String rolePermissionModelToJson(RolePermissionModel data) =>
    json.encode(data.toJson());

class RolePermissionModel {
  List<RolePermissionDatum> rolePermissionData;
  String message;
  bool status;

  RolePermissionModel({
    required this.rolePermissionData,
    required this.message,
    required this.status,
  });

  factory RolePermissionModel.fromJson(Map<String, dynamic> json) =>
      RolePermissionModel(
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
  String positionOrganizationId;
  PermissionDatum permissionData;
  bool canRead;
  bool canWrite;
  bool canDelete;

  RolePermissionDatum({
    required this.rolePermissionId,
    required this.positionOrganizationId,
    required this.permissionData,
    required this.canRead,
    required this.canWrite,
    required this.canDelete,
  });

  factory RolePermissionDatum.fromJson(Map<String, dynamic> json) =>
      RolePermissionDatum(
        rolePermissionId: json["rolePermissionId"],
        positionOrganizationId: json["positionOrganizationId"],
        permissionData: PermissionDatum.fromJson(json["permissionData"]),
        canRead: json["canRead"],
        canWrite: json["canWrite"],
        canDelete: json["canDelete"],
      );

  Map<String, dynamic> toJson() => {
        "rolePermissionId": rolePermissionId,
        "positionOrganizationId": positionOrganizationId,
        "permissionData": permissionData.toJson(),
        "canRead": canRead,
        "canWrite": canWrite,
        "canDelete": canDelete,
      };
}
