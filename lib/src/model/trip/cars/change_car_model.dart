import 'dart:convert';

ChangeCarModel changeCarModelFromJson(String str) =>
    ChangeCarModel.fromJson(json.decode(str));

String changeCarModelToJson(ChangeCarModel data) => json.encode(data.toJson());

class ChangeCarModel {
  String tripId1;
  String mileageNumber1;
  String tripId2;
  String mileageNumber2;
  String changeBy;

  ChangeCarModel({
    required this.tripId1,
    required this.mileageNumber1,
    required this.tripId2,
    required this.mileageNumber2,
    required this.changeBy,
  });

  factory ChangeCarModel.fromJson(Map<String, dynamic> json) => ChangeCarModel(
        tripId1: json["tripId1"],
        mileageNumber1: json["mileageNumber1"],
        tripId2: json["tripId2"],
        mileageNumber2: json["mileageNumber2"],
        changeBy: json["changeBy"],
      );

  Map<String, dynamic> toJson() => {
        "tripId1": tripId1,
        "mileageNumber1": mileageNumber1,
        "tripId2": tripId2,
        "mileageNumber2": mileageNumber2,
        "changeBy": changeBy,
      };
}
