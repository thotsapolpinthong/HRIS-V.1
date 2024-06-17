import 'dart:convert';

ResponseWorkdateSpModel responseWorkdateSpModelFromJson(String str) =>
    ResponseWorkdateSpModel.fromJson(json.decode(str));

String responseWorkdateSpModelToJson(ResponseWorkdateSpModel data) =>
    json.encode(data.toJson());

class ResponseWorkdateSpModel {
  String message;
  bool status;

  ResponseWorkdateSpModel({
    required this.message,
    required this.status,
  });

  factory ResponseWorkdateSpModel.fromJson(Map<String, dynamic> json) =>
      ResponseWorkdateSpModel(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
