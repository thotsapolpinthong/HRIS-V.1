import 'dart:convert';

GetOrganizationAllModel getOrganizationAllModelFromJson(String str) =>
    GetOrganizationAllModel.fromJson(json.decode(str));

String getOrganizationAllModelToJson(GetOrganizationAllModel data) =>
    json.encode(data.toJson());

class GetOrganizationAllModel {
  List<OrganizationDatum> organizationData;
  String message;
  bool status;

  GetOrganizationAllModel({
    required this.organizationData,
    required this.message,
    required this.status,
  });

  factory GetOrganizationAllModel.fromJson(Map<String, dynamic> json) =>
      GetOrganizationAllModel(
        organizationData: List<OrganizationDatum>.from(
            json["organizationData"].map((x) => OrganizationDatum.fromJson(x))),
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

class OrganizationDatum {
  String organizationId;
  String organizationCode;
  DepartMentData departMentData;
  ParentOrganizationNodeData parentOrganizationNodeData;
  ParentOrganizationNodeData parentOrganizationBusinessNodeData;
  OrganizationTypeData organizationTypeData;
  String organizationStatus;
  String validFrom;
  String endDate;

  OrganizationDatum({
    required this.organizationId,
    required this.organizationCode,
    required this.departMentData,
    required this.parentOrganizationNodeData,
    required this.parentOrganizationBusinessNodeData,
    required this.organizationTypeData,
    required this.organizationStatus,
    required this.validFrom,
    required this.endDate,
  });

  factory OrganizationDatum.fromJson(Map<String, dynamic> json) =>
      OrganizationDatum(
        organizationId: json["organizationId"],
        organizationCode: json["organizationCode"],
        departMentData: DepartMentData.fromJson(json["departMentData"]),
        parentOrganizationNodeData: ParentOrganizationNodeData.fromJson(
            json["parentOrganizationNodeData"]),
        parentOrganizationBusinessNodeData: ParentOrganizationNodeData.fromJson(
            json["parentOrganizationBusinessNodeData"]),
        organizationTypeData:
            OrganizationTypeData.fromJson(json["organizationTypeData"]),
        organizationStatus: json["organizationStatus"],
        validFrom: json["validFrom"],
        endDate: json["endDate"],
      );

  Map<String, dynamic> toJson() => {
        "organizationId": organizationId,
        "organizationCode": organizationCode,
        "departMentData": departMentData.toJson(),
        "parentOrganizationNodeData": parentOrganizationNodeData.toJson(),
        "parentOrganizationBusinessNodeData":
            parentOrganizationBusinessNodeData.toJson(),
        "organizationTypeData": organizationTypeData.toJson(),
        "organizationStatus": organizationStatus,
        "validFrom": validFrom,
        "endDate": endDate,
      };
}

class DepartMentData {
  String deptCode;
  String deptNameEn;
  String deptNameTh;

  DepartMentData({
    required this.deptCode,
    required this.deptNameEn,
    required this.deptNameTh,
  });

  factory DepartMentData.fromJson(Map<String, dynamic> json) => DepartMentData(
        deptCode: json["deptCode"],
        deptNameEn: json["deptNameEn"],
        deptNameTh: json["deptNameTh"],
      );

  Map<String, dynamic> toJson() => {
        "deptCode": deptCode,
        "deptNameEn": deptNameEn,
        "deptNameTh": deptNameTh,
      };
}

class OrganizationTypeData {
  String organizationTypeId;
  String organizationTypeName;

  OrganizationTypeData({
    required this.organizationTypeId,
    required this.organizationTypeName,
  });

  factory OrganizationTypeData.fromJson(Map<String, dynamic> json) =>
      OrganizationTypeData(
        organizationTypeId: json["organizationTypeId"],
        organizationTypeName: json["organizationTypeName"],
      );

  Map<String, dynamic> toJson() => {
        "organizationTypeId": organizationTypeId,
        "organizationTypeName": organizationTypeName,
      };
}

class ParentOrganizationNodeData {
  String organizationId;
  String organizationCode;
  String organizationName;

  ParentOrganizationNodeData({
    required this.organizationId,
    required this.organizationCode,
    required this.organizationName,
  });

  factory ParentOrganizationNodeData.fromJson(Map<String, dynamic> json) =>
      ParentOrganizationNodeData(
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
