import 'dart:convert';

ResponseCreateModel responseCreateModelFromJson(String str) =>
    ResponseCreateModel.fromJson(json.decode(str));

String responseCreateModelToJson(ResponseCreateModel data) =>
    json.encode(data.toJson());

class ResponseCreateModel {
  String message;
  bool status;

  ResponseCreateModel({
    required this.message,
    required this.status,
  });

  factory ResponseCreateModel.fromJson(Map<String, dynamic> json) =>
      ResponseCreateModel(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
