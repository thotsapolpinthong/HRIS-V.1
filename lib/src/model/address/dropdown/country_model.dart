import 'dart:convert';

CountryDataModel countryDataModelFromJson(String str) =>
    CountryDataModel.fromJson(json.decode(str));

String countryDataModelToJson(CountryDataModel data) =>
    json.encode(data.toJson());

class CountryDataModel {
  List<CountryDatum> countryData;
  String message;
  bool status;

  CountryDataModel({
    required this.countryData,
    required this.message,
    required this.status,
  });

  factory CountryDataModel.fromJson(Map<String, dynamic> json) =>
      CountryDataModel(
        countryData: List<CountryDatum>.from(
            json["countryData"].map((x) => CountryDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "countryData": List<dynamic>.from(countryData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class CountryDatum {
  String countryId;
  String countryNameTh;
  String countryNameEn;

  CountryDatum({
    required this.countryId,
    required this.countryNameTh,
    required this.countryNameEn,
  });

  factory CountryDatum.fromJson(Map<String, dynamic> json) => CountryDatum(
        countryId: json["countryId"],
        countryNameTh: json["countryNameTh"],
        countryNameEn: json["countryNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "countryId": countryId,
        "countryNameTh": countryNameTh,
        "countryNameEn": countryNameEn,
      };
}
