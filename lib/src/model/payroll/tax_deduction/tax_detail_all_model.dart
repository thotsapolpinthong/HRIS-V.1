import 'dart:convert';

TaxDetailModel taxDetailModelFromJson(String str) =>
    TaxDetailModel.fromJson(json.decode(str));

String taxDetailModelToJson(TaxDetailModel data) => json.encode(data.toJson());

class TaxDetailModel {
  List<TaxDetailDatum> taxDetailData;
  String message;
  bool status;

  TaxDetailModel({
    required this.taxDetailData,
    required this.message,
    required this.status,
  });

  factory TaxDetailModel.fromJson(Map<String, dynamic> json) => TaxDetailModel(
        taxDetailData: List<TaxDetailDatum>.from(
            json["taxDetailData"].map((x) => TaxDetailDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "taxDetailData":
            List<dynamic>.from(taxDetailData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class TaxDetailDatum {
  String id;
  String topic;
  double amount;

  TaxDetailDatum({
    required this.id,
    required this.topic,
    required this.amount,
  });

  factory TaxDetailDatum.fromJson(Map<String, dynamic> json) => TaxDetailDatum(
        id: json["id"],
        topic: json["topic"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "topic": topic,
        "amount": amount,
      };
}
