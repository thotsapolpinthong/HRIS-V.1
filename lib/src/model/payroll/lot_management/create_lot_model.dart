import 'dart:convert';

CreateLotModel createLotModelFromJson(String str) =>
    CreateLotModel.fromJson(json.decode(str));

String createLotModelToJson(CreateLotModel data) => json.encode(data.toJson());

class CreateLotModel {
  String lotMonth;
  String lotYear;
  String startDate;
  String finishDate;
  String salaryPaidDate;
  String otPaidDate;
  String createBy;

  CreateLotModel({
    required this.lotMonth,
    required this.lotYear,
    required this.startDate,
    required this.finishDate,
    required this.salaryPaidDate,
    required this.otPaidDate,
    required this.createBy,
  });

  factory CreateLotModel.fromJson(Map<String, dynamic> json) => CreateLotModel(
        lotMonth: json["lotMonth"],
        lotYear: json["lotYear"],
        startDate: json["startDate"],
        finishDate: json["finishDate"],
        salaryPaidDate: json["salaryPaidDate"],
        otPaidDate: json["otPaidDate"],
        createBy: json["createBy"],
      );

  Map<String, dynamic> toJson() => {
        "lotMonth": lotMonth,
        "lotYear": lotYear,
        "startDate": startDate,
        "finishDate": finishDate,
        "salaryPaidDate": salaryPaidDate,
        "otPaidDate": otPaidDate,
        "createBy": createBy,
      };
}
