import 'dart:convert';

GetLunchBreakModel getLunchBreakModelFromJson(String str) =>
    GetLunchBreakModel.fromJson(json.decode(str));

String getLunchBreakModelToJson(GetLunchBreakModel data) =>
    json.encode(data.toJson());

class GetLunchBreakModel {
  List<HalfHourLunchBreakDatum> halfHourLunchBreakData;
  String message;
  bool status;

  GetLunchBreakModel({
    required this.halfHourLunchBreakData,
    required this.message,
    required this.status,
  });

  factory GetLunchBreakModel.fromJson(Map<String, dynamic> json) =>
      GetLunchBreakModel(
        halfHourLunchBreakData: List<HalfHourLunchBreakDatum>.from(
            json["halfHourLunchBreakData"]
                .map((x) => HalfHourLunchBreakDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "halfHourLunchBreakData":
            List<dynamic>.from(halfHourLunchBreakData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class HalfHourLunchBreakDatum {
  int id;
  String startDate;
  String endDate;
  String employeeId;
  bool status;

  HalfHourLunchBreakDatum({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.employeeId,
    required this.status,
  });

  factory HalfHourLunchBreakDatum.fromJson(Map<String, dynamic> json) =>
      HalfHourLunchBreakDatum(
        id: json["id"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        employeeId: json["employeeId"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startDate": startDate,
        "endDate": endDate,
        "employeeId": employeeId,
        "status": status,
      };
}
