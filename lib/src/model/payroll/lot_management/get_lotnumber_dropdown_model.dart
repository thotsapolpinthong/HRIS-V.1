import 'dart:convert';

GetLotNumberDropdownModel getLotNumberDropdownModelFromJson(String str) =>
    GetLotNumberDropdownModel.fromJson(json.decode(str));

String getLotNumberDropdownModelToJson(GetLotNumberDropdownModel data) =>
    json.encode(data.toJson());

class GetLotNumberDropdownModel {
  List<LotNumberDatum> lotNumberData;
  String message;
  bool status;

  GetLotNumberDropdownModel({
    required this.lotNumberData,
    required this.message,
    required this.status,
  });

  factory GetLotNumberDropdownModel.fromJson(Map<String, dynamic> json) =>
      GetLotNumberDropdownModel(
        lotNumberData: List<LotNumberDatum>.from(
            json["lotNumberData"].map((x) => LotNumberDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "lotNumberData":
            List<dynamic>.from(lotNumberData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class LotNumberDatum {
  String lotNumberId;
  String lotMonth;
  String lotYear;
  String startDate;
  String finishDate;
  String salaryPaidDate;
  String otPaidDate;
  String lockHr;
  String lockAcc;
  String lockAccLabor;
  String lockHrLabor;
  bool lockedAll;

  LotNumberDatum({
    required this.lotNumberId,
    required this.lotMonth,
    required this.lotYear,
    required this.startDate,
    required this.finishDate,
    required this.salaryPaidDate,
    required this.otPaidDate,
    required this.lockHr,
    required this.lockAcc,
    required this.lockAccLabor,
    required this.lockHrLabor,
    required this.lockedAll,
  });

  factory LotNumberDatum.fromJson(Map<String, dynamic> json) => LotNumberDatum(
        lotNumberId: json["lotNumberId"],
        lotMonth: json["lotMonth"],
        lotYear: json["lotYear"],
        startDate: json["startDate"],
        finishDate: json["finishDate"],
        salaryPaidDate: json["salaryPaidDate"],
        otPaidDate: json["otPaidDate"],
        lockHr: json["lockHr"],
        lockAcc: json["lockAcc"],
        lockAccLabor: json["lockAccLabor"],
        lockHrLabor: json["lockHrLabor"],
        lockedAll: json["lockedAll"],
      );

  Map<String, dynamic> toJson() => {
        "lotNumberId": lotNumberId,
        "lotMonth": lotMonth,
        "lotYear": lotYear,
        "startDate": startDate,
        "finishDate": finishDate,
        "salaryPaidDate": salaryPaidDate,
        "otPaidDate": otPaidDate,
        "lockHr": lockHr,
        "lockAcc": lockAcc,
        "lockAccLabor": lockAccLabor,
        "lockHrLabor": lockHrLabor,
        "lockedAll": lockedAll,
      };
}
