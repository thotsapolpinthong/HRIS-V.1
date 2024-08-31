import 'dart:convert';

PermissionModel permissionModelFromJson(String str) =>
    PermissionModel.fromJson(json.decode(str));

String permissionModelToJson(PermissionModel data) =>
    json.encode(data.toJson());

class PermissionModel {
  List<PermissionDatum> permissionData;
  String message;
  bool status;

  PermissionModel({
    required this.permissionData,
    required this.message,
    required this.status,
  });

  factory PermissionModel.fromJson(Map<String, dynamic> json) =>
      PermissionModel(
        permissionData: List<PermissionDatum>.from(
            json["permissionData"].map((x) => PermissionDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "permissionData":
            List<dynamic>.from(permissionData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class PermissionDatum {
  String permissionId;
  String permissionName;

  PermissionDatum({
    required this.permissionId,
    required this.permissionName,
  });

  factory PermissionDatum.fromJson(Map<String, dynamic> json) =>
      PermissionDatum(
        permissionId: json["permissionId"],
        permissionName: json["permissionName"],
      );

  Map<String, dynamic> toJson() => {
        "permissionId": permissionId,
        "permissionName": permissionName,
      };
}
