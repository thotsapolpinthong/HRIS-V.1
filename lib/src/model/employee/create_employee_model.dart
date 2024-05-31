import 'dart:convert';

CreateEmployeeModel createEmployeeModelFromJson(String str) =>
    CreateEmployeeModel.fromJson(json.decode(str));

String createEmployeeModelToJson(CreateEmployeeModel data) =>
    json.encode(data.toJson());

class CreateEmployeeModel {
  String personId;
  String fingerScanId;
  String startDate;
  String noted;
  String email;
  String staffStatus;
  String shiftId;
  String positionOrganizationId;
  String cardId;

  CreateEmployeeModel({
    required this.personId,
    required this.fingerScanId,
    required this.startDate,
    required this.noted,
    required this.email,
    required this.staffStatus,
    required this.shiftId,
    required this.positionOrganizationId,
    required this.cardId,
  });

  factory CreateEmployeeModel.fromJson(Map<String, dynamic> json) =>
      CreateEmployeeModel(
        personId: json["personId"],
        fingerScanId: json["fingerScanId"],
        startDate: json["startDate"],
        noted: json["noted"],
        email: json["email"],
        staffStatus: json["staffStatus"],
        shiftId: json["shiftId"],
        positionOrganizationId: json["positionOrganizationId"],
        cardId: json["cardId"],
      );

  Map<String, dynamic> toJson() => {
        "personId": personId,
        "fingerScanId": fingerScanId,
        "startDate": startDate,
        "noted": noted,
        "email": email,
        "staffStatus": staffStatus,
        "shiftId": shiftId,
        "positionOrganizationId": positionOrganizationId,
        "cardId": cardId,
      };
}
