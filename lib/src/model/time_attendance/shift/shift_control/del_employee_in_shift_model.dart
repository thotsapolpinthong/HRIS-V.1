
import 'dart:convert';

DeleteEmployeeShiftControlModel deleteEmployeeShiftControlModelFromJson(String str) => DeleteEmployeeShiftControlModel.fromJson(json.decode(str));

String deleteEmployeeShiftControlModelToJson(DeleteEmployeeShiftControlModel data) => json.encode(data.toJson());

class DeleteEmployeeShiftControlModel {
    String shiftId;
    String modifiedBy;
    String comment;

    DeleteEmployeeShiftControlModel({
        required this.shiftId,
        required this.modifiedBy,
        required this.comment,
    });

    factory DeleteEmployeeShiftControlModel.fromJson(Map<String, dynamic> json) => DeleteEmployeeShiftControlModel(
        shiftId: json["shiftId"],
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
    );

    Map<String, dynamic> toJson() => {
        "shiftId": shiftId,
        "modifiedBy": modifiedBy,
        "comment": comment,
    };
}
