import 'dart:convert';

ResponsePromoteModel responsePromoteModelFromJson(String str) =>
    ResponsePromoteModel.fromJson(json.decode(str));

String responsePromoteModelToJson(ResponsePromoteModel data) =>
    json.encode(data.toJson());

class ResponsePromoteModel {
  PromoteData promoteData;
  String message;
  bool status;

  ResponsePromoteModel({
    required this.promoteData,
    required this.message,
    required this.status,
  });

  factory ResponsePromoteModel.fromJson(Map<String, dynamic> json) =>
      ResponsePromoteModel(
        promoteData: PromoteData.fromJson(json["promoteData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "promoteData": promoteData.toJson(),
        "message": message,
        "status": status,
      };
}

class PromoteData {
  String promoteId;
  PromoteTypeData promoteTypeData;
  String employeeId;
  StaffTypeData staffTypeData;
  String firstName;
  String lastName;
  String baseSalary;
  String positionOrganizationId;
  String positionName;
  String organizationCode;
  String deparmentName;
  String startDate;
  String endDate;

  PromoteData({
    required this.promoteId,
    required this.promoteTypeData,
    required this.employeeId,
    required this.staffTypeData,
    required this.firstName,
    required this.lastName,
    required this.baseSalary,
    required this.positionOrganizationId,
    required this.positionName,
    required this.organizationCode,
    required this.deparmentName,
    required this.startDate,
    required this.endDate,
  });

  factory PromoteData.fromJson(Map<String, dynamic> json) => PromoteData(
        promoteId: json["promoteId"],
        promoteTypeData: PromoteTypeData.fromJson(json["promoteTypeData"]),
        employeeId: json["employeeId"],
        staffTypeData: StaffTypeData.fromJson(json["staffTypeData"]),
        firstName: json["firstName"],
        lastName: json["lastName"],
        baseSalary: json["baseSalary"],
        positionOrganizationId: json["positionOrganizationId"],
        positionName: json["positionName"],
        organizationCode: json["organizationCode"],
        deparmentName: json["deparmentName"],
        startDate: json["startDate"],
        endDate: json["endDate"],
      );

  Map<String, dynamic> toJson() => {
        "promoteId": promoteId,
        "promoteTypeData": promoteTypeData.toJson(),
        "employeeId": employeeId,
        "staffTypeData": staffTypeData.toJson(),
        "firstName": firstName,
        "lastName": lastName,
        "baseSalary": baseSalary,
        "positionOrganizationId": positionOrganizationId,
        "positionName": positionName,
        "organizationCode": organizationCode,
        "deparmentName": deparmentName,
        "startDate": startDate,
        "endDate": endDate,
      };
}

class PromoteTypeData {
  String promoteTypeId;
  String promoteTypeName;

  PromoteTypeData({
    required this.promoteTypeId,
    required this.promoteTypeName,
  });

  factory PromoteTypeData.fromJson(Map<String, dynamic> json) =>
      PromoteTypeData(
        promoteTypeId: json["promoteTypeId"],
        promoteTypeName: json["promoteTypeName"],
      );

  Map<String, dynamic> toJson() => {
        "promoteTypeId": promoteTypeId,
        "promoteTypeName": promoteTypeName,
      };
}

class StaffTypeData {
  String staffTypeId;
  String description;

  StaffTypeData({
    required this.staffTypeId,
    required this.description,
  });

  factory StaffTypeData.fromJson(Map<String, dynamic> json) => StaffTypeData(
        staffTypeId: json["staffTypeId"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "staffTypeId": staffTypeId,
        "description": description,
      };
}
