import 'dart:convert';

CreateRolesModel createRolesModelFromJson(String str) =>
    CreateRolesModel.fromJson(json.decode(str));

String createRolesModelToJson(CreateRolesModel data) =>
    json.encode(data.toJson());

class CreateRolesModel {
  String roleName;
  String createBy;

  CreateRolesModel({
    required this.roleName,
    required this.createBy,
  });

  factory CreateRolesModel.fromJson(Map<String, dynamic> json) =>
      CreateRolesModel(
        roleName: json["roleName"],
        createBy: json["createBy"],
      );

  Map<String, dynamic> toJson() => {
        "roleName": roleName,
        "createBy": createBy,
      };
}
