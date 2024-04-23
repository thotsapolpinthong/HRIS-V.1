import 'dart:convert';

GetEmployeeAllDataModel getEmployeeAllDataModelFromJson(String str) =>
    GetEmployeeAllDataModel.fromJson(json.decode(str));

String getEmployeeAllDataModelToJson(GetEmployeeAllDataModel data) =>
    json.encode(data.toJson());

class GetEmployeeAllDataModel {
  List<EmployeeDatum> employeeData;
  String message;
  bool status;

  GetEmployeeAllDataModel({
    required this.employeeData,
    required this.message,
    required this.status,
  });

  factory GetEmployeeAllDataModel.fromJson(Map<String, dynamic> json) =>
      GetEmployeeAllDataModel(
        employeeData: List<EmployeeDatum>.from(
            json["employeeData"].map((x) => EmployeeDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "employeeData": List<dynamic>.from(employeeData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class EmployeeDatum {
  String employeeId;
  PersonData personData;
  String fingerScanId;
  String startDate;
  String endDate;
  String? noted;
  String? email;
  DepartmentData departmentData;
  StaffStatusData staffStatusData;
  StaffTypeData staffTypeData;
  EmployeeDatumPositionData positionData;
  ShiftData shiftData;

  EmployeeDatum({
    required this.employeeId,
    required this.personData,
    required this.fingerScanId,
    required this.startDate,
    required this.endDate,
    required this.noted,
    required this.email,
    required this.departmentData,
    required this.staffStatusData,
    required this.staffTypeData,
    required this.positionData,
    required this.shiftData,
  });

  factory EmployeeDatum.fromJson(Map<String, dynamic> json) => EmployeeDatum(
        employeeId: json["employeeId"],
        personData: PersonData.fromJson(json["personData"]),
        fingerScanId: json["fingerScanId"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        noted: json["noted"],
        email: json["email"],
        departmentData: DepartmentData.fromJson(json["departmentData"]),
        staffStatusData: StaffStatusData.fromJson(json["staffStatusData"]),
        staffTypeData: StaffTypeData.fromJson(json["staffTypeData"]),
        positionData: EmployeeDatumPositionData.fromJson(json["positionData"]),
        shiftData: ShiftData.fromJson(json["shiftData"]),
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "personData": personData.toJson(),
        "fingerScanId": fingerScanId,
        "startDate": startDate,
        "endDate": endDate,
        "noted": noted,
        "email": email,
        "departmentData": departmentData.toJson(),
        "staffStatusData": staffStatusData.toJson(),
        "staffTypeData": staffTypeData.toJson(),
        "positionData": positionData.toJson(),
        "shiftData": shiftData.toJson(),
      };
}

class DepartmentData {
  String deptCode;
  String deptNameEn;
  String deptNameTh;
  String deptStatus;

  DepartmentData({
    required this.deptCode,
    required this.deptNameEn,
    required this.deptNameTh,
    required this.deptStatus,
  });

  factory DepartmentData.fromJson(Map<String, dynamic> json) => DepartmentData(
        deptCode: json["deptCode"],
        deptNameEn: json["deptNameEn"],
        deptNameTh: json["deptNameTh"],
        deptStatus: json["deptStatus"],
      );

  Map<String, dynamic> toJson() => {
        "deptCode": deptCode,
        "deptNameEn": deptNameEn,
        "deptNameTh": deptNameTh,
        "deptStatus": deptStatus,
      };
}

class PersonData {
  String personId;
  TitleName titleName;
  String fisrtNameTh;
  String firstNameEn;
  String midNameTh;
  String midNameEn;
  String lastNameTh;
  String lastNameEn;
  String email;
  String phoneNumber1;
  String phoneNumber2;
  String age;
  String dateOfBirth;
  String height;
  String weight;
  BloodGroup bloodGroup;
  Gender gender;
  MaritalStatus maritalStatus;
  Nationality nationality;
  Race race;
  Religion religion;
  bool personStatus;

  PersonData({
    required this.personId,
    required this.titleName,
    required this.fisrtNameTh,
    required this.firstNameEn,
    required this.midNameTh,
    required this.midNameEn,
    required this.lastNameTh,
    required this.lastNameEn,
    required this.email,
    required this.phoneNumber1,
    required this.phoneNumber2,
    required this.age,
    required this.dateOfBirth,
    required this.height,
    required this.weight,
    required this.bloodGroup,
    required this.gender,
    required this.maritalStatus,
    required this.nationality,
    required this.race,
    required this.religion,
    required this.personStatus,
  });

  factory PersonData.fromJson(Map<String, dynamic> json) => PersonData(
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
        personStatus: json["personStatus"],
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
        "personStatus": personStatus,
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

class EmployeeDatumPositionData {
  String positionOrganizationId;
  ParentPositionBusinessNodeIdPositionData positionData;
  OrganizationData organizationData;
  JobTitleData jobTitleData;
  PositionTypeData positionTypeData;
  String status;
  ParentPositionNodeId parentPositionBusinessNodeId;
  ParentPositionNodeId parentPositionNodeId;
  EmployeeDataa employeeData;
  String validFromDate;
  String endDate;
  String startingSalary;

  EmployeeDatumPositionData({
    required this.positionOrganizationId,
    required this.positionData,
    required this.organizationData,
    required this.jobTitleData,
    required this.positionTypeData,
    required this.status,
    required this.parentPositionBusinessNodeId,
    required this.parentPositionNodeId,
    required this.employeeData,
    required this.validFromDate,
    required this.endDate,
    required this.startingSalary,
  });

  factory EmployeeDatumPositionData.fromJson(Map<String, dynamic> json) =>
      EmployeeDatumPositionData(
        positionOrganizationId: json["positionOrganizationId"],
        positionData: ParentPositionBusinessNodeIdPositionData.fromJson(
            json["positionData"]),
        organizationData: OrganizationData.fromJson(json["organizationData"]),
        jobTitleData: JobTitleData.fromJson(json["jobTitleData"]),
        positionTypeData: PositionTypeData.fromJson(json["positionTypeData"]),
        status: json["status"],
        parentPositionBusinessNodeId:
            ParentPositionNodeId.fromJson(json["parentPositionBusinessNodeId"]),
        parentPositionNodeId:
            ParentPositionNodeId.fromJson(json["parentPositionNodeId"]),
        employeeData: EmployeeDataa.fromJson(json["employeeData"]),
        validFromDate: json["validFromDate"],
        endDate: json["endDate"],
        startingSalary: json["startingSalary"],
      );

  Map<String, dynamic> toJson() => {
        "positionOrganizationId": positionOrganizationId,
        "positionData": positionData.toJson(),
        "organizationData": organizationData.toJson(),
        "jobTitleData": jobTitleData.toJson(),
        "positionTypeData": positionTypeData.toJson(),
        "status": status,
        "parentPositionBusinessNodeId": parentPositionBusinessNodeId.toJson(),
        "parentPositionNodeId": parentPositionNodeId.toJson(),
        "employeeData": employeeData.toJson(),
        "validFromDate": validFromDate,
        "endDate": endDate,
        "startingSalary": startingSalary,
      };
}

class EmployeeDataa {
  String employeeId;
  String employeeFirstNameTh;
  String employeeLastNameTh;
  String employeeFirstNameEn;
  String employeeLastNameEn;

  EmployeeDataa({
    required this.employeeId,
    required this.employeeFirstNameTh,
    required this.employeeLastNameTh,
    required this.employeeFirstNameEn,
    required this.employeeLastNameEn,
  });

  factory EmployeeDataa.fromJson(Map<String, dynamic> json) => EmployeeDataa(
        employeeId: json["employeeId"],
        employeeFirstNameTh: json["employeeFirstNameTh"],
        employeeLastNameTh: json["employeeLastNameTh"],
        employeeFirstNameEn: json["employeeFirstNameEn"],
        employeeLastNameEn: json["employeeLastNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "employeeFirstNameTh": employeeFirstNameTh,
        "employeeLastNameTh": employeeLastNameTh,
        "employeeFirstNameEn": employeeFirstNameEn,
        "employeeLastNameEn": employeeLastNameEn,
      };
}

class JobTitleData {
  String jobTitleId;
  String? jobTitleName;

  JobTitleData({
    required this.jobTitleId,
    required this.jobTitleName,
  });

  factory JobTitleData.fromJson(Map<String, dynamic> json) => JobTitleData(
        jobTitleId: json["jobTitleId"],
        jobTitleName: json["jobTitleName"],
      );

  Map<String, dynamic> toJson() => {
        "jobTitleId": jobTitleId,
        "jobTitleName": jobTitleName,
      };
}

class OrganizationData {
  String organizationId;
  String organizationCode;
  DepartmentData departMentData;
  ParentOrganizationNodeData parentOrganizationNodeData;
  ParentOrganizationNodeData parentOrganizationBusinessNodeData;
  OrganizationTypeData organizationTypeData;
  String organizationStatus;
  String validFrom;
  String endDate;

  OrganizationData({
    required this.organizationId,
    required this.organizationCode,
    required this.departMentData,
    required this.parentOrganizationNodeData,
    required this.parentOrganizationBusinessNodeData,
    required this.organizationTypeData,
    required this.organizationStatus,
    required this.validFrom,
    required this.endDate,
  });

  factory OrganizationData.fromJson(Map<String, dynamic> json) =>
      OrganizationData(
        organizationId: json["organizationId"],
        organizationCode: json["organizationCode"],
        departMentData: DepartmentData.fromJson(json["departMentData"]),
        parentOrganizationNodeData: ParentOrganizationNodeData.fromJson(
            json["parentOrganizationNodeData"]),
        parentOrganizationBusinessNodeData: ParentOrganizationNodeData.fromJson(
            json["parentOrganizationBusinessNodeData"]),
        organizationTypeData:
            OrganizationTypeData.fromJson(json["organizationTypeData"]),
        organizationStatus: json["organizationStatus"],
        validFrom: json["validFrom"],
        endDate: json["endDate"],
      );

  Map<String, dynamic> toJson() => {
        "organizationId": organizationId,
        "organizationCode": organizationCode,
        "departMentData": departMentData.toJson(),
        "parentOrganizationNodeData": parentOrganizationNodeData.toJson(),
        "parentOrganizationBusinessNodeData":
            parentOrganizationBusinessNodeData.toJson(),
        "organizationTypeData": organizationTypeData.toJson(),
        "organizationStatus": organizationStatus,
        "validFrom": validFrom,
        "endDate": endDate,
      };
}

class OrganizationTypeData {
  String organizationTypeId;
  String organizationTypeName;

  OrganizationTypeData({
    required this.organizationTypeId,
    required this.organizationTypeName,
  });

  factory OrganizationTypeData.fromJson(Map<String, dynamic> json) =>
      OrganizationTypeData(
        organizationTypeId: json["organizationTypeId"],
        organizationTypeName: json["organizationTypeName"],
      );

  Map<String, dynamic> toJson() => {
        "organizationTypeId": organizationTypeId,
        "organizationTypeName": organizationTypeName,
      };
}

class ParentOrganizationNodeData {
  String organizationId;
  String organizationCode;
  String organizationName;

  ParentOrganizationNodeData({
    required this.organizationId,
    required this.organizationCode,
    required this.organizationName,
  });

  factory ParentOrganizationNodeData.fromJson(Map<String, dynamic> json) =>
      ParentOrganizationNodeData(
        organizationId: json["organizationId"],
        organizationCode: json["organizationCode"],
        organizationName: json["organizationName"],
      );

  Map<String, dynamic> toJson() => {
        "organizationId": organizationId,
        "organizationCode": organizationCode,
        "organizationName": organizationName,
      };
}

class ParentPositionNodeId {
  String positionOrganizationId;
  ParentPositionBusinessNodeIdPositionData positionData;

  ParentPositionNodeId({
    required this.positionOrganizationId,
    required this.positionData,
  });

  factory ParentPositionNodeId.fromJson(Map<String, dynamic> json) =>
      ParentPositionNodeId(
        positionOrganizationId: json["positionOrganizationId"],
        positionData: ParentPositionBusinessNodeIdPositionData.fromJson(
            json["positionData"]),
      );

  Map<String, dynamic> toJson() => {
        "positionOrganizationId": positionOrganizationId,
        "positionData": positionData.toJson(),
      };
}

class ParentPositionBusinessNodeIdPositionData {
  String positionId;
  String positionNameTh;

  ParentPositionBusinessNodeIdPositionData({
    required this.positionId,
    required this.positionNameTh,
  });

  factory ParentPositionBusinessNodeIdPositionData.fromJson(
          Map<String, dynamic> json) =>
      ParentPositionBusinessNodeIdPositionData(
        positionId: json["positionId"],
        positionNameTh: json["positionNameTh"],
      );

  Map<String, dynamic> toJson() => {
        "positionId": positionId,
        "positionNameTh": positionNameTh,
      };
}

class PositionTypeData {
  String positionTypeId;
  String? positionTypeNameTh;

  PositionTypeData({
    required this.positionTypeId,
    required this.positionTypeNameTh,
  });

  factory PositionTypeData.fromJson(Map<String, dynamic> json) =>
      PositionTypeData(
        positionTypeId: json["positionTypeId"],
        positionTypeNameTh: json["positionTypeNameTH"],
      );

  Map<String, dynamic> toJson() => {
        "positionTypeId": positionTypeId,
        "positionTypeNameTH": positionTypeNameTh,
      };
}

class ShiftData {
  String shiftId;
  String shiftName;
  String startTime;
  String endTime;
  String validFrom;
  String endDate;
  String shiftStatus;

  ShiftData({
    required this.shiftId,
    required this.shiftName,
    required this.startTime,
    required this.endTime,
    required this.validFrom,
    required this.endDate,
    required this.shiftStatus,
  });

  factory ShiftData.fromJson(Map<String, dynamic> json) => ShiftData(
        shiftId: json["shiftId"],
        shiftName: json["shiftName"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        validFrom: json["validFrom"],
        endDate: json["endDate"],
        shiftStatus: json["shiftStatus"],
      );

  Map<String, dynamic> toJson() => {
        "shiftId": shiftId,
        "shiftName": shiftName,
        "startTime": startTime,
        "endTime": endTime,
        "validFrom": validFrom,
        "endDate": endDate,
        "shiftStatus": shiftStatus,
      };
}

class StaffStatusData {
  String staffStatusId;
  String description;

  StaffStatusData({
    required this.staffStatusId,
    required this.description,
  });

  factory StaffStatusData.fromJson(Map<String, dynamic> json) =>
      StaffStatusData(
        staffStatusId: json["staffStatusId"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "staffStatusId": staffStatusId,
        "description": description,
      };
}

class StaffTypeData {
  String staffTypeId;
  String description;

  StaffTypeData({
    required this.staffTypeId,
    required this.description,
  });

  factory StaffTypeData.fromJson(Map<String, dynamic> json) => StaffTypeData(
        staffTypeId: json["staffTypeId"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "staffTypeId": staffTypeId,
        "description": description,
      };
}
