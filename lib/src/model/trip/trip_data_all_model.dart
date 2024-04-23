import 'dart:convert';

TripDataModel tripDataModelFromJson(String str) =>
    TripDataModel.fromJson(json.decode(str));

String tripDataModelToJson(TripDataModel data) => json.encode(data.toJson());

class TripDataModel {
  List<TripDatum> tripData;
  String message;
  bool status;

  TripDataModel({
    required this.tripData,
    required this.message,
    required this.status,
  });

  factory TripDataModel.fromJson(Map<String, dynamic> json) => TripDataModel(
        tripData: List<TripDatum>.from(
            json["tripData"].map((x) => TripDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "tripData": List<dynamic>.from(tripData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class TripDatum {
  String tripId;
  TripTypeData tripTypeData;
  List<Destination> destination;
  String tripDescription;
  CarData carData;
  String startMileageNumber;
  String endMileageNumber;
  String startDate;
  String endDate;
  String oldTripId;
  String tripStatus;

  TripDatum({
    required this.tripId,
    required this.tripTypeData,
    required this.destination,
    required this.tripDescription,
    required this.carData,
    required this.startMileageNumber,
    required this.endMileageNumber,
    required this.startDate,
    required this.endDate,
    required this.oldTripId,
    required this.tripStatus,
  });

  factory TripDatum.fromJson(Map<String, dynamic> json) => TripDatum(
        tripId: json["tripId"],
        tripTypeData: TripTypeData.fromJson(json["tripTypeData"]),
        destination: List<Destination>.from(
            json["destination"].map((x) => Destination.fromJson(x))),
        tripDescription: json["tripDescription"],
        carData: CarData.fromJson(json["carData"]),
        startMileageNumber: json["startMileageNumber"],
        endMileageNumber: json["endMileageNumber"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        oldTripId: json["oldTripId"],
        tripStatus: json["tripStatus"],
      );

  Map<String, dynamic> toJson() => {
        "tripId": tripId,
        "tripTypeData": tripTypeData.toJson(),
        "destination": List<dynamic>.from(destination.map((x) => x.toJson())),
        "tripDescription": tripDescription,
        "carData": carData.toJson(),
        "startMileageNumber": startMileageNumber,
        "endMileageNumber": endMileageNumber,
        "startDate": startDate,
        "endDate": endDate,
        "oldTripId": oldTripId,
        "tripStatus": tripStatus,
      };
}

class CarData {
  String carId;
  CarTypeData carTypeData;
  String carRegistation;
  String mileageNumber;
  String carColor;
  String carBrand;
  String carModel;
  String carStatus;

  CarData({
    required this.carId,
    required this.carTypeData,
    required this.carRegistation,
    required this.mileageNumber,
    required this.carColor,
    required this.carBrand,
    required this.carModel,
    required this.carStatus,
  });

  factory CarData.fromJson(Map<String, dynamic> json) => CarData(
        carId: json["carId"],
        carTypeData: CarTypeData.fromJson(json["carTypeData"]),
        carRegistation: json["carRegistation"],
        mileageNumber: json["mileageNumber"],
        carColor: json["carColor"],
        carBrand: json["carBrand"],
        carModel: json["carModel"],
        carStatus: json["carStatus"],
      );

  Map<String, dynamic> toJson() => {
        "carId": carId,
        "carTypeData": carTypeData.toJson(),
        "carRegistation": carRegistation,
        "mileageNumber": mileageNumber,
        "carColor": carColor,
        "carBrand": carBrand,
        "carModel": carModel,
        "carStatus": carStatus,
      };
}

class CarTypeData {
  String carTypeId;
  String carName;

  CarTypeData({
    required this.carTypeId,
    required this.carName,
  });

  factory CarTypeData.fromJson(Map<String, dynamic> json) => CarTypeData(
        carTypeId: json["carTypeId"],
        carName: json["carName"],
      );

  Map<String, dynamic> toJson() => {
        "carTypeId": carTypeId,
        "carName": carName,
      };
}

class Destination {
  String provinceId;
  String regionId;
  String provinceNameTh;
  String provinceNameEn;

  Destination({
    required this.provinceId,
    required this.regionId,
    required this.provinceNameTh,
    required this.provinceNameEn,
  });

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        provinceId: json["provinceId"],
        regionId: json["regionId"],
        provinceNameTh: json["provinceNameTh"],
        provinceNameEn: json["provinceNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "provinceId": provinceId,
        "regionId": regionId,
        "provinceNameTh": provinceNameTh,
        "provinceNameEn": provinceNameEn,
      };
}

class TripTypeData {
  String tripTypeId;
  String tripTypeName;

  TripTypeData({
    required this.tripTypeId,
    required this.tripTypeName,
  });

  factory TripTypeData.fromJson(Map<String, dynamic> json) => TripTypeData(
        tripTypeId: json["tripTypeId"],
        tripTypeName: json["tripTypeName"],
      );

  Map<String, dynamic> toJson() => {
        "tripTypeId": tripTypeId,
        "tripTypeName": tripTypeName,
      };
}
