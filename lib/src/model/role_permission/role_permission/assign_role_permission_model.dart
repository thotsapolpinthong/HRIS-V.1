import 'dart:convert';

AssignRolePermissionsModel assignRolePermissionsModelFromJson(String str) =>
    AssignRolePermissionsModel.fromJson(json.decode(str));

String assignRolePermissionsModelToJson(AssignRolePermissionsModel data) =>
    json.encode(data.toJson());

class AssignRolePermissionsModel {
  String roleId;
  List<RolePermissionAssing> rolePermissionAssing;
  String createBy;

  AssignRolePermissionsModel({
    required this.roleId,
    required this.rolePermissionAssing,
    required this.createBy,
  });

  factory AssignRolePermissionsModel.fromJson(Map<String, dynamic> json) =>
      AssignRolePermissionsModel(
        roleId: json["roleId"],
        rolePermissionAssing: List<RolePermissionAssing>.from(
            json["rolePermissionAssing"]
                .map((x) => RolePermissionAssing.fromJson(x))),
        createBy: json["createBy"],
      );

  Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "rolePermissionAssing":
            List<dynamic>.from(rolePermissionAssing.map((x) => x.toJson())),
        "createBy": createBy,
      };
}

class RolePermissionAssing {
  String permissionId;
  bool canRead;
  bool canWrite;
  bool canDelete;

  RolePermissionAssing({
    required this.permissionId,
    required this.canRead,
    required this.canWrite,
    required this.canDelete,
  });

  factory RolePermissionAssing.fromJson(Map<String, dynamic> json) =>
      RolePermissionAssing(
        permissionId: json["permissionId"],
        canRead: json["canRead"],
        canWrite: json["canWrite"],
        canDelete: json["canDelete"],
      );

  Map<String, dynamic> toJson() => {
        "permissionId": permissionId,
        "canRead": canRead,
        "canWrite": canWrite,
        "canDelete": canDelete,
      };
}
