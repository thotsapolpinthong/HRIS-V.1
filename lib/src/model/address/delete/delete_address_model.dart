import 'dart:convert';

DeleteAddressModel deleteAddressModelFromJson(String str) =>
    DeleteAddressModel.fromJson(json.decode(str));

String deleteAddressModelToJson(DeleteAddressModel data) =>
    json.encode(data.toJson());

class DeleteAddressModel {
  String adressId;
  String comment;
  String modifiedBy;

  DeleteAddressModel({
    required this.adressId,
    required this.comment,
    required this.modifiedBy,
  });

  factory DeleteAddressModel.fromJson(Map<String, dynamic> json) =>
      DeleteAddressModel(
        adressId: json["adressId"],
        comment: json["comment"],
        modifiedBy: json["modifiedBy"],
      );

  Map<String, dynamic> toJson() => {
        "adressId": adressId,
        "comment": comment,
        "modifiedBy": modifiedBy,
      };
}
