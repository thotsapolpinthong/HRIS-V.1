import 'dart:convert';
import 'package:hris_app_prototype/src/model/cardinfomation/idcard/delete/delidcard_model.dart';
import 'package:hris_app_prototype/src/model/contact_person/add/create_contact_model.dart';
import 'package:hris_app_prototype/src/model/contact_person/delete/delete_contact_model.dart';
import 'package:hris_app_prototype/src/model/contact_person/getdata_contact_model.dart';
import 'package:hris_app_prototype/src/model/contact_person/update/update_contact_model.dart';
import 'package:hris_app_prototype/src/model/education/add/create_education_model.dart';
import 'package:hris_app_prototype/src/model/education/delete/delete_education_model.dart';
import 'package:hris_app_prototype/src/model/education/dropdown/create_institute.dart';
import 'package:hris_app_prototype/src/model/education/dropdown/create_major.dart';
import 'package:hris_app_prototype/src/model/education/dropdown/create_qualificaion.dart';
import 'package:hris_app_prototype/src/model/education/dropdown/education_level_model.dart';
import 'package:hris_app_prototype/src/model/education/dropdown/education_qualification_model.dart';
import 'package:hris_app_prototype/src/model/education/dropdown/institute_model.dart';
import 'package:hris_app_prototype/src/model/education/dropdown/major_madel.dart';
import 'package:hris_app_prototype/src/model/education/dropdown/response_institute_model.dart';
import 'package:hris_app_prototype/src/model/education/dropdown/response_major_model.dart';
import 'package:hris_app_prototype/src/model/education/dropdown/response_qualification_model.dart';
import 'package:hris_app_prototype/src/model/education/getdata_education_model.dart';
import 'package:hris_app_prototype/src/model/education/update/update_education_model.dart';
import 'package:hris_app_prototype/src/model/family_member/add/create_family_model.dart';
import 'package:hris_app_prototype/src/model/family_member/delete/delete_family_model.dart';
import 'package:hris_app_prototype/src/model/family_member/dropdown/family_type_model.dart';
import 'package:hris_app_prototype/src/model/family_member/dropdown/vital_status_model.dart';
import 'package:hris_app_prototype/src/model/family_member/get_family_by_id_model.dart';
import 'package:hris_app_prototype/src/model/family_member/update/update_family.dart';
import 'package:hris_app_prototype/src/model/person/deleteperson_madel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:hris_app_prototype/src/model/address/addAddress/add_address_model.dart';
import 'package:hris_app_prototype/src/model/address/delete/delete_address_model.dart';
import 'package:hris_app_prototype/src/model/address/dropdown/country_model.dart';
import 'package:hris_app_prototype/src/model/address/update/update_address-model.dart';
import 'package:hris_app_prototype/src/model/cardinfomation/idcard/add/create_idcard_model.dart';
import 'package:hris_app_prototype/src/model/cardinfomation/idcard/update/getidentifycard_model.dart';
import 'package:hris_app_prototype/src/model/cardinfomation/idcard/update/updateidcard_model.dart';
import 'package:hris_app_prototype/src/model/cardinfomation/passport/add/createpassport_model.dart';
import 'package:hris_app_prototype/src/model/cardinfomation/passport/update/editpassport_model.dart';
import 'package:hris_app_prototype/src/model/cardinfomation/passport/update/getpassport_model.dart';
import 'package:hris_app_prototype/src/model/person/createperson_model.dart';
import 'package:hris_app_prototype/src/model/person/generate_personId_model.dart';
import 'package:hris_app_prototype/src/model/person/personbyId_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Login/login_model.dart';
import '../model/address/addressbyperson_model.dart';
import '../model/address/dropdown/addresstype_model.dart';
import '../model/address/dropdown/district_model.dart';
import '../model/address/dropdown/province.dart';
import '../model/address/dropdown/subdistrict_Model.dart';
import '../model/person/allperson_model.dart';
import '../model/person/dropdown/bloodgroup_model.dart';
import '../model/person/dropdown/gender_model.dart';
import '../model/person/dropdown/maritalstatus_model.dart';
import '../model/person/dropdown/national_model.dart';
import '../model/person/dropdown/race_model.dart';
import '../model/person/dropdown/religion.model.dart';
import '../model/person/dropdown/title.dart';
import '../model/person/update_person_model.dart';

