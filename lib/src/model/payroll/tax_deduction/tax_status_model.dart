import 'dart:convert';

TaxPersonalStatusModel taxPersonalStatusModelFromJson(String str) =>
    TaxPersonalStatusModel.fromJson(json.decode(str));

String taxPersonalStatusModelToJson(TaxPersonalStatusModel data) =>
    json.encode(data.toJson());

class TaxPersonalStatusModel {
  List<TaxPersonalStatusDatum> taxPersonalStatusData;
  String message;
  bool status;

  TaxPersonalStatusModel({
    required this.taxPersonalStatusData,
    required this.message,
    required this.status,
  });

  factory TaxPersonalStatusModel.fromJson(Map<String, dynamic> json) =>
      TaxPersonalStatusModel(
        taxPersonalStatusData: List<TaxPersonalStatusDatum>.from(
            json["taxPersonalStatusData"]
                .map((x) => TaxPersonalStatusDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "taxPersonalStatusData":
            List<dynamic>.from(taxPersonalStatusData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class TaxPersonalStatusDatum {
  int id;
  String name;

  TaxPersonalStatusDatum({
    required this.id,
    required this.name,
  });

  factory TaxPersonalStatusDatum.fromJson(Map<String, dynamic> json) =>
      TaxPersonalStatusDatum(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

TaxMaritalStatusModel taxMaritalStatusModelFromJson(String str) =>
    TaxMaritalStatusModel.fromJson(json.decode(str));

String taxMaritalStatusModelToJson(TaxMaritalStatusModel data) =>
    json.encode(data.toJson());

class TaxMaritalStatusModel {
  List<TaxPersonalStatusDatum> taxMaritalStatusData;
  String message;
  bool status;

  TaxMaritalStatusModel({
    required this.taxMaritalStatusData,
    required this.message,
    required this.status,
  });

  factory TaxMaritalStatusModel.fromJson(Map<String, dynamic> json) =>
      TaxMaritalStatusModel(
        taxMaritalStatusData: List<TaxPersonalStatusDatum>.from(
            json["taxMaritalStatusData"]
                .map((x) => TaxPersonalStatusDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "taxMaritalStatusData":
            List<dynamic>.from(taxMaritalStatusData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}
