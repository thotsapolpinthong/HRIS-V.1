import 'dart:convert';

CreatePermissionModel createPermissionModelFromJson(String str) =>
    CreatePermissionModel.fromJson(json.decode(str));

String createPermissionModelToJson(CreatePermissionModel data) =>
    json.encode(data.toJson());

class CreatePermissionModel {
  String permissionName;
  String createBy;

  CreatePermissionModel({
    required this.permissionName,
    required this.createBy,
  });

  factory CreatePermissionModel.fromJson(Map<String, dynamic> json) =>
      CreatePermissionModel(
        permissionName: json["permissionName"],
        createBy: json["createBy"],
      );

  Map<String, dynamic> toJson() => {
        "permissionName": permissionName,
        "createBy": createBy,
      };
}
