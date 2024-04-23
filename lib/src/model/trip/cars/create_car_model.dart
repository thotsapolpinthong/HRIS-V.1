import 'dart:convert';

CreateCarsModel createCarsModelFromJson(String str) =>
    CreateCarsModel.fromJson(json.decode(str));

String createCarsModelToJson(CreateCarsModel data) =>
    json.encode(data.toJson());

class CreateCarsModel {
  String carTypeId;
  String carRegistationNumber;
  String carColor;
  String carBrand;
  String carModel;
  String mileageNumber;
  String createBy;

  CreateCarsModel({
    required this.carTypeId,
    required this.carRegistationNumber,
    required this.carColor,
    required this.carBrand,
    required this.carModel,
    required this.mileageNumber,
    required this.createBy,
  });

  factory CreateCarsModel.fromJson(Map<String, dynamic> json) =>
      CreateCarsModel(
        carTypeId: json["carTypeId"],
        carRegistationNumber: json["carRegistationNumber"],
        carColor: json["carColor"],
        carBrand: json["carBrand"],
        carModel: json["carModel"],
        mileageNumber: json["mileageNumber"],
        createBy: json["createBy"],
      );

  Map<String, dynamic> toJson() => {
        "carTypeId": carTypeId,
        "carRegistationNumber": carRegistationNumber,
        "carColor": carColor,
        "carBrand": carBrand,
        "carModel": carModel,
        "mileageNumber": mileageNumber,
        "createBy": createBy,
      };
}
