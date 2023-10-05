import 'dart:convert';

class TitleDropdownItem {
  final String titleNameId;
  final String titleNameTh;
  final String titleNameEn;

  TitleDropdownItem({
    required this.titleNameId,
    required this.titleNameTh,
    required this.titleNameEn,
  });

  factory TitleDropdownItem.fromJson(Map<String, dynamic> json) {
    return TitleDropdownItem(
      titleNameId: json['titleNameId'],
      titleNameTh: json['titleNameTh'],
      titleNameEn: json['titleNameEn'],
    );
  }
}

// To parse this JSON data, do
//
//     final titleModel = titleModelFromJson(jsonString);

TitleModel titleModelFromJson(String str) =>
    TitleModel.fromJson(json.decode(str));

String titleModelToJson(TitleModel data) => json.encode(data.toJson());

class TitleModel {
  List<TitleNameDatum> titleNameData;

  TitleModel({
    required this.titleNameData,
  });

  factory TitleModel.fromJson(Map<String, dynamic> json) => TitleModel(
        titleNameData: List<TitleNameDatum>.from(
            json["titleNameData"].map((x) => TitleNameDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "titleNameData":
            List<dynamic>.from(titleNameData.map((x) => x.toJson())),
      };
}

class TitleNameDatum {
  String titleNameId;
  String titleNameTh;
  String titleNameEn;

  TitleNameDatum({
    required this.titleNameId,
    required this.titleNameTh,
    required this.titleNameEn,
  });

  factory TitleNameDatum.fromJson(Map<String, dynamic> json) => TitleNameDatum(
        titleNameId: json["titleNameId"],
        titleNameTh: json["titleNameTh"],
        titleNameEn: json["titleNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "titleNameId": titleNameId,
        "titleNameTh": titleNameTh,
        "titleNameEn": titleNameEn,
      };
}
