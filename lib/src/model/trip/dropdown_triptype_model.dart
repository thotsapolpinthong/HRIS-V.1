import 'dart:convert';

TripTypeDropdownModel tripTypeDropdownModelFromJson(String str) =>
    TripTypeDropdownModel.fromJson(json.decode(str));

String tripTypeDropdownModelToJson(TripTypeDropdownModel data) =>
    json.encode(data.toJson());

class TripTypeDropdownModel {
  List<TripTypeDatum> tripTypeData;
  String message;
  bool status;

  TripTypeDropdownModel({
    required this.tripTypeData,
    required this.message,
    required this.status,
  });

  factory TripTypeDropdownModel.fromJson(Map<String, dynamic> json) =>
      TripTypeDropdownModel(
        tripTypeData: List<TripTypeDatum>.from(
            json["tripTypeData"].map((x) => TripTypeDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "tripTypeData": List<dynamic>.from(tripTypeData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class TripTypeDatum {
  String tripTypeId;
  String tripTypeName;

  TripTypeDatum({
    required this.tripTypeId,
    required this.tripTypeName,
  });

  factory TripTypeDatum.fromJson(Map<String, dynamic> json) => TripTypeDatum(
        tripTypeId: json["tripTypeId"],
        tripTypeName: json["tripTypeName"],
      );

  Map<String, dynamic> toJson() => {
        "tripTypeId": tripTypeId,
        "tripTypeName": tripTypeName,
      };
}