class ApiService {
  static String baseUrl = "http://192.168.0.205/StecApi/Hr";
  static String sharedToken = "";

  //login----------------------------------------------------------------

  static Future<LoginModel?> postApiLogin(
      String username, String password) async {
    final response = await http.post(
      Uri.parse("http://192.168.0.205/StecApi/Login"),
      headers: {"accept": "text/plain"},
      body: {
        'userName': username,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      return loginModelFromJson(response.body);
    } else {
      return null;
    }
  }
  //end login----------------------------------------------------------------

//personalData----------------------------------------------------------------

  //ดึงข้อมูลพนักงานทั้งหมด
  static Future<PersonData?> fetchAllPersonalData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetPersonAll"),
      headers: {
        "Authorization": "Bearer $sharedToken",
      },
    );
    if (response.statusCode == 200) {
      PersonData data = personDataFromJson(response.body);
      if (data.status == true) {
        return data;
      }
    }
    return null;
  }

  static Future<PersonData?> fetchPersonalNotInEmployeeData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetPersonNotInEmployee"),
      headers: {
        "Authorization": "Bearer $sharedToken",
      },
    );
    if (response.statusCode == 200) {
      PersonData data = personDataFromJson(response.body);
      if (data.status == true) {
        return data;
      }
    }
    return null;
  }

  static Future<PersonByIdModel?> fetchPersonById(String personId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse(
          'http://192.168.0.205/StecApi/Hr/GetPersonById?personId=$personId'),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      PersonByIdModel data = personByIdModelFromJson(response.body);
      if (data.status == true) {
        return data;
      }
    }
    return null;
  }

  static Future updatePersonbyId(PersonUpdateModel updatedatamodel) async {
    bool isUpdate = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.put(
      Uri.parse("$baseUrl/EditPersonById"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(updatedatamodel.toJson()),
    );
    if (response.statusCode == 200) {
      isUpdate = true;
      return isUpdate;
    } else {
      return isUpdate;
    }
  }

//======================Add Person==============================
  static Future generatePersonId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("http://192.168.0.205/StecApi/Hr/NewPersonId"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      AddModel dataId = addModelFromJson(response.body);
      if (dataId.status == true) {
        return dataId;
      }
    } else {
      return null;
    }
  }

  static Future addPersonalData(PersonCreateModel? updateperson) async {
    bool addpersondata = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    const updateUrl = "http://192.168.0.205/StecApi/Hr/CreateNewPerson";
    final response = await http.post(
      Uri.parse(updateUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(updateperson!.toJson()),
    );
    if (response.statusCode == 200) {
      PersonByIdModel data = personByIdModelFromJson(response.body);
      if (data.status == true) {
        return addpersondata = true;
      } else {
        return addpersondata;
      }
    } else {
      return addpersondata;
    }
  }

  static Future addAddressByTypeAndId(Createaddressmodel? createaddress) async {
    bool addpermanent = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/CreateNewAddress"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createaddress!.toJson()),
    );
    if (response.statusCode == 200) {
      AddressbypersonModel data = addressbypersonModelFromJson(response.body);
      if (data.status == true) {
        return addpermanent = true;
      } else {
        return addpermanent;
      }
    } else {
      return addpermanent;
    }
  }

  //====================End Add==============================

  // delet person================
  static Future delPerson(DeletepersonModel delPerson) async {
    bool isdel = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.delete(
      Uri.parse("$baseUrl/DeletePersonById"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(delPerson),
    );
    if (response.statusCode == 200) {
      isdel = true;
      return isdel;
    } else {
      return isdel;
    }
  }
  //---===============================
//end personalData----------------------------------------------------------------

  //-------------DropDown ----------------------------------------------------------------
  static const String baseUrlDropdown = "http://192.168.0.205/StecApi/Hr";
//titles
  static getTitle() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrlDropdown/GetTitleNameAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      TitleModel data = titleModelFromJson(response.body);
      return data;
    }
  }

