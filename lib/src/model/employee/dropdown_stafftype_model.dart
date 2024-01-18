import 'dart:convert';

StaffTypeDropdown staffTypeDropdownFromJson(String str) =>
    StaffTypeDropdown.fromJson(json.decode(str));

String staffTypeDropdownToJson(StaffTypeDropdown data) =>
    json.encode(data.toJson());

class StaffTypeDropdown {
  List<StaffTypeDatum> staffTypeData;
  String message;
  bool status;

  StaffTypeDropdown({
    required this.staffTypeData,
    required this.message,
    required this.status,
  });

  factory StaffTypeDropdown.fromJson(Map<String, dynamic> json) =>
      StaffTypeDropdown(
        staffTypeData: List<StaffTypeDatum>.from(
            json["staffTypeData"].map((x) => StaffTypeDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "staffTypeData":
            List<dynamic>.from(staffTypeData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class StaffTypeDatum {
  String staffTypeId;
  String description;

  StaffTypeDatum({
    required this.staffTypeId,
    required this.description,
  });

  factory StaffTypeDatum.fromJson(Map<String, dynamic> json) => StaffTypeDatum(
        staffTypeId: json["staffTypeId"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "staffTypeId": staffTypeId,
        "description": description,
      };
}
