// To parse this JSON data, do
//
//     final personByIdModel = personByIdModelFromJson(jsonString);

import 'dart:convert';

PersonByIdModel personByIdModelFromJson(String str) =>
    PersonByIdModel.fromJson(json.decode(str));

String personByIdModelToJson(PersonByIdModel data) =>
    json.encode(data.toJson());

class PersonByIdModel {
  PersonByIdData personData;
  String message;
  bool status;

  PersonByIdModel({
    required this.personData,
    required this.message,
    required this.status,
  });

  factory PersonByIdModel.fromJson(Map<String, dynamic> json) =>
      PersonByIdModel(
        personData: PersonByIdData.fromJson(json["personData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "personData": personData.toJson(),
        "message": message,
        "status": status,
      };
}

class PersonByIdData {
  String personId;
  TitleName titleName;
  String? fisrtNameTh;
  String? firstNameEn;
  String? midNameTh;
  String? midNameEn;
  String? lastNameTh;
  String? lastNameEn;
  String? email;
  String? phoneNumber1;
  String? phoneNumber2;
  String? age;
  String? dateOfBirth;
  String? height;
  String? weight;
  BloodGroup bloodGroup;
  Gender gender;
  MaritalStatus maritalStatus;
  Nationality nationality;
  Race race;
  Religion religion;

  PersonByIdData({
    required this.personId,
    required this.titleName,
    this.fisrtNameTh,
    this.firstNameEn,
    this.midNameTh,
    this.midNameEn,
    this.lastNameTh,
    this.lastNameEn,
    this.email,
    this.phoneNumber1,
    this.phoneNumber2,
    this.age,
    this.dateOfBirth,
    this.height,
    this.weight,
    required this.bloodGroup,
    required this.gender,
    required this.maritalStatus,
    required this.nationality,
    required this.race,
    required this.religion,
  });

  factory PersonByIdData.fromJson(Map<String, dynamic> json) => PersonByIdData(
        personId: json["personId"],
        titleName: TitleName.fromJson(json["titleName"]),
        fisrtNameTh: json["fisrtNameTh"],
        firstNameEn: json["firstNameEn"],
        midNameTh: json["midNameTh"],
        midNameEn: json["midNameEn"],
        lastNameTh: json["lastNameTh"],
        lastNameEn: json["lastNameEn"],
        email: json["email"],
        phoneNumber1: json["phoneNumber1"],
        phoneNumber2: json["phoneNumber2"],
        age: json["age"],
        dateOfBirth: json["dateOfBirth"],
        height: json["height"],
        weight: json["weight"],
        bloodGroup: BloodGroup.fromJson(json["bloodGroup"]),
        gender: Gender.fromJson(json["gender"]),
        maritalStatus: MaritalStatus.fromJson(json["maritalStatus"]),
        nationality: Nationality.fromJson(json["nationality"]),
        race: Race.fromJson(json["race"]),
        religion: Religion.fromJson(json["religion"]),
      );

  Map<String, dynamic> toJson() => {
        "personId": personId,
        "titleName": titleName.toJson(),
        "fisrtNameTh": fisrtNameTh,
        "firstNameEn": firstNameEn,
        "midNameTh": midNameTh,
        "midNameEn": midNameEn,
        "lastNameTh": lastNameTh,
        "lastNameEn": lastNameEn,
        "email": email,
        "phoneNumber1": phoneNumber1,
        "phoneNumber2": phoneNumber2,
        "age": age,
        "dateOfBirth": dateOfBirth,
        "height": height,
        "weight": weight,
        "bloodGroup": bloodGroup.toJson(),
        "gender": gender.toJson(),
        "maritalStatus": maritalStatus.toJson(),
        "nationality": nationality.toJson(),
        "race": race.toJson(),
        "religion": religion.toJson(),
      };
}

class BloodGroup {
  String bloodId;
  String bloodNameTh;
  String bloodNameEn;

  BloodGroup({
    required this.bloodId,
    required this.bloodNameTh,
    required this.bloodNameEn,
  });

  factory BloodGroup.fromJson(Map<String, dynamic> json) => BloodGroup(
        bloodId: json["bloodId"],
        bloodNameTh: json["bloodNameTh"],
        bloodNameEn: json["bloodNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "bloodId": bloodId,
        "bloodNameTh": bloodNameTh,
        "bloodNameEn": bloodNameEn,
      };
}

class Gender {
  String genderId;
  String genderNameTh;
  String genderNameEn;

  Gender({
    required this.genderId,
    required this.genderNameTh,
    required this.genderNameEn,
  });

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
        genderId: json["genderId"],
        genderNameTh: json["genderNameTh"],
        genderNameEn: json["genderNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "genderId": genderId,
        "genderNameTh": genderNameTh,
        "genderNameEn": genderNameEn,
      };
}

class MaritalStatus {
  String maritalStatusId;
  String maritalStatusNameTh;

  MaritalStatus({
    required this.maritalStatusId,
    required this.maritalStatusNameTh,
  });

  factory MaritalStatus.fromJson(Map<String, dynamic> json) => MaritalStatus(
        maritalStatusId: json["maritalStatusId"],
        maritalStatusNameTh: json["maritalStatusNameTh"],
      );

  Map<String, dynamic> toJson() => {
        "maritalStatusId": maritalStatusId,
        "maritalStatusNameTh": maritalStatusNameTh,
      };
}

class Nationality {
  String nationalityId;
  String nationalityNameTh;
  String nationalityNameEn;

  Nationality({
    required this.nationalityId,
    required this.nationalityNameTh,
    required this.nationalityNameEn,
  });

  factory Nationality.fromJson(Map<String, dynamic> json) => Nationality(
        nationalityId: json["nationalityId"],
        nationalityNameTh: json["nationalityNameTh"],
        nationalityNameEn: json["nationalityNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "nationalityId": nationalityId,
        "nationalityNameTh": nationalityNameTh,
        "nationalityNameEn": nationalityNameEn,
      };
}

class Race {
  String raceId;
  String raceNameTh;
  String raceNameEn;

  Race({
    required this.raceId,
    required this.raceNameTh,
    required this.raceNameEn,
  });

  factory Race.fromJson(Map<String, dynamic> json) => Race(
        raceId: json["raceId"],
        raceNameTh: json["raceNameTh"],
        raceNameEn: json["raceNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "raceId": raceId,
        "raceNameTh": raceNameTh,
        "raceNameEn": raceNameEn,
      };
}

class Religion {
  String religionId;
  String religionNameTh;
  String religionNameEn;

  Religion({
    required this.religionId,
    required this.religionNameTh,
    required this.religionNameEn,
  });

  factory Religion.fromJson(Map<String, dynamic> json) => Religion(
        religionId: json["religionId"],
        religionNameTh: json["religionNameTh"],
        religionNameEn: json["religionNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "religionId": religionId,
        "religionNameTh": religionNameTh,
        "religionNameEn": religionNameEn,
      };
}

class TitleName {
  String titleNameId;
  String titleNameTh;
  String titleNameEn;

  TitleName({
    required this.titleNameId,
    required this.titleNameTh,
    required this.titleNameEn,
  });

  factory TitleName.fromJson(Map<String, dynamic> json) => TitleName(
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
