import 'dart:convert';

ManualWorkDateRequestModel manualWorkDateRequestModelFromJson(String str) =>
    ManualWorkDateRequestModel.fromJson(json.decode(str));

String manualWorkDateRequestModelToJson(ManualWorkDateRequestModel data) =>
    json.encode(data.toJson());

class ManualWorkDateRequestModel {
  List<ManualWorkDateRequestDatum> manualWorkDateRequestData;
  String message;
  bool status;

  ManualWorkDateRequestModel({
    required this.manualWorkDateRequestData,
    required this.message,
    required this.status,
  });

  factory ManualWorkDateRequestModel.fromJson(Map<String, dynamic> json) =>
      ManualWorkDateRequestModel(
        manualWorkDateRequestData: List<ManualWorkDateRequestDatum>.from(
            json["manualWorkDateRequestData"]
                .map((x) => ManualWorkDateRequestDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "manualWorkDateRequestData": List<dynamic>.from(
            manualWorkDateRequestData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class ManualWorkDateRequestDatum {
  String manualWorkDateRequestId;
  ManualWorkDateTypeData manualWorkDateTypeData;
  String employeeId;
  String firstName;
  String lastName;
  String date;
  String startTime;
  String endTime;
  String decription;
  String status;

  ManualWorkDateRequestDatum({
    required this.manualWorkDateRequestId,
    required this.manualWorkDateTypeData,
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.decription,
    required this.status,
  });

  factory ManualWorkDateRequestDatum.fromJson(Map<String, dynamic> json) =>
      ManualWorkDateRequestDatum(
        manualWorkDateRequestId: json["manualWorkDateRequestId"],
        manualWorkDateTypeData:
            ManualWorkDateTypeData.fromJson(json["manualWorkDateTypeData"]),
        employeeId: json["employeeId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        date: json["date"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        decription: json["decription"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "manualWorkDateRequestId": manualWorkDateRequestId,
        "manualWorkDateTypeData": manualWorkDateTypeData.toJson(),
        "employeeId": employeeId,
        "firstName": firstName,
        "lastName": lastName,
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
        "decription": decription,
        "status": status,
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
