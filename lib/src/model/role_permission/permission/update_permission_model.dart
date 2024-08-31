import 'dart:convert';

CreatePermissionModel createPermissionModelFromJson(String str) =>
    CreatePermissionModel.fromJson(json.decode(str));

String createPermissionModelToJson(CreatePermissionModel data) =>
    json.encode(data.toJson());

class CreatePermissionModel {
  String positionOrganizationId;
  List<RolePermissionAssing> rolePermissionAssing;
  String modifiedBy;
  String comment;

  CreatePermissionModel({
    required this.positionOrganizationId,
    required this.rolePermissionAssing,
    required this.modifiedBy,
    required this.comment,
  });

  factory CreatePermissionModel.fromJson(Map<String, dynamic> json) =>
      CreatePermissionModel(
        positionOrganizationId: json["positionOrganizationId"],
        rolePermissionAssing: List<RolePermissionAssing>.from(
            json["rolePermissionAssing"]
                .map((x) => RolePermissionAssing.fromJson(x))),
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "positionOrganizationId": positionOrganizationId,
        "rolePermissionAssing":
            List<dynamic>.from(rolePermissionAssing.map((x) => x.toJson())),
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}

class RolePermissionAssing {
  String rolePermissionId;
  String permissionId;
  bool canRead;
  bool canWrite;
  bool canDelete;

  RolePermissionAssing({
    required this.rolePermissionId,
    required this.permissionId,
    required this.canRead,
    required this.canWrite,
    required this.canDelete,
  });

  factory RolePermissionAssing.fromJson(Map<String, dynamic> json) =>
      RolePermissionAssing(
        rolePermissionId: json["rolePermissionId"],
        permissionId: json["permissionId"],
        canRead: json["canRead"],
        canWrite: json["canWrite"],
        canDelete: json["canDelete"],
      );

  Map<String, dynamic> toJson() => {
        "rolePermissionId": rolePermissionId,
        "permissionId": permissionId,
        "canRead": canRead,
        "canWrite": canWrite,
        "canDelete": canDelete,
      };
}
