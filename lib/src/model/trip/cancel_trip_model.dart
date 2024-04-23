import 'dart:convert';

CancelTripModel cancelTripModelFromJson(String str) =>
    CancelTripModel.fromJson(json.decode(str));

String cancelTripModelToJson(CancelTripModel data) =>
    json.encode(data.toJson());

class CancelTripModel {
  String tripId;
  String cancelBy;
  String condition;
  String comment;

  CancelTripModel({
    required this.tripId,
    required this.cancelBy,
    required this.condition,
    required this.comment,
  });

  factory CancelTripModel.fromJson(Map<String, dynamic> json) =>
      CancelTripModel(
        tripId: json["tripId"],
        cancelBy: json["cancelBy"],
        condition: json["condition"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "tripId": tripId,
        "cancelBy": cancelBy,
        "condition": condition,
        "comment": comment,
      };
}
