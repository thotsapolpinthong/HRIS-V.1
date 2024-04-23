import 'dart:convert';

CreateTripModel createTripModelFromJson(String str) =>
    CreateTripModel.fromJson(json.decode(str));

String createTripModelToJson(CreateTripModel data) =>
    json.encode(data.toJson());

class CreateTripModel {
  String tripTypeId;
  List<String> destination;
  String tripDescription;
  String carId;
  String startMileage;
  List<Triper> tripers;
  String startDate;
  String endDate;
  String oldTripId;
  String condition;
  String createBy;

  CreateTripModel({
    required this.tripTypeId,
    required this.destination,
    required this.tripDescription,
    required this.carId,
    required this.startMileage,
    required this.tripers,
    required this.startDate,
    required this.endDate,
    required this.oldTripId,
    required this.condition,
    required this.createBy,
  });

  factory CreateTripModel.fromJson(Map<String, dynamic> json) =>
      CreateTripModel(
        tripTypeId: json["tripTypeId"],
        destination: List<String>.from(json["destination"].map((x) => x)),
        tripDescription: json["tripDescription"],
        carId: json["carId"],
        startMileage: json["startMileage"],
        tripers:
            List<Triper>.from(json["tripers"].map((x) => Triper.fromJson(x))),
        startDate: json["startDate"],
        endDate: json["endDate"],
        oldTripId: json["oldTripId"],
        condition: json["condition"],
        createBy: json["createBy"],
      );

  Map<String, dynamic> toJson() => {
        "tripTypeId": tripTypeId,
        "destination": List<dynamic>.from(destination.map((x) => x)),
        "tripDescription": tripDescription,
        "carId": carId,
        "startMileage": startMileage,
        "tripers": List<dynamic>.from(tripers.map((x) => x.toJson())),
        "startDate": startDate,
        "endDate": endDate,
        "oldTripId": oldTripId,
        "condition": condition,
        "createBy": createBy,
      };
}

class Triper {
  String employeeId;
  String triperTypeId;
  String startDate;
  String endDate;
  List<Expenditure> expenditure;

  Triper({
    required this.employeeId,
    required this.triperTypeId,
    required this.startDate,
    required this.endDate,
    required this.expenditure,
  });

  factory Triper.fromJson(Map<String, dynamic> json) => Triper(
        employeeId: json["employeeId"],
        triperTypeId: json["triperTypeId"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        expenditure: List<Expenditure>.from(
            json["expenditure"].map((x) => Expenditure.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "triperTypeId": triperTypeId,
        "startDate": startDate,
        "endDate": endDate,
        "expenditure": List<dynamic>.from(expenditure.map((x) => x.toJson())),
      };
}

class Expenditure {
  String expenditureTypeId;
  String cost;
  String description;

  Expenditure({
    required this.expenditureTypeId,
    required this.cost,
    required this.description,
  });

  factory Expenditure.fromJson(Map<String, dynamic> json) => Expenditure(
        expenditureTypeId: json["expenditureTypeId"],
        cost: json["cost"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "expenditureTypeId": expenditureTypeId,
        "cost": cost,
        "description": description,
      };
}
