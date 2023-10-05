import 'dart:convert';

AddModel addModelFromJson(String str) => AddModel.fromJson(json.decode(str));

String addModelToJson(AddModel data) => json.encode(data.toJson());

class AddModel {
  String personId;
  String message;
  bool status;

  AddModel({
    required this.personId,
    required this.message,
    required this.status,
  });

  factory AddModel.fromJson(Map<String, dynamic> json) => AddModel(
        personId: json["personId"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "personId": personId,
        "message": message,
        "status": status,
      };
}
