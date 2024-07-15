import 'dart:convert';

TaxDeductionModel taxDeductionModelFromJson(String str) =>
    TaxDeductionModel.fromJson(json.decode(str));

String taxDeductionModelToJson(TaxDeductionModel data) =>
    json.encode(data.toJson());

class TaxDeductionModel {
  List<TaxDeductionDatum> taxDeductionData;
  String message;
  bool status;

  TaxDeductionModel({
    required this.taxDeductionData,
    required this.message,
    required this.status,
  });

  factory TaxDeductionModel.fromJson(Map<String, dynamic> json) =>
      TaxDeductionModel(
        taxDeductionData: List<TaxDeductionDatum>.from(
            json["taxDeductionData"].map((x) => TaxDeductionDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "taxDeductionData":
            List<dynamic>.from(taxDeductionData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class TaxDeductionDatum {
  int id;
  String year;
  String taxNumber;
  String employeeId;
  String firstName;
  String lastName;

  TaxDeductionDatum({
    required this.id,
    required this.year,
    required this.taxNumber,
    required this.employeeId,
    required this.firstName,
    required this.lastName,
  });

  factory TaxDeductionDatum.fromJson(Map<String, dynamic> json) =>
      TaxDeductionDatum(
        id: json["id"],
        year: json["year"],
        taxNumber: json["taxNumber"],
        employeeId: json["employeeId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "year": year,
        "taxNumber": taxNumber,
        "employeeId": employeeId,
        "firstName": firstName,
        "lastName": lastName,
      };
}
