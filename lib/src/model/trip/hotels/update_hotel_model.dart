import 'dart:convert';

UpdateHotelModel updateHotelModelFromJson(String str) =>
    UpdateHotelModel.fromJson(json.decode(str));

String updateHotelModelToJson(UpdateHotelModel data) =>
    json.encode(data.toJson());

class UpdateHotelModel {
  String hotelId;
  String hotelTypeId;
  String price;
  String hotelName;
  String provinceId;
  String description;
  String modifyBy;

  UpdateHotelModel({
    required this.hotelId,
    required this.hotelTypeId,
    required this.price,
    required this.hotelName,
    required this.provinceId,
    required this.description,
    required this.modifyBy,
  });

  factory UpdateHotelModel.fromJson(Map<String, dynamic> json) =>
      UpdateHotelModel(
        hotelId: json["hotelId"],
        hotelTypeId: json["hotelTypeId"],
        price: json["price"],
        hotelName: json["hotelName"],
        provinceId: json["provinceId"],
        description: json["description"],
        modifyBy: json["modifyBy"],
      );

  Map<String, dynamic> toJson() => {
        "hotelId": hotelId,
        "hotelTypeId": hotelTypeId,
        "price": price,
        "hotelName": hotelName,
        "provinceId": provinceId,
        "description": description,
        "modifyBy": modifyBy,
      };
}