//gender
  static getGender() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrlDropdown/GetGenderAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      GenderModel data = genderModelFromJson(response.body);
      return data;
    }
  }

  //BloodGroup
  static getBloodGroup() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrlDropdown/GetBloodAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      BloodGroupModel data = bloodGroupModelFromJson(response.body);
      return data;
    }
  }

  //MaritalStatus
  static getMaritalStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrlDropdown/GetMaritalStatusAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      MaritalStatusModel data = maritalStatusModelFromJson(response.body);
      return data;
    }
  }

  //Race
  static getRaceStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrlDropdown/GetRaceAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      RaceModel data = raceModelFromJson(response.body);
      return data;
    }
  }

  //Religion
  static getReligionStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrlDropdown/GetReligionAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      ReligionModel data = religionModelFromJson(response.body);
      return data;
    }
  }

  //nationality
  static getNationalityStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrlDropdown/getNationalityAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      NationalityModel data = nationalityModelFromJson(response.body);
      return data;
    }
  }

  //-----End Dropdown-------------------------------------------------------------

//---------address ------------------------------------------------

  static getAddressByPersonById(String personid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetAddressByPersonById?personId=$personid"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      AddressbypersonModel data = addressbypersonModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        (kDebugMode);
      }
    } else {
      (kDebugMode);
    }
  }

  static getTypeaddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrlDropdown/GetAdressTypeAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      AddressTypeModel dataTypeaddress =
          addressTypeModelFromJson(response.body);
      if (dataTypeaddress.status == true) {
        return dataTypeaddress;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future updateAddressbyId(
      UpdateAddressbypersonModel updateAddressbyid) async {
    bool isUpdate = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.put(
      Uri.parse("$baseUrl/UpdateAddress"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(updateAddressbyid.toJson()),
    );
    if (response.statusCode == 200) {
      isUpdate = true;
      return isUpdate;
    } else {
      return isUpdate;
    }
  }

//-----------------------------------------dropdown
  static getCountry() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrlDropdown/GetCountryAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      CountryDataModel dataCountry = countryDataModelFromJson(response.body);
      if (dataCountry.status == true) {
        return dataCountry;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static getProvince() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrlDropdown/GetProvinceAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      ProvinceModel dataProvince = provinceModelFromJson(response.body);
      return dataProvince;
    }
  }

  static getdistrict(String provinceid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse(
          "$baseUrlDropdown/GetDistrictByProvinceId?provinceId=$provinceid"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      DistrictModel districdata = districtModelFromJson(response.body);
      return districdata;
    }
  }

  static getsubdistrict(String districtid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse(
          "$baseUrlDropdown/GetSubDistrictByDistrictId?districtId=$districtid"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      SubdistrictModel subDistricData = subdistrictModelFromJson(response.body);
      return subDistricData;
    }
  }
//end address ------------------------------------------------

//delete----------------------------------------------------

//del addresses ------------------------------------------------
  static Future delAddressId(DeleteAddressModel delAddressId) async {
    bool isdel = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.delete(
      Uri.parse("$baseUrl/DeleteAddress"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(delAddressId.toJson()),
    );
    if (response.statusCode == 200) {
      isdel = true;
      return isdel;
    } else {
      return isdel;
    }
  }

//end address ------------------------------------------------

//Card information ------------------------------------------------
//get
  static Future<GetIdCardModel?> fetchIDcardData(String personId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetPersonalCardByPersonId?personId=$personId"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      GetIdCardModel data = getIdCardModelFromJson(response.body);
      if (data.status == true) {
        return data;
      }
    }
    return null;
  }

  static Future<Getpassport?> fetchPassportData(String personId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetPassportByPersonId?personId=$personId"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      Getpassport data = getpassportFromJson(response.body);
      if (data.status == true) {
        return data;
      }
    }
    return null;
  }

