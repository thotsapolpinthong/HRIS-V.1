import 'dart:convert';

AddressbypersonModel addressbypersonModelFromJson(String str) =>
    AddressbypersonModel.fromJson(json.decode(str));

String addressbypersonModelToJson(AddressbypersonModel data) =>
    json.encode(data.toJson());

class AddressbypersonModel {
  List<AddressDatum> addressData;
  String message;
  bool status;

  AddressbypersonModel({
    required this.addressData,
    required this.message,
    required this.status,
  });

  factory AddressbypersonModel.fromJson(Map<String, dynamic> json) =>
      AddressbypersonModel(
        addressData: List<AddressDatum>.from(
            json["addressData"].map((x) => AddressDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "addressData": List<dynamic>.from(addressData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class AddressDatum {
  String addressId;
  AddressTypeData addressTypeData;
  String personId;
  String homeNumber;
  String moo;
  String housingProject;
  String street;
  String soi;
  SubDistrictData subDistrictData;
  DistrictData districtData;
  ProvinceData provinceData;
  String postCode;
  CountryData countryData;
  String homePhoneNumber;

  AddressDatum({
    required this.addressId,
    required this.addressTypeData,
    required this.personId,
    required this.homeNumber,
    required this.moo,
    required this.housingProject,
    required this.street,
    required this.soi,
    required this.subDistrictData,
    required this.districtData,
    required this.provinceData,
    required this.postCode,
    required this.countryData,
    required this.homePhoneNumber,
  });

  factory AddressDatum.fromJson(Map<String, dynamic> json) => AddressDatum(
        addressId: json["addressId"],
        addressTypeData: AddressTypeData.fromJson(json["addressTypeData"]),
        personId: json["personId"],
        homeNumber: json["homeNumber"],
        moo: json["moo"],
        housingProject: json["housingProject"],
        street: json["street"],
        soi: json["soi"],
        subDistrictData: SubDistrictData.fromJson(json["subDistrictData"]),
        districtData: DistrictData.fromJson(json["districtData"]),
        provinceData: ProvinceData.fromJson(json["provinceData"]),
        postCode: json["postCode"],
        countryData: CountryData.fromJson(json["countryData"]),
        homePhoneNumber: json["homePhoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "addressId": addressId,
        "addressTypeData": addressTypeData.toJson(),
        "personId": personId,
        "homeNumber": homeNumber,
        "moo": moo,
        "housingProject": housingProject,
        "street": street,
        "soi": soi,
        "subDistrictData": subDistrictData.toJson(),
        "districtData": districtData.toJson(),
        "provinceData": provinceData.toJson(),
        "postCode": postCode,
        "countryData": countryData.toJson(),
        "homePhoneNumber": homePhoneNumber,
      };
}

class AddressTypeData {
  String addressTypeId;
  String addressTypeName;

  AddressTypeData({
    required this.addressTypeId,
    required this.addressTypeName,
  });

  factory AddressTypeData.fromJson(Map<String, dynamic> json) =>
      AddressTypeData(
        addressTypeId: json["addressTypeId"],
        addressTypeName: json["addressTypeName"],
      );

  Map<String, dynamic> toJson() => {
        "addressTypeId": addressTypeId,
        "addressTypeName": addressTypeName,
      };
}

class CountryData {
  String countryId;
  String countryNameTh;

  CountryData({
    required this.countryId,
    required this.countryNameTh,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
        countryId: json["countryId"],
        countryNameTh: json["countryNameTh"],
      );

  Map<String, dynamic> toJson() => {
        "countryId": countryId,
        "countryNameTh": countryNameTh,
      };
}

class DistrictData {
  String districtId;
  String provinceId;
  String districtNameTh;
  String districtNameEn;

  DistrictData({
    required this.districtId,
    required this.provinceId,
    required this.districtNameTh,
    required this.districtNameEn,
  });

  factory DistrictData.fromJson(Map<String, dynamic> json) => DistrictData(
        districtId: json["districtId"],
        provinceId: json["provinceId"],
        districtNameTh: json["districtNameTh"],
        districtNameEn: json["districtNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "districtId": districtId,
        "provinceId": provinceId,
        "districtNameTh": districtNameTh,
        "districtNameEn": districtNameEn,
      };
}

class ProvinceData {
  String provinceId;
  String regionId;
  String provinceNameTh;
  String provinceNameEn;

  ProvinceData({
    required this.provinceId,
    required this.regionId,
    required this.provinceNameTh,
    required this.provinceNameEn,
  });

  factory ProvinceData.fromJson(Map<String, dynamic> json) => ProvinceData(
        provinceId: json["provinceId"],
        regionId: json["regionId"],
        provinceNameTh: json["provinceNameTh"],
        provinceNameEn: json["provinceNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "provinceId": provinceId,
        "regionId": regionId,
        "provinceNameTh": provinceNameTh,
        "provinceNameEn": provinceNameEn,
      };
}

class SubDistrictData {
  String subDistrictId;
  String districtId;
  String subDistrictNameTh;
  String subDistrictNameEn;

  SubDistrictData({
    required this.subDistrictId,
    required this.districtId,
    required this.subDistrictNameTh,
    required this.subDistrictNameEn,
  });

  factory SubDistrictData.fromJson(Map<String, dynamic> json) =>
      SubDistrictData(
        subDistrictId: json["subDistrictId"],
        districtId: json["districtId"],
        subDistrictNameTh: json["subDistrictNameTh"],
        subDistrictNameEn: json["subDistrictNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "subDistrictId": subDistrictId,
        "districtId": districtId,
        "subDistrictNameTh": subDistrictNameTh,
        "subDistrictNameEn": subDistrictNameEn,
      };
}
