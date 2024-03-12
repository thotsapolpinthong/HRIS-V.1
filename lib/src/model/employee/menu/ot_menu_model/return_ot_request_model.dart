import 'dart:convert';

ReturnOvertimeRequestModel returnOvertimeRequestModelFromJson(String str) =>
    ReturnOvertimeRequestModel.fromJson(json.decode(str));

String returnOvertimeRequestModelToJson(ReturnOvertimeRequestModel data) =>
    json.encode(data.toJson());

class ReturnOvertimeRequestModel {
  List<OverTimeRequestDatum> overTimeRequestData;
  String message;
  bool status;

  ReturnOvertimeRequestModel({
    required this.overTimeRequestData,
    required this.message,
    required this.status,
  });

  factory ReturnOvertimeRequestModel.fromJson(Map<String, dynamic> json) =>
      ReturnOvertimeRequestModel(
        overTimeRequestData: List<OverTimeRequestDatum>.from(
            json["overTimeRequestData"]
                .map((x) => OverTimeRequestDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "overTimeRequestData":
            List<dynamic>.from(overTimeRequestData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class OverTimeRequestDatum {
  String otRequestId;
  EmployeeData employeeData;
  OTrequestTypeData oTrequestTypeData;
  OtTypeData otTypeData;
  String status;
  List<OtDatum> otData;

  OverTimeRequestDatum({
    required this.otRequestId,
    required this.employeeData,
    required this.oTrequestTypeData,
    required this.otTypeData,
    required this.status,
    required this.otData,
  });

  factory OverTimeRequestDatum.fromJson(Map<String, dynamic> json) =>
      OverTimeRequestDatum(
        otRequestId: json["otRequestId"],
        employeeData: EmployeeData.fromJson(json["employeeData"]),
        oTrequestTypeData:
            OTrequestTypeData.fromJson(json["oTrequestTypeData"]),
        otTypeData: OtTypeData.fromJson(json["otTypeData"]),
        status: json["status"],
        otData:
            List<OtDatum>.from(json["otData"].map((x) => OtDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "otRequestId": otRequestId,
        "employeeData": employeeData.toJson(),
        "oTrequestTypeData": oTrequestTypeData.toJson(),
        "otTypeData": otTypeData.toJson(),
        "status": status,
        "otData": List<dynamic>.from(otData.map((x) => x.toJson())),
      };
}

class EmployeeData {
  String employeeId;
  String firstName;
  String lastName;
  String positionName;
  String departmentName;

  EmployeeData({
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.positionName,
    required this.departmentName,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) => EmployeeData(
        employeeId: json["employeeId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        positionName: json["positionName"],
        departmentName: json["departmentName"],
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "firstName": firstName,
        "lastName": lastName,
        "positionName": positionName,
        "departmentName": departmentName,
      };
}

class OTrequestTypeData {
  String otRequestTypeId;
  String oTrequestTypeName;

  OTrequestTypeData({
    required this.otRequestTypeId,
    required this.oTrequestTypeName,
  });

  factory OTrequestTypeData.fromJson(Map<String, dynamic> json) =>
      OTrequestTypeData(
        otRequestTypeId: json["otRequestTypeId"],
        oTrequestTypeName: json["oTrequestTypeName"],
      );

  Map<String, dynamic> toJson() => {
        "otRequestTypeId": otRequestTypeId,
        "oTrequestTypeName": oTrequestTypeName,
      };
}

class OtDatum {
  String employeeId;
  String otDate;
  String otStartTime;
  String otEndTime;
  String otRequestId;
  String nCountOt;
  String otDecription;
  String otStatus;

  OtDatum({
    required this.employeeId,
    required this.otDate,
    required this.otStartTime,
    required this.otEndTime,
    required this.otRequestId,
    required this.nCountOt,
    required this.otDecription,
    required this.otStatus,
  });

  factory OtDatum.fromJson(Map<String, dynamic> json) => OtDatum(
        employeeId: json["employeeId"],
        otDate: json["otDate"],
        otStartTime: json["otStartTime"],
        otEndTime: json["otEndTime"],
        otRequestId: json["otRequestId"],
        nCountOt: json["nCountOT"],
        otDecription: json["otDecription"],
        otStatus: json["otStatus"],
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "otDate": otDate,
        "otStartTime": otStartTime,
        "otEndTime": otEndTime,
        "otRequestId": otRequestId,
        "nCountOT": nCountOt,
        "otDecription": otDecription,
        "otStatus": otStatus,
      };
}

class OtTypeData {
  String otTypeCode;
  String otTypeName;

  OtTypeData({
    required this.otTypeCode,
    required this.otTypeName,
  });

  factory OtTypeData.fromJson(Map<String, dynamic> json) => OtTypeData(
        otTypeCode: json["otTypeCode"],
        otTypeName: json["otTypeName"],
      );

  Map<String, dynamic> toJson() => {
        "otTypeCode": otTypeCode,
        "otTypeName": otTypeName,
      };
}
