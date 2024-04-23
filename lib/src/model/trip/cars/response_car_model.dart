import 'dart:convert';

ResponseCarModel responseCarModelFromJson(String str) =>
    ResponseCarModel.fromJson(json.decode(str));

String responseCarModelToJson(ResponseCarModel data) =>
    json.encode(data.toJson());

class ResponseCarModel {
  CarData carData;
  String messsage;
  bool status;

  ResponseCarModel({
    required this.carData,
    required this.messsage,
    required this.status,
  });

  factory ResponseCarModel.fromJson(Map<String, dynamic> json) =>
      ResponseCarModel(
        carData: CarData.fromJson(json["carData"]),
        messsage: json["messsage"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "carData": carData.toJson(),
        "messsage": messsage,
        "status": status,
      };
}

class CarData {
  String carId;
  CarTypeData carTypeData;
  String carRegistation;
  String mileageNumber;
  String carColor;
  String carBrand;
  String carModel;
  String carStatus;

  CarData({
    required this.carId,
    required this.carTypeData,
    required this.carRegistation,
    required this.mileageNumber,
    required this.carColor,
    required this.carBrand,
    required this.carModel,
    required this.carStatus,
  });

  factory CarData.fromJson(Map<String, dynamic> json) => CarData(
        carId: json["carId"],
        carTypeData: CarTypeData.fromJson(json["carTypeData"]),
        carRegistation: json["carRegistation"],
        mileageNumber: json["mileageNumber"],
        carColor: json["carColor"],
        carBrand: json["carBrand"],
        carModel: json["carModel"],
        carStatus: json["carStatus"],
      );

  Map<String, dynamic> toJson() => {
        "carId": carId,
        "carTypeData": carTypeData.toJson(),
        "carRegistation": carRegistation,
        "mileageNumber": mileageNumber,
        "carColor": carColor,
        "carBrand": carBrand,
        "carModel": carModel,
        "carStatus": carStatus,
      };
}

class CarTypeData {
  String carTypeId;
  String carName;

  CarTypeData({
    required this.carTypeId,
    required this.carName,
  });

  factory CarTypeData.fromJson(Map<String, dynamic> json) => CarTypeData(
        carTypeId: json["carTypeId"],
        carName: json["carName"],
      );

  Map<String, dynamic> toJson() => {
        "carTypeId": carTypeId,
        "carName": carName,
      };
}
