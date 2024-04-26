import 'dart:convert';

ResponseInstituteModel responseInstituteModelFromJson(String str) =>
    ResponseInstituteModel.fromJson(json.decode(str));

String responseInstituteModelToJson(ResponseInstituteModel data) =>
    json.encode(data.toJson());

class ResponseInstituteModel {
  InstituteData instituteData;
  String message;
  bool status;

  ResponseInstituteModel({
    required this.instituteData,
    required this.message,
    required this.status,
  });

  factory ResponseInstituteModel.fromJson(Map<String, dynamic> json) =>
      ResponseInstituteModel(
        instituteData: InstituteData.fromJson(json["instituteData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "instituteData": instituteData.toJson(),
        "message": message,
        "status": status,
      };
}

class InstituteData {
  String instituteId;
  String instituteNameTh;

  InstituteData({
    required this.instituteId,
    required this.instituteNameTh,
  });

  factory InstituteData.fromJson(Map<String, dynamic> json) => InstituteData(
        instituteId: json["instituteId"],
        instituteNameTh: json["instituteNameTh"],
      );

  Map<String, dynamic> toJson() => {
        "instituteId": instituteId,
        "instituteNameTh": instituteNameTh,
      };
}
