import 'dart:convert';

ResponseTriperModel responseTriperModelFromJson(String str) =>
    ResponseTriperModel.fromJson(json.decode(str));

String responseTriperModelToJson(ResponseTriperModel data) =>
    json.encode(data.toJson());

class ResponseTriperModel {
  TriperData triperData;
  String message;
  bool status;

  ResponseTriperModel({
    required this.triperData,
    required this.message,
    required this.status,
  });

  factory ResponseTriperModel.fromJson(Map<String, dynamic> json) =>
      ResponseTriperModel(
        triperData: TriperData.fromJson(json["triperData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "triperData": triperData.toJson(),
        "message": message,
        "status": status,
      };
}

class TriperData {
  String triperId;
  String employeeId;
  EmployeeData employeeData;
  Position position;
  Organization organization;
  TriperTypeData triperTypeData;
  String tripId;
  List<Expendition> expendition;
  String triperStatus;
  String startDate;
  String endDate;

  TriperData({
    required this.triperId,
    required this.employeeId,
    required this.employeeData,
    required this.position,
    required this.organization,
    required this.triperTypeData,
    required this.tripId,
    required this.expendition,
    required this.triperStatus,
    required this.startDate,
    required this.endDate,
  });

  factory TriperData.fromJson(Map<String, dynamic> json) => TriperData(
        triperId: json["triperId"],
        employeeId: json["employeeId"],
        employeeData: EmployeeData.fromJson(json["employeeData"]),
        position: Position.fromJson(json["position"]),
        organization: Organization.fromJson(json["organization"]),
        triperTypeData: TriperTypeData.fromJson(json["triperTypeData"]),
        tripId: json["tripId"],
        expendition: List<Expendition>.from(
            json["expendition"].map((x) => Expendition.fromJson(x))),
        triperStatus: json["triperStatus"],
        startDate: json["startDate"],
        endDate: json["endDate"],
      );

  Map<String, dynamic> toJson() => {
        "triperId": triperId,
        "employeeId": employeeId,
        "employeeData": employeeData.toJson(),
        "position": position.toJson(),
        "organization": organization.toJson(),
        "triperTypeData": triperTypeData.toJson(),
        "tripId": tripId,
        "expendition": List<dynamic>.from(expendition.map((x) => x.toJson())),
        "triperStatus": triperStatus,
        "startDate": startDate,
        "endDate": endDate,
      };
}

class EmployeeData {
  String firstNameTh;
  String firstNameEn;
  String lastNameTh;
  String lastNameEn;

  EmployeeData({
    required this.firstNameTh,
    required this.firstNameEn,
    required this.lastNameTh,
    required this.lastNameEn,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) => EmployeeData(
        firstNameTh: json["firstNameTh"],
        firstNameEn: json["firstNameEn"],
        lastNameTh: json["lastNameTh"],
        lastNameEn: json["lastNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "firstNameTh": firstNameTh,
        "firstNameEn": firstNameEn,
        "lastNameTh": lastNameTh,
        "lastNameEn": lastNameEn,
      };
}

class Expendition {
  String expenditureId;
  String expenditureTypeId;
  String triperId;
  String cost;
  String description;

  Expendition({
    required this.expenditureId,
    required this.expenditureTypeId,
    required this.triperId,
    required this.cost,
    required this.description,
  });

  factory Expendition.fromJson(Map<String, dynamic> json) => Expendition(
        expenditureId: json["expenditureId"],
        expenditureTypeId: json["expenditureTypeId"],
        triperId: json["triperId"],
        cost: json["cost"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "expenditureId": expenditureId,
        "expenditureTypeId": expenditureTypeId,
        "triperId": triperId,
        "cost": cost,
        "description": description,
      };
}

class Organization {
  String organizationId;
  String organizationCode;
  String organizationName;

  Organization({
    required this.organizationId,
    required this.organizationCode,
    required this.organizationName,
  });

  factory Organization.fromJson(Map<String, dynamic> json) => Organization(
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

class Position {
  String positionOrganizationId;
  String positionOrganizationName;

  Position({
    required this.positionOrganizationId,
    required this.positionOrganizationName,
  });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        positionOrganizationId: json["positionOrganizationId"],
        positionOrganizationName: json["positionOrganizationName"],
      );

  Map<String, dynamic> toJson() => {
        "positionOrganizationId": positionOrganizationId,
        "positionOrganizationName": positionOrganizationName,
      };
}

class TriperTypeData {
  String triperTypeId;
  String triperTypeName;

  TriperTypeData({
    required this.triperTypeId,
    required this.triperTypeName,
  });

  factory TriperTypeData.fromJson(Map<String, dynamic> json) => TriperTypeData(
        triperTypeId: json["triperTypeId"],
        triperTypeName: json["triperTypeName"],
      );

  Map<String, dynamic> toJson() => {
        "triperTypeId": triperTypeId,
        "triperTypeName": triperTypeName,
      };
}
