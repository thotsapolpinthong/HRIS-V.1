import 'dart:convert';

ResponsePositionOrgModel responsePositionOrgModelFromJson(String str) =>
    ResponsePositionOrgModel.fromJson(json.decode(str));

String responsePositionOrgModelToJson(ResponsePositionOrgModel data) =>
    json.encode(data.toJson());

class ResponsePositionOrgModel {
  PositionOrganizationData positionOrganizationData;
  String message;
  bool status;

  ResponsePositionOrgModel({
    required this.positionOrganizationData,
    required this.message,
    required this.status,
  });

  factory ResponsePositionOrgModel.fromJson(Map<String, dynamic> json) =>
      ResponsePositionOrgModel(
        positionOrganizationData:
            PositionOrganizationData.fromJson(json["positionOrganizationData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "positionOrganizationData": positionOrganizationData.toJson(),
        "message": message,
        "status": status,
      };
}

class PositionOrganizationData {
  String positionOrganizationId;
  PositionData positionData;
  OrganizationData organizationData;
  JobTitleData jobTitleData;
  PositionTypeData positionTypeData;
  String status;
  ParentPositionNodeId parentPositionBusinessNodeId;
  ParentPositionNodeId parentPositionNodeId;
  EmployeeData employeeData;
  RoleData roleData;
  String validFromDate;
  String endDate;
  String startingSalary;

  PositionOrganizationData({
    required this.positionOrganizationId,
    required this.positionData,
    required this.organizationData,
    required this.jobTitleData,
    required this.positionTypeData,
    required this.status,
    required this.parentPositionBusinessNodeId,
    required this.parentPositionNodeId,
    required this.employeeData,
    required this.roleData,
    required this.validFromDate,
    required this.endDate,
    required this.startingSalary,
  });

  factory PositionOrganizationData.fromJson(Map<String, dynamic> json) =>
      PositionOrganizationData(
        positionOrganizationId: json["positionOrganizationId"],
        positionData: PositionData.fromJson(json["positionData"]),
        organizationData: OrganizationData.fromJson(json["organizationData"]),
        jobTitleData: JobTitleData.fromJson(json["jobTitleData"]),
        positionTypeData: PositionTypeData.fromJson(json["positionTypeData"]),
        status: json["status"],
        parentPositionBusinessNodeId:
            ParentPositionNodeId.fromJson(json["parentPositionBusinessNodeId"]),
        parentPositionNodeId:
            ParentPositionNodeId.fromJson(json["parentPositionNodeId"]),
        employeeData: EmployeeData.fromJson(json["employeeData"]),
        roleData: RoleData.fromJson(json["roleData"]),
        validFromDate: json["validFromDate"],
        endDate: json["endDate"],
        startingSalary: json["startingSalary"],
      );

  Map<String, dynamic> toJson() => {
        "positionOrganizationId": positionOrganizationId,
        "positionData": positionData.toJson(),
        "organizationData": organizationData.toJson(),
        "jobTitleData": jobTitleData.toJson(),
        "positionTypeData": positionTypeData.toJson(),
        "status": status,
        "parentPositionBusinessNodeId": parentPositionBusinessNodeId.toJson(),
        "parentPositionNodeId": parentPositionNodeId.toJson(),
        "employeeData": employeeData.toJson(),
        "roleData": roleData.toJson(),
        "validFromDate": validFromDate,
        "endDate": endDate,
        "startingSalary": startingSalary,
      };
}

class EmployeeData {
  String employeeId;
  String employeeFirstNameTh;
  String employeeLastNameTh;
  String employeeFirstNameEn;
  String employeeLastNameEn;

  EmployeeData({
    required this.employeeId,
    required this.employeeFirstNameTh,
    required this.employeeLastNameTh,
    required this.employeeFirstNameEn,
    required this.employeeLastNameEn,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) => EmployeeData(
        employeeId: json["employeeId"],
        employeeFirstNameTh: json["employeeFirstNameTh"],
        employeeLastNameTh: json["employeeLastNameTh"],
        employeeFirstNameEn: json["employeeFirstNameEn"],
        employeeLastNameEn: json["employeeLastNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "employeeFirstNameTh": employeeFirstNameTh,
        "employeeLastNameTh": employeeLastNameTh,
        "employeeFirstNameEn": employeeFirstNameEn,
        "employeeLastNameEn": employeeLastNameEn,
      };
}

class JobTitleData {
  String jobTitleId;
  String? jobTitleName;

  JobTitleData({
    required this.jobTitleId,
    required this.jobTitleName,
  });

  factory JobTitleData.fromJson(Map<String, dynamic> json) => JobTitleData(
        jobTitleId: json["jobTitleId"],
        jobTitleName: json["jobTitleName"],
      );

  Map<String, dynamic> toJson() => {
        "jobTitleId": jobTitleId,
        "jobTitleName": jobTitleName,
      };
}

class OrganizationData {
  String organizationId;
  String organizationCode;
  DepartMentData departMentData;
  ParentOrganizationNodeData parentOrganizationNodeData;
  ParentOrganizationNodeData parentOrganizationBusinessNodeData;
  OrganizationTypeData organizationTypeData;
  String organizationStatus;
  String validFrom;
  String endDate;

  OrganizationData({
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

  factory OrganizationData.fromJson(Map<String, dynamic> json) =>
      OrganizationData(
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
  String deptStatus;

  DepartMentData({
    required this.deptCode,
    required this.deptNameEn,
    required this.deptNameTh,
    required this.deptStatus,
  });

  factory DepartMentData.fromJson(Map<String, dynamic> json) => DepartMentData(
        deptCode: json["deptCode"],
        deptNameEn: json["deptNameEn"],
        deptNameTh: json["deptNameTh"],
        deptStatus: json["deptStatus"],
      );

  Map<String, dynamic> toJson() => {
        "deptCode": deptCode,
        "deptNameEn": deptNameEn,
        "deptNameTh": deptNameTh,
        "deptStatus": deptStatus,
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

class ParentPositionNodeId {
  String positionOrganizationId;
  PositionData positionData;

  ParentPositionNodeId({
    required this.positionOrganizationId,
    required this.positionData,
  });

  factory ParentPositionNodeId.fromJson(Map<String, dynamic> json) =>
      ParentPositionNodeId(
        positionOrganizationId: json["positionOrganizationId"],
        positionData: PositionData.fromJson(json["positionData"]),
      );

  Map<String, dynamic> toJson() => {
        "positionOrganizationId": positionOrganizationId,
        "positionData": positionData.toJson(),
      };
}

class PositionData {
  String positionId;
  String positionNameTh;

  PositionData({
    required this.positionId,
    required this.positionNameTh,
  });

  factory PositionData.fromJson(Map<String, dynamic> json) => PositionData(
        positionId: json["positionId"],
        positionNameTh: json["positionNameTh"],
      );

  Map<String, dynamic> toJson() => {
        "positionId": positionId,
        "positionNameTh": positionNameTh,
      };
}

class PositionTypeData {
  String positionTypeId;
  String? positionTypeNameTh;

  PositionTypeData({
    required this.positionTypeId,
    required this.positionTypeNameTh,
  });

  factory PositionTypeData.fromJson(Map<String, dynamic> json) =>
      PositionTypeData(
        positionTypeId: json["positionTypeId"],
        positionTypeNameTh: json["positionTypeNameTH"],
      );

  Map<String, dynamic> toJson() => {
        "positionTypeId": positionTypeId,
        "positionTypeNameTH": positionTypeNameTh,
      };
}

class RoleData {
  String roleId;
  String roleName;

  RoleData({
    required this.roleId,
    required this.roleName,
  });

  factory RoleData.fromJson(Map<String, dynamic> json) => RoleData(
        roleId: json["roleId"],
        roleName: json["roleName"],
      );

  Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "roleName": roleName,
      };
}
