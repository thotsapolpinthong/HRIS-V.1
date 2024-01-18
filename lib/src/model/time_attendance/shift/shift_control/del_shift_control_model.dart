import 'dart:convert';

DeleteShiftControlModel deleteShiftControlModelFromJson(String str) => DeleteShiftControlModel.fromJson(json.decode(str));

String deleteShiftControlModelToJson(DeleteShiftControlModel data) => json.encode(data.toJson());

class DeleteShiftControlModel {
    List<String> shiftControlId;

    DeleteShiftControlModel({
        required this.shiftControlId,
    });

    factory DeleteShiftControlModel.fromJson(Map<String, dynamic> json) => DeleteShiftControlModel(
        shiftControlId: List<String>.from(json["shiftControlId"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "shiftControlId": List<dynamic>.from(shiftControlId.map((x) => x)),
    };
}