//edit
  static Future updateIdCard(UpdateIdcardModel idcardModel) async {
    bool isUpdate = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.put(
      Uri.parse("$baseUrl/EditPersonalCard"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(idcardModel.toJson()),
    );
    if (response.statusCode == 200) {
      isUpdate = true;
      return isUpdate;
    } else {
      return isUpdate;
    }
  }

  static Future updatePassport(EditPassportModel passportModel) async {
    bool isUpdate = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.put(
      Uri.parse("$baseUrl/EditPassport"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(passportModel.toJson()),
    );
    if (response.statusCode == 200) {
      isUpdate = true;
      return isUpdate;
    } else {
      return isUpdate;
    }
  }

//add
  static Future addIdCardbyId(AddNewIdcardModel? addIdcardModel) async {
    bool addIdcard = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewPersonalCard"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(addIdcardModel!.toJson()),
    );
    if (response.statusCode == 200) {
      GetIdCardModel data = getIdCardModelFromJson(response.body);
      if (data.status == true) {
        return addIdcard = true;
      } else {
        return addIdcard;
      }
    } else {
      return addIdcard;
    }
  }

  static Future addPassportbyId(CreatePassportModel? addPassportModel) async {
    bool addPassport = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewPassport"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(addPassportModel!.toJson()),
    );
    if (response.statusCode == 200) {
      Getpassport data = getpassportFromJson(response.body);
      if (data.status == true) {
        return addPassport = true;
      } else {
        return addPassport;
      }
    } else {
      return addPassport;
    }
  }

//delete
  static Future delId(DeleteIdcardModel delId) async {
    bool isdel = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.delete(
      Uri.parse("$baseUrl/DeletePersonalCard"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(delId.toJson()),
    );
    if (response.statusCode == 200) {
      isdel = true;
      return isdel;
    } else {
      return isdel;
    }
  }

  static Future delPassport(DeleteIdcardModel delId) async {
    bool isdel = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.delete(
      Uri.parse("$baseUrl/DeletePassport"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(delId.toJson()),
    );
    if (response.statusCode == 200) {
      isdel = true;
      return isdel;
    } else {
      return isdel;
    }
  }
//End card information ------------------------------------------------

//Education Information ------------------------------------------------

//dropdown
  static getEducationLevelDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("http://192.168.0.205/StecApi/Hr/GetEducationLevelAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      EducationLevelModel data = educationLevelModelFromJson(response.body);
      if (data.status == true) {
        List<EducationLevelDatum> dataList = data.educationLevelData;
        return dataList;
      }
      return data;
    }
  }

  static getEducationQualificationDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrlDropdown/GetEducationQualificationAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      EducationQualificationModel data =
          educationQualificationModelFromJson(response.body);
      if (data.status == true) {
        List<EducationQualificationDatum> dataList =
            data.educationQualificationData;
        return dataList;
      }
      return data;
    }
  }

  static Future createEducationQualificationDropdown(
      CreateQualificaionThModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewEducationQualification"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseQualificaionThModel data =
          responseQualificaionThModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  static getInstitueDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrlDropdown/GetInstitueAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      InstituteModel data = instituteModelFromJson(response.body);
      if (data.status == true) {
        List<InstituteDatum> dataList = data.instituteData;
        return dataList;
      }
      return data;
    }
  }

  static Future createInstitueDropdown(
      CreateinstituteModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewInstitue"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseInstituteModel data =
          responseInstituteModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  static getMajorDropdown(String educationQualificationId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse(
          "$baseUrlDropdown/GetMajorAll?educationQualificationId=$educationQualificationId"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      MajorModel data = majorModelFromJson(response.body);
      if (data.status == true) {
        List<MajorDatum> dataList = data.majorData;
        return dataList;
      }
      return data;
    }
  }

  static Future createMajorDropdown(CreateMajorModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewMajor"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseMajorModel data = responseMajorModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

//get education by personid
  static Future<GetEducationModel?> getEducationById(String personId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse(
          'http://192.168.0.205/StecApi/Hr/GetEducationByPersonId?personId=$personId'),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      GetEducationModel data = getEducationModelFromJson(response.body);
      if (data.status == true) {
        return data;
      }
    }
    return null;
  }

//created
  static Future addEducationbyId(CreateeducationModel? createEducation) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewEducation"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createEducation!.toJson()),
    );
    if (response.statusCode == 200) {
      GetEducationModel data = getEducationModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

//updated
  static Future updateEducation(UpdateEducationModel educationModel) async {
    bool isUpdate = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.put(
      Uri.parse("$baseUrl/UpdateEducationById"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(educationModel.toJson()),
    );
    if (response.statusCode == 200) {
      isUpdate = true;
      return isUpdate;
    } else {
      return isUpdate;
    }
  }
//deleted

  static Future deleteEducation(DeleteEducationModel delEdication) async {
    bool isdel = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.delete(
      Uri.parse("$baseUrl/DeleteEducationById"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(delEdication.toJson()),
    );
    if (response.statusCode == 200) {
      isdel = true;
      return isdel;
    } else {
      return isdel;
    }
  }
// End Education ------------------------------------------------

// Family Member Information----------------------------------------------------

// dropdown
  static getFamilyTypeDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrlDropdown/GetFamilyMemberTypeAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      FamilyMembersTypeModel data =
          familyMembersTypeModelFromJson(response.body);
      if (data.status == true) {
        List<FamilyMembersTypeDatum> dataList = data.familyMembersTypeData;
        return dataList;
      }
      return data;
    }
  }

  static getVitalStatusDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrlDropdown/GetVitalStatusAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      VitalStatusModel data = vitalStatusModelFromJson(response.body);
      if (data.status == true) {
        List<VitalStatusDatum> dataList = data.vitalStatusData;
        return dataList;
      }
      return data;
    }
  }

