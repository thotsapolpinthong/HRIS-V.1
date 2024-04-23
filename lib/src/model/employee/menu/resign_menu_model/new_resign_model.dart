import 'dart:convert';

NewResignModel newResignModelFromJson(String str) =>
    NewResignModel.fromJson(json.decode(str));

String newResignModelToJson(NewResignModel data) => json.encode(data.toJson());

class NewResignModel {
  String employeeId;
  String endDate;
  String hrEndDate;
  String accEndDate;
  String createBy;

  NewResignModel({
    required this.employeeId,
    required this.endDate,
    required this.hrEndDate,
    required this.accEndDate,
    required this.createBy,
  });

  factory NewResignModel.fromJson(Map<String, dynamic> json) => NewResignModel(
        employeeId: json["employeeId"],
        endDate: json["endDate"],
        hrEndDate: json["hrEndDate"],
        accEndDate: json["accEndDate"],
        createBy: json["createBy"],
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "endDate": endDate,
        "hrEndDate": hrEndDate,
        "accEndDate": accEndDate,
        "createBy": createBy,
      };
}
