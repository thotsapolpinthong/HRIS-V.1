import 'dart:convert';

EditPassportModel editPassportModelFromJson(String str) =>
    EditPassportModel.fromJson(json.decode(str));

String editPassportModelToJson(EditPassportModel data) =>
    json.encode(data.toJson());

class EditPassportModel {
  String id;
  String passportId;
  String personId;
  String issuedAtCountry;
  String expiredDatePassport;
  String expireDateVisa;
  String modifiedBy;
  String comment;

  EditPassportModel({
    required this.id,
    required this.passportId,
    required this.personId,
    required this.issuedAtCountry,
    required this.expiredDatePassport,
    required this.expireDateVisa,
    required this.modifiedBy,
    required this.comment,
  });

  factory EditPassportModel.fromJson(Map<String, dynamic> json) =>
      EditPassportModel(
        id: json["id"],
        passportId: json["passportId"],
        personId: json["personId"],
        issuedAtCountry: json["issuedAtCountry"],
        expiredDatePassport: json["expiredDatePassport"],
        expireDateVisa: json["expireDateVisa"],
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "passportId": passportId,
        "personId": personId,
        "issuedAtCountry": issuedAtCountry,
        "expiredDatePassport": expiredDatePassport,
        "expireDateVisa": expireDateVisa,
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}
