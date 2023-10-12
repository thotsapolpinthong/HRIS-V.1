import 'dart:convert';

import 'package:flutter/material.dart';

PersonCreateModel personCreateModelFromJson(String str) =>
    PersonCreateModel.fromJson(json.decode(str));

String personCreateModelToJson(PersonCreateModel data) =>
    json.encode(data.toJson());

class PersonCreateModel {
  ValueNotifier<bool> isDirty = ValueNotifier<bool>(false);
  String personId;
  String titleNameId;
  String firstNameTh;
  String firstNameEn;
  String midNameTh;
  String midNameEn;
  String lastNameTh;
  String lastNameEn;
  String email;
  String phoneNumber1;
  String phoneNumber2;
  String dateOfBirth;
  String height;
  String weight;
  String bloodGroupId;
  String genderId;
  String maritalStatusId;
  String nationalityId;
  String raceId;
  String religionId;

  PersonCreateModel({
    required this.personId,
    required this.titleNameId,
    required this.firstNameTh,
    required this.firstNameEn,
    required this.midNameTh,
    required this.midNameEn,
    required this.lastNameTh,
    required this.lastNameEn,
    required this.email,
    required this.phoneNumber1,
    required this.phoneNumber2,
    required this.dateOfBirth,
    required this.height,
    required this.weight,
    required this.bloodGroupId,
    required this.genderId,
    required this.maritalStatusId,
    required this.nationalityId,
    required this.raceId,
    required this.religionId,
  });

  factory PersonCreateModel.fromJson(Map<String, dynamic> json) =>
      PersonCreateModel(
        personId: json["personId"],
        titleNameId: json["titleNameId"],
        firstNameTh: json["firstNameTh"],
        firstNameEn: json["firstNameEn"],
        midNameTh: json["midNameTh"],
        midNameEn: json["midNameEn"],
        lastNameTh: json["lastNameTh"],
        lastNameEn: json["lastNameEn"],
        email: json["email"],
        phoneNumber1: json["phoneNumber1"],
        phoneNumber2: json["phoneNumber2"],
        dateOfBirth: json["dateOfBirth"],
        height: json["height"],
        weight: json["weight"],
        bloodGroupId: json["bloodGroupId"],
        genderId: json["genderId"],
        maritalStatusId: json["maritalStatusId"],
        nationalityId: json["nationalityId"],
        raceId: json["raceId"],
        religionId: json["religionId"],
      );

  Map<String, dynamic> toJson() => {
        "personId": personId,
        "titleNameId": titleNameId,
        "firstNameTh": firstNameTh,
        "firstNameEn": firstNameEn,
        "midNameTh": midNameTh,
        "midNameEn": midNameEn,
        "lastNameTh": lastNameTh,
        "lastNameEn": lastNameEn,
        "email": email,
        "phoneNumber1": phoneNumber1,
        "phoneNumber2": phoneNumber2,
        "dateOfBirth": dateOfBirth,
        "height": height,
        "weight": weight,
        "bloodGroupId": bloodGroupId,
        "genderId": genderId,
        "maritalStatusId": maritalStatusId,
        "nationalityId": nationalityId,
        "raceId": raceId,
        "religionId": religionId,
      };
}
