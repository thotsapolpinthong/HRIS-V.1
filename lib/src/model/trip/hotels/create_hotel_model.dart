import 'dart:convert';

CreateHotelModel createHotelModelFromJson(String str) =>
    CreateHotelModel.fromJson(json.decode(str));

String createHotelModelToJson(CreateHotelModel data) =>
    json.encode(data.toJson());

class CreateHotelModel {
  String hotelTypeId;
  String price;
  String hotelName;
  String provinceId;
  String description;
  String createBy;

  CreateHotelModel({
    required this.hotelTypeId,
    required this.price,
    required this.hotelName,
    required this.provinceId,
    required this.description,
    required this.createBy,
  });

  factory CreateHotelModel.fromJson(Map<String, dynamic> json) =>
      CreateHotelModel(
        hotelTypeId: json["hotelTypeId"],
        price: json["price"],
        hotelName: json["hotelName"],
        provinceId: json["provinceId"],
        description: json["description"],
        createBy: json["createBy"],
      );

  Map<String, dynamic> toJson() => {
        "hotelTypeId": hotelTypeId,
        "price": price,
        "hotelName": hotelName,
        "provinceId": provinceId,
        "description": description,
        "createBy": createBy,
      };
}
