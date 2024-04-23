import 'dart:convert';

import 'package:hris_app_prototype/src/model/trip/create_trip_model.dart';

UpdateTripModel updateTripModelFromJson(String str) =>
    UpdateTripModel.fromJson(json.decode(str));

String updateTripModelToJson(UpdateTripModel data) =>
    json.encode(data.toJson());

class UpdateTripModel {
  String tripId;
  String tripTypeId;
  List<String> destination;
  String tripDescription;
  String carId;
  List<Triper> tripers;
  String startDate;
  String endDate;
  String modifiedBy;
  String comment;

  UpdateTripModel({
    required this.tripId,
    required this.tripTypeId,
    required this.destination,
    required this.tripDescription,
    required this.carId,
    required this.tripers,
    required this.startDate,
    required this.endDate,
    required this.modifiedBy,
    required this.comment,
  });

  factory UpdateTripModel.fromJson(Map<String, dynamic> json) =>
      UpdateTripModel(
        tripId: json["tripId"],
        tripTypeId: json["tripTypeId"],
        destination: List<String>.from(json["destination"].map((x) => x)),
        tripDescription: json["tripDescription"],
        carId: json["carId"],
        tripers:
            List<Triper>.from(json["tripers"].map((x) => Triper.fromJson(x))),
        startDate: json["startDate"],
        endDate: json["endDate"],
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "tripId": tripId,
        "tripTypeId": tripTypeId,
        "destination": List<dynamic>.from(destination.map((x) => x)),
        "tripDescription": tripDescription,
        "carId": carId,
        "tripers": List<dynamic>.from(tripers.map((x) => x.toJson())),
        "startDate": startDate,
        "endDate": endDate,
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}
