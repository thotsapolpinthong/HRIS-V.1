import 'dart:convert';

EditRolePermissionsModel editRolePermissionsModelFromJson(String str) =>
    EditRolePermissionsModel.fromJson(json.decode(str));

String editRolePermissionsModelToJson(EditRolePermissionsModel data) =>
    json.encode(data.toJson());

class EditRolePermissionsModel {
  String roleId;
  List<RolePermissionEdit> rolePermissionAssing;
  String modifiedBy;
  String comment;

  EditRolePermissionsModel({
    required this.roleId,
    required this.rolePermissionAssing,
    required this.modifiedBy,
    required this.comment,
  });

  factory EditRolePermissionsModel.fromJson(Map<String, dynamic> json) =>
      EditRolePermissionsModel(
        roleId: json["roleId"],
        rolePermissionAssing: List<RolePermissionEdit>.from(
            json["rolePermissionAssing"]
                .map((x) => RolePermissionEdit.fromJson(x))),
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "rolePermissionAssing":
            List<dynamic>.from(rolePermissionAssing.map((x) => x.toJson())),
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}

class RolePermissionEdit {
  String rolePermissionId;
  String permissionId;
  bool canRead;
  bool canWrite;
  bool canDelete;

  RolePermissionEdit({
    required this.rolePermissionId,
    required this.permissionId,
    required this.canRead,
    required this.canWrite,
    required this.canDelete,
  });

  factory RolePermissionEdit.fromJson(Map<String, dynamic> json) =>
      RolePermissionEdit(
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
