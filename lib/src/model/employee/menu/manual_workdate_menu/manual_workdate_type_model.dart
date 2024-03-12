import 'dart:convert';

ManualWorkDateTypeModel manualWorkDateTypeModelFromJson(String str) =>
    ManualWorkDateTypeModel.fromJson(json.decode(str));

String manualWorkDateTypeModelToJson(ManualWorkDateTypeModel data) =>
    json.encode(data.toJson());

class ManualWorkDateTypeModel {
  List<ManualWorkDateTypeDatum> manualWorkDateTypeData;
  String message;
  bool status;

  ManualWorkDateTypeModel({
    required this.manualWorkDateTypeData,
    required this.message,
    required this.status,
  });

  factory ManualWorkDateTypeModel.fromJson(Map<String, dynamic> json) =>
      ManualWorkDateTypeModel(
        manualWorkDateTypeData: List<ManualWorkDateTypeDatum>.from(
            json["manualWorkDateTypeData"]
                .map((x) => ManualWorkDateTypeDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "manualWorkDateTypeData":
            List<dynamic>.from(manualWorkDateTypeData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class ManualWorkDateTypeDatum {
  String manualWorkDateTypeId;
  String manualWorkDateTypeNameTh;

  ManualWorkDateTypeDatum({
    required this.manualWorkDateTypeId,
    required this.manualWorkDateTypeNameTh,
  });

  factory ManualWorkDateTypeDatum.fromJson(Map<String, dynamic> json) =>
      ManualWorkDateTypeDatum(
        manualWorkDateTypeId: json["manualWorkDateTypeId"],
        manualWorkDateTypeNameTh: json["manualWorkDateTypeNameTH"],
      );

  Map<String, dynamic> toJson() => {
        "manualWorkDateTypeId": manualWorkDateTypeId,
        "manualWorkDateTypeNameTH": manualWorkDateTypeNameTh,
      };
}
