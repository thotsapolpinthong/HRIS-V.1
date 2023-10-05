class UpdateAddressbypersonModel {
  String addressId;
  String addressTypeId;
  String personId;
  String homeNumber;
  String moo;
  String housingProject;
  String street;
  String soi;
  String subDistrictId;
  String postcode;
  String countryId;
  String homePhoneNumber;
  String comment;
  String modifiedBy;
  UpdateAddressbypersonModel({
    required this.addressId,
    required this.addressTypeId,
    required this.personId,
    required this.homeNumber,
    required this.moo,
    required this.housingProject,
    required this.street,
    required this.soi,
    required this.subDistrictId,
    required this.postcode,
    required this.countryId,
    required this.homePhoneNumber,
    required this.comment,
    required this.modifiedBy,
  });

  factory UpdateAddressbypersonModel.fromJson(Map<String, dynamic> json) =>
      UpdateAddressbypersonModel(
        addressId: json["addressId"],
        addressTypeId: json["addressTypeId"],
        personId: json["personId"],
        homeNumber: json["homeNumber"],
        moo: json["moo"],
        housingProject: json["housingProject"],
        street: json["street"],
        soi: json["soi"],
        subDistrictId: json["subDistrictId"],
        postcode: json["postcode"],
        countryId: json["countryId"],
        homePhoneNumber: json["homePhoneNumber"],
        comment: json["comment"],
        modifiedBy: json["modifiedBy"],
      );

  Map<String, dynamic> toJson() => {
        "addressId": addressId,
        "addressTypeId": addressTypeId,
        "personId": personId,
        "homeNumber": homeNumber,
        "moo": moo,
        "housingProject": housingProject,
        "street": street,
        "soi": soi,
        "subDistrictId": subDistrictId,
        "postcode": postcode,
        "countryId": countryId,
        "homePhoneNumber": homePhoneNumber,
        "comment": comment,
        "modifiedBy": modifiedBy,
      };
}
