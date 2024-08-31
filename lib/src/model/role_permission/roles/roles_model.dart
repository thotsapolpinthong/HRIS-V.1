import 'dart:convert';

RolesModel rolesModelFromJson(String str) =>
    RolesModel.fromJson(json.decode(str));

String rolesModelToJson(RolesModel data) => json.encode(data.toJson());

class RolesModel {
  List<RoleDatum> roleData;
  String message;
  bool status;

  RolesModel({
    required this.roleData,
    required this.message,
    required this.status,
  });

  factory RolesModel.fromJson(Map<String, dynamic> json) => RolesModel(
        roleData: List<RoleDatum>.from(
            json["roleData"].map((x) => RoleDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "roleData": List<dynamic>.from(roleData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class RoleDatum {
  String roleId;
  String roleName;

  RoleDatum({
    required this.roleId,
    required this.roleName,
  });

  factory RoleDatum.fromJson(Map<String, dynamic> json) => RoleDatum(
        roleId: json["roleId"],
        roleName: json["roleName"],
      );

  Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "roleName": roleName,
      };
}
