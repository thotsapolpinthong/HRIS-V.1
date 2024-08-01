import 'dart:convert';

UpdateLotModel updateLotModelFromJson(String str) =>
    UpdateLotModel.fromJson(json.decode(str));

String updateLotModelToJson(UpdateLotModel data) => json.encode(data.toJson());

class UpdateLotModel {
  String lotNumberId;
  String lotMonth;
  String lotYear;
  String startDate;
  String finishDate;
  int ssoPercent;
  double ssoMin;
  double ssoMax;
  double ssoMinSalary;
  double ssoMaxSalary;
  String salaryPaidDate;
  String otPaidDate;
  String modifyBy;

  UpdateLotModel({
    required this.lotNumberId,
    required this.lotMonth,
    required this.lotYear,
    required this.startDate,
    required this.finishDate,
    required this.ssoPercent,
    required this.ssoMin,
    required this.ssoMax,
    required this.ssoMinSalary,
    required this.ssoMaxSalary,
    required this.salaryPaidDate,
    required this.otPaidDate,
    required this.modifyBy,
  });

  factory UpdateLotModel.fromJson(Map<String, dynamic> json) => UpdateLotModel(
        lotNumberId: json["lotNumberId"],
        lotMonth: json["lotMonth"],
        lotYear: json["lotYear"],
        startDate: json["startDate"],
        finishDate: json["finishDate"],
        ssoPercent: json["ssoPercent"],
        ssoMin: json["ssoMin"],
        ssoMax: json["ssoMax"],
        ssoMinSalary: json["ssoMinSalary"],
        ssoMaxSalary: json["ssoMaxSalary"],
        salaryPaidDate: json["salaryPaidDate"],
        otPaidDate: json["otPaidDate"],
        modifyBy: json["modifyBy"],
      );

  Map<String, dynamic> toJson() => {
        "lotNumberId": lotNumberId,
        "lotMonth": lotMonth,
        "lotYear": lotYear,
        "startDate": startDate,
        "finishDate": finishDate,
        "ssoPercent": ssoPercent,
        "ssoMin": ssoMin,
        "ssoMax": ssoMax,
        "ssoMinSalary": ssoMinSalary,
        "ssoMaxSalary": ssoMaxSalary,
        "salaryPaidDate": salaryPaidDate,
        "otPaidDate": otPaidDate,
        "modifyBy": modifyBy,
      };
}
