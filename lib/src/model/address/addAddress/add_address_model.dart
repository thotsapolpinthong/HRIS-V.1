import 'dart:convert';

Createaddressmodel createaddressmodelFromJson(String str) =>
    Createaddressmodel.fromJson(json.decode(str));

String createaddressmodelToJson(Createaddressmodel data) =>
    json.encode(data.toJson());

class Createaddressmodel {
  String addressTypeId;
  String personId;
  String homeNumber;
  String moo;
  String housingProject;
  String street;
  String soi;
  String subDistrictId;
  String postcode;
  String countryId;
  String homePhoneNumber;

  Createaddressmodel({
    required this.addressTypeId,
    required this.personId,
    required this.homeNumber,
    required this.moo,
    required this.housingProject,
    required this.street,
    required this.soi,
    required this.subDistrictId,
    required this.postcode,
    required this.countryId,
    required this.homePhoneNumber,
  });

  factory Createaddressmodel.fromJson(Map<String, dynamic> json) =>
      Createaddressmodel(
        addressTypeId: json["addressTypeId"],
        personId: json["personId"],
        homeNumber: json["homeNumber"],
        moo: json["moo"],
        housingProject: json["housingProject"],
        street: json["street"],
        soi: json["soi"],
        subDistrictId: json["subDistrictId"],
        postcode: json["postcode"],
        countryId: json["countryId"],
        homePhoneNumber: json["homePhoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "addressTypeId": addressTypeId,
        "personId": personId,
        "homeNumber": homeNumber,
        "moo": moo,
        "housingProject": housingProject,
        "street": street,
        "soi": soi,
        "subDistrictId": subDistrictId,
        "postcode": postcode,
        "countryId": countryId,
        "homePhoneNumber": homePhoneNumber,
      };
}
