import 'dart:convert';

HotelTypeModel hotelTypeModelFromJson(String str) =>
    HotelTypeModel.fromJson(json.decode(str));

String hotelTypeModelToJson(HotelTypeModel data) => json.encode(data.toJson());

class HotelTypeModel {
  List<HotelTypeDatum> hotelTypeData;
  String message;
  bool status;

  HotelTypeModel({
    required this.hotelTypeData,
    required this.message,
    required this.status,
  });

  factory HotelTypeModel.fromJson(Map<String, dynamic> json) => HotelTypeModel(
        hotelTypeData: List<HotelTypeDatum>.from(
            json["hotelTypeData"].map((x) => HotelTypeDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "hotelTypeData":
            List<dynamic>.from(hotelTypeData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class HotelTypeDatum {
  String hotelTypeId;
  String hotelTypeName;

  HotelTypeDatum({
    required this.hotelTypeId,
    required this.hotelTypeName,
  });

  factory HotelTypeDatum.fromJson(Map<String, dynamic> json) => HotelTypeDatum(
        hotelTypeId: json["hotelTypeId"],
        hotelTypeName: json["hotelTypeName"],
      );

  Map<String, dynamic> toJson() => {
        "hotelTypeId": hotelTypeId,
        "hotelTypeName": hotelTypeName,
      };
}
