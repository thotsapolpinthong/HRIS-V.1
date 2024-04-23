import 'dart:convert';

UpdateCarModel updateCarModelFromJson(String str) =>
    UpdateCarModel.fromJson(json.decode(str));

String updateCarModelToJson(UpdateCarModel data) => json.encode(data.toJson());

class UpdateCarModel {
  String carId;
  String carTypeId;
  String carRegistation;
  String carColor;
  String carBrand;
  String carModel;
  String carStatus;
  String modifiedBy;
  String comment;

  UpdateCarModel({
    required this.carId,
    required this.carTypeId,
    required this.carRegistation,
    required this.carColor,
    required this.carBrand,
    required this.carModel,
    required this.carStatus,
    required this.modifiedBy,
    required this.comment,
  });

  factory UpdateCarModel.fromJson(Map<String, dynamic> json) => UpdateCarModel(
        carId: json["carId"],
        carTypeId: json["carTypeId"],
        carRegistation: json["carRegistation"],
        carColor: json["carColor"],
        carBrand: json["carBrand"],
        carModel: json["carModel"],
        carStatus: json["carStatus"],
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "carId": carId,
        "carTypeId": carTypeId,
        "carRegistation": carRegistation,
        "carColor": carColor,
        "carBrand": carBrand,
        "carModel": carModel,
        "carStatus": carStatus,
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}
