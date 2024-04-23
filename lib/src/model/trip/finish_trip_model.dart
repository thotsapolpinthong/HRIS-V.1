import 'dart:convert';

FinishTripModel finishTripModelFromJson(String str) =>
    FinishTripModel.fromJson(json.decode(str));

String finishTripModelToJson(FinishTripModel data) =>
    json.encode(data.toJson());

class FinishTripModel {
  String tripId;
  String endMileageNumber;
  String finishBy;

  FinishTripModel({
    required this.tripId,
    required this.endMileageNumber,
    required this.finishBy,
  });

  factory FinishTripModel.fromJson(Map<String, dynamic> json) =>
      FinishTripModel(
        tripId: json["tripId"],
        endMileageNumber: json["endMileageNumber"],
        finishBy: json["finishBy"],
      );

  Map<String, dynamic> toJson() => {
        "tripId": tripId,
        "endMileageNumber": endMileageNumber,
        "finishBy": finishBy,
      };
}
