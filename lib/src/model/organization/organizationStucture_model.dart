import 'dart:convert';

GetOrganizationStucture getOrganizationStuctureFromJson(String str) =>
    GetOrganizationStucture.fromJson(json.decode(str));

String getOrganizationStuctureToJson(GetOrganizationStucture data) =>
    json.encode(data.toJson());

class GetOrganizationStucture {
  String organizationId;
  String department;
  String organizationParentId;
  List<GetOrganizationStucture> children;
  List<PositionOrganization> positionOrganization;

  GetOrganizationStucture({
    required this.organizationId,
    required this.department,
    required this.organizationParentId,
    required this.children,
    required this.positionOrganization,
  });

  factory GetOrganizationStucture.fromJson(Map<String, dynamic> json) =>
      GetOrganizationStucture(
        organizationId: json["organizationId"],
        department: json["department"],
        organizationParentId: json["organizationParentId"],
        children: List<GetOrganizationStucture>.from(
            json["children"].map((x) => GetOrganizationStucture.fromJson(x))),
        positionOrganization: List<PositionOrganization>.from(
            json["positionOrganization"]
                .map((x) => PositionOrganization.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "organizationId": organizationId,
        "department": department,
        "organizationParentId": organizationParentId,
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
        "positionOrganization":
            List<dynamic>.from(positionOrganization.map((x) => x.toJson())),
      };
}

class PositionOrganization {
  String positionOrganizatioId;
  String positionOrganizatioName;
  EmployeeTreeData employeeTreeData;

  PositionOrganization({
    required this.positionOrganizatioId,
    required this.positionOrganizatioName,
    required this.employeeTreeData,
  });

  factory PositionOrganization.fromJson(Map<String, dynamic> json) =>
      PositionOrganization(
        positionOrganizatioId: json["positionOrganizatioId"],
        positionOrganizatioName: json["positionOrganizatioName"],
        employeeTreeData: EmployeeTreeData.fromJson(json["employeeTreeData"]),
      );

  Map<String, dynamic> toJson() => {
        "positionOrganizatioId": positionOrganizatioId,
        "positionOrganizatioName": positionOrganizatioName,
        "employeeTreeData": employeeTreeData.toJson(),
      };
}

class EmployeeTreeData {
  String employeeId;
  String firstName;
  String lastName;
  DateTime startDate;
  String employeeType;
  String status;

  EmployeeTreeData({
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.startDate,
    required this.employeeType,
    required this.status,
  });

  factory EmployeeTreeData.fromJson(Map<String, dynamic> json) =>
      EmployeeTreeData(
        employeeId: json["employeeId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        startDate: DateTime.parse(json["startDate"]),
        employeeType: json["employeeType"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "firstName": firstName,
        "lastName": lastName,
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "employeeType": employeeType,
        "status": status,
      };
}
