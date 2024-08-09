import 'dart:convert';

CopyDataTaxModel copyDataTaxModelFromJson(String str) =>
    CopyDataTaxModel.fromJson(json.decode(str));

String copyDataTaxModelToJson(CopyDataTaxModel data) =>
    json.encode(data.toJson());

class CopyDataTaxModel {
  String year;
  List<int> id;
  String coppyBy;

  CopyDataTaxModel({
    required this.year,
    required this.id,
    required this.coppyBy,
  });

  factory CopyDataTaxModel.fromJson(Map<String, dynamic> json) =>
      CopyDataTaxModel(
        year: json["year"],
        id: List<int>.from(json["id"].map((x) => x)),
        coppyBy: json["coppyBy"],
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "id": List<dynamic>.from(id.map((x) => x)),
        "coppyBy": coppyBy,
      };
}
