import 'dart:convert';

StaffStatusDropdown staffStatusDropdownFromJson(String str) =>
    StaffStatusDropdown.fromJson(json.decode(str));

String staffStatusDropdownToJson(StaffStatusDropdown data) =>
    json.encode(data.toJson());

class StaffStatusDropdown {
  List<StaffStatusDatum> staffStatusData;
  String message;
  bool status;

  StaffStatusDropdown({
    required this.staffStatusData,
    required this.message,
    required this.status,
  });

  factory StaffStatusDropdown.fromJson(Map<String, dynamic> json) =>
      StaffStatusDropdown(
        staffStatusData: List<StaffStatusDatum>.from(
            json["staffStatusData"].map((x) => StaffStatusDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "staffStatusData":
            List<dynamic>.from(staffStatusData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class StaffStatusDatum {
  String staffStatusId;
  String description;

  StaffStatusDatum({
    required this.staffStatusId,
    required this.description,
  });

  factory StaffStatusDatum.fromJson(Map<String, dynamic> json) =>
      StaffStatusDatum(
        staffStatusId: json["staffStatusId"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "staffStatusId": staffStatusId,
        "description": description,
      };
}
