import 'dart:convert';

DropDownParentOrgModel dropDownParentOrgModelFromJson(String str) =>
    DropDownParentOrgModel.fromJson(json.decode(str));

String dropDownParentOrgModelToJson(DropDownParentOrgModel data) =>
    json.encode(data.toJson());

class DropDownParentOrgModel {
  List<OrganizationData> organizationData;
  String message;
  bool status;

  DropDownParentOrgModel({
    required this.organizationData,
    required this.message,
    required this.status,
  });

  factory DropDownParentOrgModel.fromJson(Map<String, dynamic> json) =>
      DropDownParentOrgModel(
        organizationData: List<OrganizationData>.from(
            json["organizationData"].map((x) => OrganizationData.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "organizationData":
            List<dynamic>.from(organizationData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class OrganizationData {
  String organizationId;
  String organizationCode;
  String organizationName;

  OrganizationData({
    required this.organizationId,
    required this.organizationCode,
    required this.organizationName,
  });

  factory OrganizationData.fromJson(Map<String, dynamic> json) =>
      OrganizationData(
        organizationId: json["organizationId"],
        organizationCode: json["organizationCode"],
        organizationName: json["organizationName"],
      );

  Map<String, dynamic> toJson() => {
        "organizationId": organizationId,
        "organizationCode": organizationCode,
        "organizationName": organizationName,
      };
}
