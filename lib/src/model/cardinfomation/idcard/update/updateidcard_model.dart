import 'dart:convert';

UpdateIdcardModel updateIdcardModelFromJson(String str) =>
    UpdateIdcardModel.fromJson(json.decode(str));

String updateIdcardModelToJson(UpdateIdcardModel data) =>
    json.encode(data.toJson());

class UpdateIdcardModel {
  String id;
  String cardId;
  String personId;
  String issuedDate;
  String expiredDate;
  String issuedAtDistrictId;
  String issuedAtProvinceId;
  String modifiedBy;
  String comment;

  UpdateIdcardModel({
    required this.id,
    required this.cardId,
    required this.personId,
    required this.issuedDate,
    required this.expiredDate,
    required this.issuedAtDistrictId,
    required this.issuedAtProvinceId,
    required this.modifiedBy,
    required this.comment,
  });

  factory UpdateIdcardModel.fromJson(Map<String, dynamic> json) =>
      UpdateIdcardModel(
        id: json["id"],
        cardId: json["cardId"],
        personId: json["personId"],
        issuedDate: json["issuedDate"],
        expiredDate: json["expiredDate"],
        issuedAtDistrictId: json["issuedAtDistrictId"],
        issuedAtProvinceId: json["issuedAtProvinceId"],
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cardId": cardId,
        "personId": personId,
        "issuedDate": issuedDate,
        "expiredDate": expiredDate,
        "issuedAtDistrictId": issuedAtDistrictId,
        "issuedAtProvinceId": issuedAtProvinceId,
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}
