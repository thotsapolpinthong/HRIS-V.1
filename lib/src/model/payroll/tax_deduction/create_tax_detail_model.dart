import 'dart:convert';

CreateTaxDetailModel createTaxDetailModelFromJson(String str) =>
    CreateTaxDetailModel.fromJson(json.decode(str));

String createTaxDetailModelToJson(CreateTaxDetailModel data) =>
    json.encode(data.toJson());

class CreateTaxDetailModel {
  String id;
  String topic;
  double amount;
  String modifyBy;
  String comment;

  CreateTaxDetailModel({
    required this.id,
    required this.topic,
    required this.amount,
    required this.modifyBy,
    required this.comment,
  });

  factory CreateTaxDetailModel.fromJson(Map<String, dynamic> json) =>
      CreateTaxDetailModel(
        id: json["id"],
        topic: json["topic"],
        amount: json["amount"],
        modifyBy: json["modifyBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "topic": topic,
        "amount": amount,
        "modifyBy": modifyBy,
        "comment": comment,
      };
}
