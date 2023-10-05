// To parse this JSON data, do
//
//     final getpassport = getpassportFromJson(jsonString);

import 'dart:convert';

Getpassport getpassportFromJson(String str) =>
    Getpassport.fromJson(json.decode(str));

String getpassportToJson(Getpassport data) => json.encode(data.toJson());

class Getpassport {
  PassportData passportData;
  String message;
  bool status;

  Getpassport({
    required this.passportData,
    required this.message,
    required this.status,
  });

  factory Getpassport.fromJson(Map<String, dynamic> json) => Getpassport(
        passportData: PassportData.fromJson(json["passportData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "passportData": passportData.toJson(),
        "message": message,
        "status": status,
      };
}

class PassportData {
  String id;
  String passportId;
  String personId;
  IssuedAtCountry issuedAtCountry;
  String expiredDatePassport;
  String expireDateVisa;

  PassportData({
    required this.id,
    required this.passportId,
    required this.personId,
    required this.issuedAtCountry,
    required this.expiredDatePassport,
    required this.expireDateVisa,
  });

  factory PassportData.fromJson(Map<String, dynamic> json) => PassportData(
        id: json["id"],
        passportId: json["passportId"],
        personId: json["personId"],
        issuedAtCountry: IssuedAtCountry.fromJson(json["issuedAtCountry"]),
        expiredDatePassport: json["expiredDatePassport"],
        expireDateVisa: json["expireDateVisa"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "passportId": passportId,
        "personId": personId,
        "issuedAtCountry": issuedAtCountry.toJson(),
        "expiredDatePassport": expiredDatePassport,
        "expireDateVisa": expireDateVisa,
      };
}

class IssuedAtCountry {
  String? countryId;
  String? countryNameTh;
  String? countryNameEn;

  IssuedAtCountry({
    this.countryId,
    this.countryNameTh,
    this.countryNameEn,
  });

  factory IssuedAtCountry.fromJson(Map<String, dynamic> json) =>
      IssuedAtCountry(
        countryId: json["countryId"],
        countryNameTh: json["countryNameTh"],
        countryNameEn: json["countryNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "countryId": countryId,
        "countryNameTh": countryNameTh,
        "countryNameEn": countryNameEn,
      };
}
