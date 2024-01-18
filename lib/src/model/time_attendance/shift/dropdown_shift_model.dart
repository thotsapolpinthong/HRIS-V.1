
import 'dart:convert';

DropdownShiftModel dropdownShiftModelFromJson(String str) => DropdownShiftModel.fromJson(json.decode(str));

String dropdownShiftModelToJson(DropdownShiftModel data) => json.encode(data.toJson());

class DropdownShiftModel {
    List<ShiftDatum> shiftData;
    String message;
    bool status;

    DropdownShiftModel({
        required this.shiftData,
        required this.message,
        required this.status,
    });

    factory DropdownShiftModel.fromJson(Map<String, dynamic> json) => DropdownShiftModel(
        shiftData: List<ShiftDatum>.from(json["shiftData"].map((x) => ShiftDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "shiftData": List<dynamic>.from(shiftData.map((x) => x.toJson())),
        "message": message,
        "status": status,
    };
}

class ShiftDatum {
    String shiftId;
    String shiftName;
    String startTime;
    String endTime;

    ShiftDatum({
        required this.shiftId,
        required this.shiftName,
        required this.startTime,
        required this.endTime,
    });

    factory ShiftDatum.fromJson(Map<String, dynamic> json) => ShiftDatum(
        shiftId: json["shiftId"],
        shiftName: json["shiftName"],
        startTime: json["startTime"],
        endTime: json["endTime"],
    );

    Map<String, dynamic> toJson() => {
        "shiftId": shiftId,
        "shiftName": shiftName,
        "startTime": startTime,
        "endTime": endTime,
    };
}
