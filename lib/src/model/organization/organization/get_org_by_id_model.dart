import 'dart:convert';

GetOrganizationByIdModel getOrganizationByIdModelFromJson(String str) =>
    GetOrganizationByIdModel.fromJson(json.decode(str));

String getOrganizationByIdModelToJson(GetOrganizationByIdModel data) =>
    json.encode(data.toJson());

class GetOrganizationByIdModel {
  OrganizationData organizationData;
  String message;
  bool status;

  GetOrganizationByIdModel({
    required this.organizationData,
    required this.message,
    required this.status,
  });

  factory GetOrganizationByIdModel.fromJson(Map<String, dynamic> json) =>
      GetOrganizationByIdModel(
        organizationData: OrganizationData.fromJson(json["organizationData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "organizationData": organizationData.toJson(),
        "message": message,
        "status": status,
      };
}

class OrganizationData {
  String organizationId;
  DepartMentData departMentData;
  ParentOrganizationNodeData parentOrganizationNodeData;
  ParentOrganizationNodeData parentOrganizationBusinessNodeData;
  OrganizationTypeData organizationTypeData;
  String organizationStatus;
  String validFrom;
  String endDate;

  OrganizationData({
    required this.organizationId,
    required this.departMentData,
    required this.parentOrganizationNodeData,
    required this.parentOrganizationBusinessNodeData,
    required this.organizationTypeData,
    required this.organizationStatus,
    required this.validFrom,
    required this.endDate,
  });

  factory OrganizationData.fromJson(Map<String, dynamic> json) =>
      OrganizationData(
        organizationId: json["organizationId"],
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
  String organizationName;

  ParentOrganizationNodeData({
    required this.organizationId,
    required this.organizationName,
  });

  factory ParentOrganizationNodeData.fromJson(Map<String, dynamic> json) =>
      ParentOrganizationNodeData(
        organizationId: json["organizationId"],
        organizationName: json["organizationName"],
      );

  Map<String, dynamic> toJson() => {
        "organizationId": organizationId,
        "organizationName": organizationName,
      };
}
