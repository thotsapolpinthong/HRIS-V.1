import 'dart:convert';

DropdownPromoteType dropdownPromoteTypeFromJson(String str) =>
    DropdownPromoteType.fromJson(json.decode(str));

String dropdownPromoteTypeToJson(DropdownPromoteType data) =>
    json.encode(data.toJson());

class DropdownPromoteType {
  List<PromoteTypeDatum> promoteTypeData;
  String message;
  bool status;

  DropdownPromoteType({
    required this.promoteTypeData,
    required this.message,
    required this.status,
  });

  factory DropdownPromoteType.fromJson(Map<String, dynamic> json) =>
      DropdownPromoteType(
        promoteTypeData: List<PromoteTypeDatum>.from(
            json["promoteTypeData"].map((x) => PromoteTypeDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "promoteTypeData":
            List<dynamic>.from(promoteTypeData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class PromoteTypeDatum {
  String promoteTypeId;
  String promoteTypeName;

  PromoteTypeDatum({
    required this.promoteTypeId,
    required this.promoteTypeName,
  });

  factory PromoteTypeDatum.fromJson(Map<String, dynamic> json) =>
      PromoteTypeDatum(
        promoteTypeId: json["promoteTypeId"],
        promoteTypeName: json["promoteTypeName"],
      );

  Map<String, dynamic> toJson() => {
        "promoteTypeId": promoteTypeId,
        "promoteTypeName": promoteTypeName,
      };
}