//get family by id
  static Future<FamilyMemberDataModel?> getFamilyById(String personId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse(
          'http://192.168.0.205/StecApi/Hr/GetFamilyMemberByPersonId?personId=$personId'),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      FamilyMemberDataModel data = familyMemberDataModelFromJson(response.body);
      if (data.status == true) {
        return data;
      }
    }
    return null;
  }

//created
  static Future createFamilyById(CreateFamilyModel? createFamilyModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewFamilyMember"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createFamilyModel!.toJson()),
    );
    if (response.statusCode == 200) {
      FamilyMemberDataModel data = familyMemberDataModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

//updated
  static Future updateFamilyById(UpdateFamilyModel updateFamilyModel) async {
    bool isUpdate = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.put(
      Uri.parse("$baseUrl/UpdateFamilyMemberById"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(updateFamilyModel.toJson()),
    );
    if (response.statusCode == 200) {
      isUpdate = true;
      return isUpdate;
    } else {
      return isUpdate;
    }
  }

//deleted
  static Future deleteFamilyMember(DeleteFamilyModel deleteFamilyModel) async {
    bool isdel = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.delete(
      Uri.parse("$baseUrl/DeleteFamilyModelById"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(deleteFamilyModel.toJson()),
    );
    if (response.statusCode == 200) {
      isdel = true;
      return isdel;
    } else {
      return isdel;
    }
  }
//End Family Member Information--------------------------------

// Person Contact Information--------------------------------
//get contact information
  static Future<GetDataContact?> getContactById(String personId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse(
          'http://192.168.0.205/StecApi/Hr/GetContactPersonInfoByPersonId?personId=$personId'),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      GetDataContact data = getDataContactFromJson(response.body);
      if (data.status == true) {
        return data;
      }
    }
    return null;
  }

//created
  static Future createContactById(
      CreateContactModel? createContactModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewContactPersonInfo"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createContactModel!.toJson()),
    );
    if (response.statusCode == 200) {
      GetDataContact data = getDataContactFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

//updated
  static Future updateContactById(UpdateContactModel updateContactModel) async {
    bool isUpdate = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.put(
      Uri.parse("$baseUrl/UpdateContactPersonInfoById"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(updateContactModel.toJson()),
    );
    if (response.statusCode == 200) {
      isUpdate = true;
      return isUpdate;
    } else {
      return isUpdate;
    }
  }

//deleted
  static Future deleteContactById(DeleteContactModel deleteContactModel) async {
    bool isdel = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.delete(
      Uri.parse("$baseUrl/DeleteContactPersonInfoById"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(deleteContactModel.toJson()),
    );
    if (response.statusCode == 200) {
      isdel = true;
      return isdel;
    } else {
      return isdel;
    }
  }
//----------------------------------------------------------------
}
