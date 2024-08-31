import 'dart:convert';

UpdateRolesModel updateRolesModelFromJson(String str) =>
    UpdateRolesModel.fromJson(json.decode(str));

String updateRolesModelToJson(UpdateRolesModel data) =>
    json.encode(data.toJson());

class UpdateRolesModel {
  String roleId;
  String roleName;
  String modifyBy;
  String comment;

  UpdateRolesModel({
    required this.roleId,
    required this.roleName,
    required this.modifyBy,
    required this.comment,
  });

  factory UpdateRolesModel.fromJson(Map<String, dynamic> json) =>
      UpdateRolesModel(
        roleId: json["roleId"],
        roleName: json["roleName"],
        modifyBy: json["modifyBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "roleName": roleName,
        "modifyBy": modifyBy,
        "comment": comment,
      };
}
