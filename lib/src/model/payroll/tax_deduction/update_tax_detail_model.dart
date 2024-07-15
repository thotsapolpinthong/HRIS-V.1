import 'dart:convert';

UpdateTaxDetailModel updateTaxDetailModelFromJson(String str) =>
    UpdateTaxDetailModel.fromJson(json.decode(str));

String updateTaxDetailModelToJson(UpdateTaxDetailModel data) =>
    json.encode(data.toJson());

class UpdateTaxDetailModel {
  String id;
  String topic;
  double amount;
  String modifyBy;
  String comment;

  UpdateTaxDetailModel({
    required this.id,
    required this.topic,
    required this.amount,
    required this.modifyBy,
    required this.comment,
  });

  factory UpdateTaxDetailModel.fromJson(Map<String, dynamic> json) =>
      UpdateTaxDetailModel(
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
