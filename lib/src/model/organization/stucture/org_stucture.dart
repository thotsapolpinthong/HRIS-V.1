import 'dart:convert';

GetOrganizationStuctureModel getOrganizationStuctureModelFromJson(String str) =>
    GetOrganizationStuctureModel.fromJson(json.decode(str));

String getOrganizationStuctureModelToJson(GetOrganizationStuctureModel data) =>
    json.encode(data.toJson());

class GetOrganizationStuctureModel {
  String organizationId;
  String department;
  String organizationParentId;
  List<GetOrganizationStuctureModel> children;
  List<dynamic> positionOrganization;

  GetOrganizationStuctureModel({
    required this.organizationId,
    required this.department,
    required this.organizationParentId,
    required this.children,
    required this.positionOrganization,
  });

  factory GetOrganizationStuctureModel.fromJson(Map<String, dynamic> json) =>
      GetOrganizationStuctureModel(
        organizationId: json["organizationId"],
        department: json["department"],
        organizationParentId: json["organizationParentId"],
        children: List<GetOrganizationStuctureModel>.from(json["children"]
            .map((x) => GetOrganizationStuctureModel.fromJson(x))),
        positionOrganization:
            List<dynamic>.from(json["positionOrganization"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "organizationId": organizationId,
        "department": department,
        "organizationParentId": organizationParentId,
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
        "positionOrganization":
            List<dynamic>.from(positionOrganization.map((x) => x)),
      };
}
