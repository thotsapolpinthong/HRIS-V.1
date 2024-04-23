import 'dart:convert';

ResponseTransferModel responseTransferModelFromJson(String str) =>
    ResponseTransferModel.fromJson(json.decode(str));

String responseTransferModelToJson(ResponseTransferModel data) =>
    json.encode(data.toJson());

class ResponseTransferModel {
  EmployeeTransferData employeeTransferData;
  String message;
  bool status;

  ResponseTransferModel({
    required this.employeeTransferData,
    required this.message,
    required this.status,
  });

  factory ResponseTransferModel.fromJson(Map<String, dynamic> json) =>
      ResponseTransferModel(
        employeeTransferData:
            EmployeeTransferData.fromJson(json["employeeTransferData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "employeeTransferData": employeeTransferData.toJson(),
        "message": message,
        "status": status,
      };
}

class EmployeeTransferData {
  StaffTypeData staffTypeData;
  String employeeTransferId;
  PositionOrganizationData positionOrganizationData;
  EmployeeData employeeData;
  String baseSalary;
  String startDate;
  String status;

  EmployeeTransferData({
    required this.staffTypeData,
    required this.employeeTransferId,
    required this.positionOrganizationData,
    required this.employeeData,
    required this.baseSalary,
    required this.startDate,
    required this.status,
  });

  factory EmployeeTransferData.fromJson(Map<String, dynamic> json) =>
      EmployeeTransferData(
        staffTypeData: StaffTypeData.fromJson(json["staffTypeData"]),
        employeeTransferId: json["employeeTransferId"],
        positionOrganizationData:
            PositionOrganizationData.fromJson(json["positionOrganizationData"]),
        employeeData: EmployeeData.fromJson(json["employeeData"]),
        baseSalary: json["baseSalary"],
        startDate: json["startDate"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "staffTypeData": staffTypeData.toJson(),
        "employeeTransferId": employeeTransferId,
        "positionOrganizationData": positionOrganizationData.toJson(),
        "employeeData": employeeData.toJson(),
        "baseSalary": baseSalary,
        "startDate": startDate,
        "status": status,
      };
}

class EmployeeData {
  String employeeId;
  String firstName;
  String lastName;

  EmployeeData({
    required this.employeeId,
    required this.firstName,
    required this.lastName,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) => EmployeeData(
        employeeId: json["employeeId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "firstName": firstName,
        "lastName": lastName,
      };
}

class PositionOrganizationData {
  String positionOrganizationId;
  String positionOrganizationName;

  PositionOrganizationData({
    required this.positionOrganizationId,
    required this.positionOrganizationName,
  });

  factory PositionOrganizationData.fromJson(Map<String, dynamic> json) =>
      PositionOrganizationData(
        positionOrganizationId: json["positionOrganizationId"],
        positionOrganizationName: json["positionOrganizationName"],
      );

  Map<String, dynamic> toJson() => {
        "positionOrganizationId": positionOrganizationId,
        "positionOrganizationName": positionOrganizationName,
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
