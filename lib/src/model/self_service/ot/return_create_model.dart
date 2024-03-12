import 'dart:convert';

ReturnOtRequestModel returnOtRequestModelFromJson(String str) =>
    ReturnOtRequestModel.fromJson(json.decode(str));

String returnOtRequestModelToJson(ReturnOtRequestModel data) =>
    json.encode(data.toJson());

class ReturnOtRequestModel {
  OverTimeRequestData overTimeRequestData;
  String message;
  bool status;

  ReturnOtRequestModel({
    required this.overTimeRequestData,
    required this.message,
    required this.status,
  });

  factory ReturnOtRequestModel.fromJson(Map<String, dynamic> json) =>
      ReturnOtRequestModel(
        overTimeRequestData:
            OverTimeRequestData.fromJson(json["overTimeRequestData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "overTimeRequestData": overTimeRequestData.toJson(),
        "message": message,
        "status": status,
      };
}

class OverTimeRequestData {
  String otRequestId;
  EmployeeData employeeData;
  OTrequestTypeData oTrequestTypeData;
  OtTypeData otTypeData;
  String status;
  String otDate;
  String otStartTime;
  String otEndTime;
  WorkTimeScan workTimeScan;
  String otDescription;
  String ncountOt;
  List<OtDatum> otData;

  OverTimeRequestData({
    required this.otRequestId,
    required this.employeeData,
    required this.oTrequestTypeData,
    required this.otTypeData,
    required this.status,
    required this.otDate,
    required this.otStartTime,
    required this.otEndTime,
    required this.workTimeScan,
    required this.otDescription,
    required this.ncountOt,
    required this.otData,
  });

  factory OverTimeRequestData.fromJson(Map<String, dynamic> json) =>
      OverTimeRequestData(
        otRequestId: json["otRequestId"],
        employeeData: EmployeeData.fromJson(json["employeeData"]),
        oTrequestTypeData:
            OTrequestTypeData.fromJson(json["oTrequestTypeData"]),
        otTypeData: OtTypeData.fromJson(json["otTypeData"]),
        status: json["status"],
        otDate: json["otDate"],
        otStartTime: json["otStartTime"],
        otEndTime: json["otEndTime"],
        workTimeScan: WorkTimeScan.fromJson(json["workTimeScan"]),
        otDescription: json["otDescription"],
        ncountOt: json["ncountOt"],
        otData:
            List<OtDatum>.from(json["otData"].map((x) => OtDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "otRequestId": otRequestId,
        "employeeData": employeeData.toJson(),
        "oTrequestTypeData": oTrequestTypeData.toJson(),
        "otTypeData": otTypeData.toJson(),
        "status": status,
        "otDate": otDate,
        "otStartTime": otStartTime,
        "otEndTime": otEndTime,
        "workTimeScan": workTimeScan.toJson(),
        "otDescription": otDescription,
        "ncountOt": ncountOt,
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
  String otDate;
  String otStartTime;
  String otEndTime;
  String otRequestId;
  String nCountOt;
  String otStatus;

  OtDatum({
    required this.otDate,
    required this.otStartTime,
    required this.otEndTime,
    required this.otRequestId,
    required this.nCountOt,
    required this.otStatus,
  });

  factory OtDatum.fromJson(Map<String, dynamic> json) => OtDatum(
        otDate: json["otDate"],
        otStartTime: json["otStartTime"],
        otEndTime: json["otEndTime"],
        otRequestId: json["otRequestId"],
        nCountOt: json["nCountOT"],
        otStatus: json["otStatus"],
      );

  Map<String, dynamic> toJson() => {
        "otDate": otDate,
        "otStartTime": otStartTime,
        "otEndTime": otEndTime,
        "otRequestId": otRequestId,
        "nCountOT": nCountOt,
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

class WorkTimeScan {
  String startTimeType;
  String startTime;
  String endTimeType;
  String endTime;

  WorkTimeScan({
    required this.startTimeType,
    required this.startTime,
    required this.endTimeType,
    required this.endTime,
  });

  factory WorkTimeScan.fromJson(Map<String, dynamic> json) => WorkTimeScan(
        startTimeType: json["startTimeType"],
        startTime: json["startTime"],
        endTimeType: json["endTimeType"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "startTimeType": startTimeType,
        "startTime": startTime,
        "endTimeType": endTimeType,
        "endTime": endTime,
      };
}
