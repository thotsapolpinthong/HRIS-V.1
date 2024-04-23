import 'dart:convert';

TripDataByIdModel tripDataByIdModelFromJson(String str) =>
    TripDataByIdModel.fromJson(json.decode(str));

String tripDataByIdModelToJson(TripDataByIdModel data) =>
    json.encode(data.toJson());

class TripDataByIdModel {
  TripData tripData;
  String message;
  bool status;

  TripDataByIdModel({
    required this.tripData,
    required this.message,
    required this.status,
  });

  factory TripDataByIdModel.fromJson(Map<String, dynamic> json) =>
      TripDataByIdModel(
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

class TripData {
  String tripId;
  TripTypeData tripTypeData;
  List<Destination> destination;
  String tripDescription;
  CarData carData;
  String startMileageNumber;
  String endMileageNumber;
  String startDate;
  String endDate;
  List<TriperDatum> triperData;

  TripData({
    required this.tripId,
    required this.tripTypeData,
    required this.destination,
    required this.tripDescription,
    required this.carData,
    required this.startMileageNumber,
    required this.endMileageNumber,
    required this.startDate,
    required this.endDate,
    required this.triperData,
  });

  factory TripData.fromJson(Map<String, dynamic> json) => TripData(
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
        triperData: List<TriperDatum>.from(
            json["triperData"].map((x) => TriperDatum.fromJson(x))),
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
        "triperData": List<dynamic>.from(triperData.map((x) => x.toJson())),
      };
}

class CarData {
  String carId;
  CarTypeData carTypeData;
  String carRegistation;
  String mileageNumber;
  String carColor;
  String carStatus;

  CarData({
    required this.carId,
    required this.carTypeData,
    required this.carRegistation,
    required this.mileageNumber,
    required this.carColor,
    required this.carStatus,
  });

  factory CarData.fromJson(Map<String, dynamic> json) => CarData(
        carId: json["carId"],
        carTypeData: CarTypeData.fromJson(json["carTypeData"]),
        carRegistation: json["carRegistation"],
        mileageNumber: json["mileageNumber"],
        carColor: json["carColor"],
        carStatus: json["carStatus"],
      );

  Map<String, dynamic> toJson() => {
        "carId": carId,
        "carTypeData": carTypeData.toJson(),
        "carRegistation": carRegistation,
        "mileageNumber": mileageNumber,
        "carColor": carColor,
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

class TriperDatum {
  String triperId;
  String employeeId;
  EmployeeData employeeData;
  Position position;
  Organization organization;
  TriperTypeData triperTypeData;
  String tripId;
  List<Expendition> expendition;
  String triperStatus;
  String startDate;
  String endDate;

  TriperDatum({
    required this.triperId,
    required this.employeeId,
    required this.employeeData,
    required this.position,
    required this.organization,
    required this.triperTypeData,
    required this.tripId,
    required this.expendition,
    required this.triperStatus,
    required this.startDate,
    required this.endDate,
  });

  factory TriperDatum.fromJson(Map<String, dynamic> json) => TriperDatum(
        triperId: json["triperId"],
        employeeId: json["employeeId"],
        employeeData: EmployeeData.fromJson(json["employeeData"]),
        position: Position.fromJson(json["position"]),
        organization: Organization.fromJson(json["organization"]),
        triperTypeData: TriperTypeData.fromJson(json["triperTypeData"]),
        tripId: json["tripId"],
        expendition: List<Expendition>.from(
            json["expendition"].map((x) => Expendition.fromJson(x))),
        triperStatus: json["triperStatus"],
        startDate: json["startDate"],
        endDate: json["endDate"],
      );

  Map<String, dynamic> toJson() => {
        "triperId": triperId,
        "employeeId": employeeId,
        "employeeData": employeeData.toJson(),
        "position": position.toJson(),
        "organization": organization.toJson(),
        "triperTypeData": triperTypeData.toJson(),
        "tripId": tripId,
        "expendition": List<dynamic>.from(expendition.map((x) => x.toJson())),
        "triperStatus": triperStatus,
        "startDate": startDate,
        "endDate": endDate,
      };
}

class EmployeeData {
  String firstNameTh;
  String firstNameEn;
  String lastNameTh;
  String lastNameEn;

  EmployeeData({
    required this.firstNameTh,
    required this.firstNameEn,
    required this.lastNameTh,
    required this.lastNameEn,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) => EmployeeData(
        firstNameTh: json["firstNameTh"],
        firstNameEn: json["firstNameEn"],
        lastNameTh: json["lastNameTh"],
        lastNameEn: json["lastNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "firstNameTh": firstNameTh,
        "firstNameEn": firstNameEn,
        "lastNameTh": lastNameTh,
        "lastNameEn": lastNameEn,
      };
}

class Expendition {
  String expenditureId;
  String expenditureTypeId;
  String triperId;
  String cost;
  String description;

  Expendition({
    required this.expenditureId,
    required this.expenditureTypeId,
    required this.triperId,
    required this.cost,
    required this.description,
  });

  factory Expendition.fromJson(Map<String, dynamic> json) => Expendition(
        expenditureId: json["expenditureId"],
        expenditureTypeId: json["expenditureTypeId"],
        triperId: json["triperId"],
        cost: json["cost"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "expenditureId": expenditureId,
        "expenditureTypeId": expenditureTypeId,
        "triperId": triperId,
        "cost": cost,
        "description": description,
      };
}

class Organization {
  String organizationId;
  String organizationCode;
  String organizationName;

  Organization({
    required this.organizationId,
    required this.organizationCode,
    required this.organizationName,
  });

  factory Organization.fromJson(Map<String, dynamic> json) => Organization(
        organizationId: json["organizationId"],
        organizationCode: json["organizationCode"],
        organizationName: json["organizationName"],
      );

  Map<String, dynamic> toJson() => {
        "organizationId": organizationId,
        "organizationCode": organizationCode,
        "organizationName": organizationName,
      };
}

class Position {
  String positionOrganizationId;
  String positionOrganizationName;

  Position({
    required this.positionOrganizationId,
    required this.positionOrganizationName,
  });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        positionOrganizationId: json["positionOrganizationId"],
        positionOrganizationName: json["positionOrganizationName"],
      );

  Map<String, dynamic> toJson() => {
        "positionOrganizationId": positionOrganizationId,
        "positionOrganizationName": positionOrganizationName,
      };
}

class TriperTypeData {
  String triperTypeId;
  String triperTypeName;

  TriperTypeData({
    required this.triperTypeId,
    required this.triperTypeName,
  });

  factory TriperTypeData.fromJson(Map<String, dynamic> json) => TriperTypeData(
        triperTypeId: json["triperTypeId"],
        triperTypeName: json["triperTypeName"],
      );

  Map<String, dynamic> toJson() => {
        "triperTypeId": triperTypeId,
        "triperTypeName": triperTypeName,
      };
}
