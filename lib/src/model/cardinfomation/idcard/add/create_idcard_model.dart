import 'dart:convert';

AddNewIdcardModel addNewIdcardModelFromJson(String str) =>
    AddNewIdcardModel.fromJson(json.decode(str));

String addNewIdcardModelToJson(AddNewIdcardModel data) =>
    json.encode(data.toJson());

class AddNewIdcardModel {
  String cardId;
  String personId;
  String issuedDate;
  String expiredDate;
  String issuedAtDistrictId;
  String issuedAtProvinceId;

  AddNewIdcardModel({
    required this.cardId,
    required this.personId,
    required this.issuedDate,
    required this.expiredDate,
    required this.issuedAtDistrictId,
    required this.issuedAtProvinceId,
  });

  factory AddNewIdcardModel.fromJson(Map<String, dynamic> json) =>
      AddNewIdcardModel(
        cardId: json["cardId"],
        personId: json["personId"],
        issuedDate: json["issuedDate"],
        expiredDate: json["expiredDate"],
        issuedAtDistrictId: json["issuedAtDistrictId"],
        issuedAtProvinceId: json["issuedAtProvinceId"],
      );

  Map<String, dynamic> toJson() => {
        "cardId": cardId,
        "personId": personId,
        "issuedDate": issuedDate,
        "expiredDate": expiredDate,
        "issuedAtDistrictId": issuedAtDistrictId,
        "issuedAtProvinceId": issuedAtProvinceId,
      };
}
