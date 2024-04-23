import 'dart:convert';

CarsModel carsModelFromJson(String str) => CarsModel.fromJson(json.decode(str));

String carsModelToJson(CarsModel data) => json.encode(data.toJson());

class CarsModel {
  List<CarDatum> carData;
  String messsage;
  bool status;

  CarsModel({
    required this.carData,
    required this.messsage,
    required this.status,
  });

  factory CarsModel.fromJson(Map<String, dynamic> json) => CarsModel(
        carData: List<CarDatum>.from(
            json["carData"].map((x) => CarDatum.fromJson(x))),
        messsage: json["messsage"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "carData": List<dynamic>.from(carData.map((x) => x.toJson())),
        "messsage": messsage,
        "status": status,
      };
}

class CarDatum {
  String carId;
  CarTypeData carTypeData;
  String carRegistation;
  String mileageNumber;
  String carColor;
  String carBrand;
  String carModel;
  String carStatus;

  CarDatum({
    required this.carId,
    required this.carTypeData,
    required this.carRegistation,
    required this.mileageNumber,
    required this.carColor,
    required this.carBrand,
    required this.carModel,
    required this.carStatus,
  });

  factory CarDatum.fromJson(Map<String, dynamic> json) => CarDatum(
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
