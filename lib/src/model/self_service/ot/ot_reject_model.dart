import 'dart:convert';

OtRejectModel otRejectModelFromJson(String str) =>
    OtRejectModel.fromJson(json.decode(str));

String otRejectModelToJson(OtRejectModel data) => json.encode(data.toJson());

class OtRejectModel {
  String otRequestId;
  String rejectBy;
  String comment;

  OtRejectModel({
    required this.otRequestId,
    required this.rejectBy,
    required this.comment,
  });

  factory OtRejectModel.fromJson(Map<String, dynamic> json) => OtRejectModel(
        otRequestId: json["otRequestId"],
        rejectBy: json["rejectBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "otRequestId": otRequestId,
        "rejectBy": rejectBy,
        "comment": comment,
      };
}
