import 'dart:convert';

MoveTriperModel moveTriperModelFromJson(String str) =>
    MoveTriperModel.fromJson(json.decode(str));

String moveTriperModelToJson(MoveTriperModel data) =>
    json.encode(data.toJson());

class MoveTriperModel {
  String triperId;
  String newTripId;
  String changeBy;

  MoveTriperModel({
    required this.triperId,
    required this.newTripId,
    required this.changeBy,
  });

  factory MoveTriperModel.fromJson(Map<String, dynamic> json) =>
      MoveTriperModel(
        triperId: json["triperId"],
        newTripId: json["newTripId"],
        changeBy: json["changeBy"],
      );

  Map<String, dynamic> toJson() => {
        "triperId": triperId,
        "newTripId": newTripId,
        "changeBy": changeBy,
      };
}
