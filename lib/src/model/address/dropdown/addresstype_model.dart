// To parse this JSON data, do
//
//     final addressTypeModel = addressTypeModelFromJson(jsonString);

import 'dart:convert';

AddressTypeModel addressTypeModelFromJson(String str) =>
    AddressTypeModel.fromJson(json.decode(str));

String addressTypeModelToJson(AddressTypeModel data) =>
    json.encode(data.toJson());

class AddressTypeModel {
  List<AddressTypeDatum> addressTypeData;
  String message;
  bool status;

  AddressTypeModel({
    required this.addressTypeData,
    required this.message,
    required this.status,
  });

  factory AddressTypeModel.fromJson(Map<String, dynamic> json) =>
      AddressTypeModel(
        addressTypeData: List<AddressTypeDatum>.from(
            json["addressTypeData"].map((x) => AddressTypeDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "addressTypeData":
            List<dynamic>.from(addressTypeData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class AddressTypeDatum {
  String addressTypeId;
  String addressTypeName;

  AddressTypeDatum({
    required this.addressTypeId,
    required this.addressTypeName,
  });

  factory AddressTypeDatum.fromJson(Map<String, dynamic> json) =>
      AddressTypeDatum(
        addressTypeId: json["addressTypeId"],
        addressTypeName: json["addressTypeName"],
      );

  Map<String, dynamic> toJson() => {
        "addressTypeId": addressTypeId,
        "addressTypeName": addressTypeName,
      };
}
