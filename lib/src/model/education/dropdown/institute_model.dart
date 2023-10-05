import 'dart:convert';

InstituteModel instituteModelFromJson(String str) =>
    InstituteModel.fromJson(json.decode(str));

String instituteModelToJson(InstituteModel data) => json.encode(data.toJson());

class InstituteModel {
  List<InstituteDatum> instituteData;
  String message;
  bool status;

  InstituteModel({
    required this.instituteData,
    required this.message,
    required this.status,
  });

  factory InstituteModel.fromJson(Map<String, dynamic> json) => InstituteModel(
        instituteData: List<InstituteDatum>.from(
            json["instituteData"].map((x) => InstituteDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "instituteData":
            List<dynamic>.from(instituteData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class InstituteDatum {
  String instituteId;
  String instituteNameTh;

  InstituteDatum({
    required this.instituteId,
    required this.instituteNameTh,
  });

  factory InstituteDatum.fromJson(Map<String, dynamic> json) => InstituteDatum(
        instituteId: json["instituteId"],
        instituteNameTh: json["instituteNameTh"],
      );

  Map<String, dynamic> toJson() => {
        "instituteId": instituteId,
        "instituteNameTh": instituteNameTh,
      };
}
