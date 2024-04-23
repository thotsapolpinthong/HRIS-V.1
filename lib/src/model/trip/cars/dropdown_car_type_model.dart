import 'dart:convert';

CarTypeModel carTypeModelFromJson(String str) =>
    CarTypeModel.fromJson(json.decode(str));

String carTypeModelToJson(CarTypeModel data) => json.encode(data.toJson());

class CarTypeModel {
  List<CarTypeDatum> carTypeData;
  String message;
  bool status;

  CarTypeModel({
    required this.carTypeData,
    required this.message,
    required this.status,
  });

  factory CarTypeModel.fromJson(Map<String, dynamic> json) => CarTypeModel(
        carTypeData: List<CarTypeDatum>.from(
            json["carTypeData"].map((x) => CarTypeDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "carTypeData": List<dynamic>.from(carTypeData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class CarTypeDatum {
  String carTypeId;
  String carName;

  CarTypeDatum({
    required this.carTypeId,
    required this.carName,
  });

  factory CarTypeDatum.fromJson(Map<String, dynamic> json) => CarTypeDatum(
        carTypeId: json["carTypeId"],
        carName: json["carName"],
      );

  Map<String, dynamic> toJson() => {
        "carTypeId": carTypeId,
        "carName": carName,
      };
}
