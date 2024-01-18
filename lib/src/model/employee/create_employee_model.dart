import 'dart:convert';

CreateEmployeeModel createEmployeeModelFromJson(String str) =>
    CreateEmployeeModel.fromJson(json.decode(str));

String createEmployeeModelToJson(CreateEmployeeModel data) =>
    json.encode(data.toJson());

class CreateEmployeeModel {
  String personId;
  String fingerScanId;
  String startDate;
  String endDate;
  String noted;
  String email;
  String deptCode;
  String staffStatus;
  String staffType;
  String shiftId;
  String positionOrganizationId;

  CreateEmployeeModel({
    required this.personId,
    required this.fingerScanId,
    required this.startDate,
    required this.endDate,
    required this.noted,
    required this.email,
    required this.deptCode,
    required this.staffStatus,
    required this.staffType,
    required this.shiftId,
    required this.positionOrganizationId,
  });

  factory CreateEmployeeModel.fromJson(Map<String, dynamic> json) =>
      CreateEmployeeModel(
        personId: json["personId"],
        fingerScanId: json["fingerScanId"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        noted: json["noted"],
        email: json["email"],
        deptCode: json["deptCode"],
        staffStatus: json["staffStatus"],
        staffType: json["staffType"],
        shiftId: json["shiftId"],
        positionOrganizationId: json["positionOrganizationId"],
      );

  Map<String, dynamic> toJson() => {
        "personId": personId,
        "fingerScanId": fingerScanId,
        "startDate": startDate,
        "endDate": endDate,
        "noted": noted,
        "email": email,
        "deptCode": deptCode,
        "staffStatus": staffStatus,
        "staffType": staffType,
        "shiftId": shiftId,
        "positionOrganizationId": positionOrganizationId,
      };
}
