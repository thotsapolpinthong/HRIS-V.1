import 'dart:convert';

GetDropdownJobtitleModel getDropdownJobtitleModelFromJson(String str) =>
    GetDropdownJobtitleModel.fromJson(json.decode(str));

String getDropdownJobtitleModelToJson(GetDropdownJobtitleModel data) =>
    json.encode(data.toJson());

class GetDropdownJobtitleModel {
  List<JobTitleDatum> jobTitleData;
  String message;
  bool status;

  GetDropdownJobtitleModel({
    required this.jobTitleData,
    required this.message,
    required this.status,
  });

  factory GetDropdownJobtitleModel.fromJson(Map<String, dynamic> json) =>
      GetDropdownJobtitleModel(
        jobTitleData: List<JobTitleDatum>.from(
            json["jobTitleData"].map((x) => JobTitleDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "jobTitleData": List<dynamic>.from(jobTitleData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class JobTitleDatum {
  String jobTitleId;
  String jobTitleName;

  JobTitleDatum({
    required this.jobTitleId,
    required this.jobTitleName,
  });

  factory JobTitleDatum.fromJson(Map<String, dynamic> json) => JobTitleDatum(
        jobTitleId: json["jobTitleId"],
        jobTitleName: json["jobTitleName"],
      );

  Map<String, dynamic> toJson() => {
        "jobTitleId": jobTitleId,
        "jobTitleName": jobTitleName,
      };
}
