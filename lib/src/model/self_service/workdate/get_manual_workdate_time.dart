import 'dart:convert';

ManualWorkDateTimeModel manualWorkDateTimeModelFromJson(String str) =>
    ManualWorkDateTimeModel.fromJson(json.decode(str));

String manualWorkDateTimeModelToJson(ManualWorkDateTimeModel data) =>
    json.encode(data.toJson());

class ManualWorkDateTimeModel {
  List<ManualWorkDateDatum> manualWorkDateData;
  String message;
  bool status;

  ManualWorkDateTimeModel({
    required this.manualWorkDateData,
    required this.message,
    required this.status,
  });

  factory ManualWorkDateTimeModel.fromJson(Map<String, dynamic> json) =>
      ManualWorkDateTimeModel(
        manualWorkDateData: List<ManualWorkDateDatum>.from(
            json["manualWorkDateData"]
                .map((x) => ManualWorkDateDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "manualWorkDateData":
            List<dynamic>.from(manualWorkDateData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class ManualWorkDateDatum {
  String manualWorkDateDate;
  ManualWorkDateTypeData manualWorkDateTypeData;
  String employeeId;
  String manualWorkDateRequestId;
  String startTime;
  String endTime;

  ManualWorkDateDatum({
    required this.manualWorkDateDate,
    required this.manualWorkDateTypeData,
    required this.employeeId,
    required this.manualWorkDateRequestId,
    required this.startTime,
    required this.endTime,
  });

  factory ManualWorkDateDatum.fromJson(Map<String, dynamic> json) =>
      ManualWorkDateDatum(
        manualWorkDateDate: json["manualWorkDateDate"],
        manualWorkDateTypeData:
            ManualWorkDateTypeData.fromJson(json["manualWorkDateTypeData"]),
        employeeId: json["employeeId"],
        manualWorkDateRequestId: json["manualWorkDateRequestId"],
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "manualWorkDateDate": manualWorkDateDate,
        "manualWorkDateTypeData": manualWorkDateTypeData.toJson(),
        "employeeId": employeeId,
        "manualWorkDateRequestId": manualWorkDateRequestId,
        "startTime": startTime,
        "endTime": endTime,
      };
}

class ManualWorkDateTypeData {
  String manualWorkDateTypeId;
  String manualWorkDateTypeNameTh;

  ManualWorkDateTypeData({
    required this.manualWorkDateTypeId,
    required this.manualWorkDateTypeNameTh,
  });

  factory ManualWorkDateTypeData.fromJson(Map<String, dynamic> json) =>
      ManualWorkDateTypeData(
        manualWorkDateTypeId: json["manualWorkDateTypeId"],
        manualWorkDateTypeNameTh: json["manualWorkDateTypeNameTH"],
      );

  Map<String, dynamic> toJson() => {
        "manualWorkDateTypeId": manualWorkDateTypeId,
        "manualWorkDateTypeNameTH": manualWorkDateTypeNameTh,
      };
}
