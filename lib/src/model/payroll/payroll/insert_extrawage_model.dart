import 'dart:convert';

InsertExtraWageModel insertExtraWageModelFromJson(String str) =>
    InsertExtraWageModel.fromJson(json.decode(str));

String insertExtraWageModelToJson(InsertExtraWageModel data) =>
    json.encode(data.toJson());

class InsertExtraWageModel {
  String lotYear;
  String lotMonth;
  String employeeId;
  double extraWage;
  double deductWage;
  String modifyBy;

  InsertExtraWageModel({
    required this.lotYear,
    required this.lotMonth,
    required this.employeeId,
    required this.extraWage,
    required this.deductWage,
    required this.modifyBy,
  });

  factory InsertExtraWageModel.fromJson(Map<String, dynamic> json) =>
      InsertExtraWageModel(
        lotYear: json["lotYear "],
        lotMonth: json["lotMonth "],
        employeeId: json["employeeId "],
        extraWage: json["extraWage"].toDouble(),
        deductWage: json["deductWage"].toDouble(),
        modifyBy: json["modifyBy"],
      );

  Map<String, dynamic> toJson() => {
        "lotYear ": lotYear,
        "lotMonth ": lotMonth,
        "employeeId ": employeeId,
        "extraWage": extraWage,
        "deductWage": deductWage,
        "modifyBy": modifyBy,
      };
}
