import 'dart:convert';

ResponseHotelModel responseHotelModelFromJson(String str) =>
    ResponseHotelModel.fromJson(json.decode(str));

String responseHotelModelToJson(ResponseHotelModel data) =>
    json.encode(data.toJson());

class ResponseHotelModel {
  HotelData hotelData;
  String message;
  bool status;

  ResponseHotelModel({
    required this.hotelData,
    required this.message,
    required this.status,
  });

  factory ResponseHotelModel.fromJson(Map<String, dynamic> json) =>
      ResponseHotelModel(
        hotelData: HotelData.fromJson(json["hotelData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "hotelData": hotelData.toJson(),
        "message": message,
        "status": status,
      };
}

class HotelData {
  String hotelId;
  HotelType hotelType;
  String price;
  String hotelName;
  Province province;
  String hotelDescription;
  String status;

  HotelData({
    required this.hotelId,
    required this.hotelType,
    required this.price,
    required this.hotelName,
    required this.province,
    required this.hotelDescription,
    required this.status,
  });

  factory HotelData.fromJson(Map<String, dynamic> json) => HotelData(
        hotelId: json["hotelId"],
        hotelType: HotelType.fromJson(json["hotelType"]),
        price: json["price"],
        hotelName: json["hotelName"],
        province: Province.fromJson(json["province"]),
        hotelDescription: json["hotelDescription"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "hotelId": hotelId,
        "hotelType": hotelType.toJson(),
        "price": price,
        "hotelName": hotelName,
        "province": province.toJson(),
        "hotelDescription": hotelDescription,
        "status": status,
      };
}

class HotelType {
  String hotelTypeId;
  String hotelTypeName;

  HotelType({
    required this.hotelTypeId,
    required this.hotelTypeName,
  });

  factory HotelType.fromJson(Map<String, dynamic> json) => HotelType(
        hotelTypeId: json["hotelTypeId"],
        hotelTypeName: json["hotelTypeName"],
      );

  Map<String, dynamic> toJson() => {
        "hotelTypeId": hotelTypeId,
        "hotelTypeName": hotelTypeName,
      };
}

class Province {
  String provinceId;
  String regionId;
  String provinceNameTh;
  String provinceNameEn;

  Province({
    required this.provinceId,
    required this.regionId,
    required this.provinceNameTh,
    required this.provinceNameEn,
  });

  factory Province.fromJson(Map<String, dynamic> json) => Province(
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
