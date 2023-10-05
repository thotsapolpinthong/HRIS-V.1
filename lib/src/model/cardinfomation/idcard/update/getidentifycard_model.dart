import 'dart:convert';

GetIdCardModel getIdCardModelFromJson(String str) =>
    GetIdCardModel.fromJson(json.decode(str));

String getIdCardModelToJson(GetIdCardModel data) => json.encode(data.toJson());

class GetIdCardModel {
  PersonalCardData personalCardData;
  String message;
  bool status;

  GetIdCardModel({
    required this.personalCardData,
    required this.message,
    required this.status,
  });

  factory GetIdCardModel.fromJson(Map<String, dynamic> json) => GetIdCardModel(
        personalCardData: PersonalCardData.fromJson(json["personalCardData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "personalCardData": personalCardData.toJson(),
        "message": message,
        "status": status,
      };
}

class PersonalCardData {
  String id;
  String cardId;
  String personId;
  String issuedDate;
  String expiredDate;
  IssuedAtDistrict issuedAtDistrict;
  IssuedAtProvince issuedAtProvince;

  PersonalCardData({
    required this.id,
    required this.cardId,
    required this.personId,
    required this.issuedDate,
    required this.expiredDate,
    required this.issuedAtDistrict,
    required this.issuedAtProvince,
  });

  factory PersonalCardData.fromJson(Map<String, dynamic> json) =>
      PersonalCardData(
        id: json["id"],
        cardId: json["cardId"],
        personId: json["personId"],
        issuedDate: json["issuedDate"],
        expiredDate: json["expiredDate"],
        issuedAtDistrict: IssuedAtDistrict.fromJson(json["issuedAtDistrict"]),
        issuedAtProvince: IssuedAtProvince.fromJson(json["issuedAtProvince"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cardId": cardId,
        "personId": personId,
        "issuedDate": issuedDate,
        "expiredDate": expiredDate,
        "issuedAtDistrict": issuedAtDistrict.toJson(),
        "issuedAtProvince": issuedAtProvince.toJson(),
      };
}

class IssuedAtDistrict {
  String? districtId;
  String? provinceId;
  String? districtNameTh;
  String? districtNameEn;

  IssuedAtDistrict({
    required this.districtId,
    required this.provinceId,
    required this.districtNameTh,
    required this.districtNameEn,
  });

  factory IssuedAtDistrict.fromJson(Map<String, dynamic> json) =>
      IssuedAtDistrict(
        districtId: json["districtId"],
        provinceId: json["provinceId"],
        districtNameTh: json["districtNameTh"],
        districtNameEn: json["districtNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "districtId": districtId,
        "provinceId": provinceId,
        "districtNameTh": districtNameTh,
        "districtNameEn": districtNameEn,
      };
}

class IssuedAtProvince {
  String? provinceId;
  String? regionId;
  String? provinceNameTh;
  String? provinceNameEn;

  IssuedAtProvince({
    required this.provinceId,
    required this.regionId,
    required this.provinceNameTh,
    required this.provinceNameEn,
  });

  factory IssuedAtProvince.fromJson(Map<String, dynamic> json) =>
      IssuedAtProvince(
        provinceId: json["provinceId"],
        regionId: json["regionId"],
        provinceNameTh: json["provinceNameTh"],
        provinceNameEn: json["provinceNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "provinceId": provinceId,
        "regionId": regionId,
        "provinceNameTh": provinceNameTh,
        "provinceNameEn": provinceNameEn,
      };
}
