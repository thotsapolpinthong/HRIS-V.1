import 'dart:convert';

CreateShiftControlModel createShiftControlModelFromJson(String str) =>
    CreateShiftControlModel.fromJson(json.decode(str));

String createShiftControlModelToJson(CreateShiftControlModel data) =>
    json.encode(data.toJson());

class CreateShiftControlModel {
  String shiftId;
  List<String> employeeId;
  String validFrom;
  String endDate;
  String noted;
  String assingType;

  CreateShiftControlModel({
    required this.shiftId,
    required this.employeeId,
    required this.validFrom,
    required this.endDate,
    required this.noted,
    required this.assingType,
  });

  factory CreateShiftControlModel.fromJson(Map<String, dynamic> json) =>
      CreateShiftControlModel(
        shiftId: json["shiftId"],
        employeeId: List<String>.from(json["employeeId"].map((x) => x)),
        validFrom: json["validFrom"],
        endDate: json["endDate"],
        noted: json["noted"],
        assingType: json["assingType"],
      );

  Map<String, dynamic> toJson() => {
        "shiftId": shiftId,
        "employeeId": List<dynamic>.from(employeeId.map((x) => x)),
        "validFrom": validFrom,
        "endDate": endDate,
        "noted": noted,
        "assingType": assingType,
      };
}
