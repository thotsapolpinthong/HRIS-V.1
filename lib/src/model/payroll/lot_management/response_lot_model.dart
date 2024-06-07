import 'dart:convert';

ResponseLotModel responseLotModelFromJson(String str) =>
    ResponseLotModel.fromJson(json.decode(str));

String responseLotModelToJson(ResponseLotModel data) =>
    json.encode(data.toJson());

class ResponseLotModel {
  LotNumberData lotNumberData;
  String message;
  bool status;

  ResponseLotModel({
    required this.lotNumberData,
    required this.message,
    required this.status,
  });

  factory ResponseLotModel.fromJson(Map<String, dynamic> json) =>
      ResponseLotModel(
        lotNumberData: LotNumberData.fromJson(json["lotNumberData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "lotNumberData": lotNumberData.toJson(),
        "message": message,
        "status": status,
      };
}

class LotNumberData {
  String lotNumberId;
  String lotMonth;
  String lotYear;
  String startDate;
  String finishDate;
  String salaryPaidDate;
  String otPaidDate;

  LotNumberData({
    required this.lotNumberId,
    required this.lotMonth,
    required this.lotYear,
    required this.startDate,
    required this.finishDate,
    required this.salaryPaidDate,
    required this.otPaidDate,
  });

  factory LotNumberData.fromJson(Map<String, dynamic> json) => LotNumberData(
        lotNumberId: json["lotNumberId"],
        lotMonth: json["lotMonth"],
        lotYear: json["lotYear"],
        startDate: json["startDate"],
        finishDate: json["finishDate"],
        salaryPaidDate: json["salaryPaidDate"],
        otPaidDate: json["otPaidDate"],
      );

  Map<String, dynamic> toJson() => {
        "lotNumberId": lotNumberId,
        "lotMonth": lotMonth,
        "lotYear": lotYear,
        "startDate": startDate,
        "finishDate": finishDate,
        "salaryPaidDate": salaryPaidDate,
        "otPaidDate": otPaidDate,
      };
}
