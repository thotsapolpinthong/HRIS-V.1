import 'dart:convert';

DropDownOrgTypeModel dropDownOrgTypeModelFromJson(String str) =>
    DropDownOrgTypeModel.fromJson(json.decode(str));

String dropDownOrgTypeModelToJson(DropDownOrgTypeModel data) =>
    json.encode(data.toJson());

class DropDownOrgTypeModel {
  List<OrganizationTypeDatum> organizationTypeData;
  String message;
  bool status;

  DropDownOrgTypeModel({
    required this.organizationTypeData,
    required this.message,
    required this.status,
  });

  factory DropDownOrgTypeModel.fromJson(Map<String, dynamic> json) =>
      DropDownOrgTypeModel(
        organizationTypeData: List<OrganizationTypeDatum>.from(
            json["organizationTypeData"]
                .map((x) => OrganizationTypeDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "organizationTypeData":
            List<dynamic>.from(organizationTypeData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class OrganizationTypeDatum {
  String organizationTypeId;
  String organizationTypeName;

  OrganizationTypeDatum({
    required this.organizationTypeId,
    required this.organizationTypeName,
  });

  factory OrganizationTypeDatum.fromJson(Map<String, dynamic> json) =>
      OrganizationTypeDatum(
        organizationTypeId: json["organizationTypeId"],
        organizationTypeName: json["organizationTypeName"],
      );

  Map<String, dynamic> toJson() => {
        "organizationTypeId": organizationTypeId,
        "organizationTypeName": organizationTypeName,
      };
}
