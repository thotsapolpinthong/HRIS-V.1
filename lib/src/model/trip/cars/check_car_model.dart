import 'package:hris_app_prototype/src/model/trip/get_trip_by_id_model.dart';

import 'dart:convert';

CheckCarModel checkCarModelFromJson(String str) =>
    CheckCarModel.fromJson(json.decode(str));

String checkCarModelToJson(CheckCarModel data) => json.encode(data.toJson());

class CheckCarModel {
  TripData tripData;
  String message;
  bool status;

  CheckCarModel({
    required this.tripData,
    required this.message,
    required this.status,
  });

  factory CheckCarModel.fromJson(Map<String, dynamic> json) => CheckCarModel(
        tripData: TripData.fromJson(json["tripData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "tripData": tripData.toJson(),
        "message": message,
        "status": status,
      };
}
