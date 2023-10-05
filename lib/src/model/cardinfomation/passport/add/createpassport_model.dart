import 'dart:convert';

CreatePassportModel createPassportModelFromJson(String str) =>
    CreatePassportModel.fromJson(json.decode(str));

String createPassportModelToJson(CreatePassportModel data) =>
    json.encode(data.toJson());

class CreatePassportModel {
  String passportId;
  String personId;
  String issuedAtCountry;
  String expiredDatePassport;
  String expireDateVisa;

  CreatePassportModel({
    required this.passportId,
    required this.personId,
    required this.issuedAtCountry,
    required this.expiredDatePassport,
    required this.expireDateVisa,
  });

  factory CreatePassportModel.fromJson(Map<String, dynamic> json) =>
      CreatePassportModel(
        passportId: json["passportId"],
        personId: json["personId"],
        issuedAtCountry: json["issuedAtCountry"],
        expiredDatePassport: json["expiredDatePassport"],
        expireDateVisa: json["expireDateVisa"],
      );

  Map<String, dynamic> toJson() => {
        "passportId": passportId,
        "personId": personId,
        "issuedAtCountry": issuedAtCountry,
        "expiredDatePassport": expiredDatePassport,
        "expireDateVisa": expireDateVisa,
      };
}
