import 'dart:convert';

import 'package:hris_app_prototype/src/model/trip/cancel_trip_model.dart';
import 'package:hris_app_prototype/src/model/trip/cars/change_car_model.dart';
import 'package:hris_app_prototype/src/model/trip/cars/check_car_model.dart';
import 'package:hris_app_prototype/src/model/trip/cars/dropdown_car_type_model.dart';
import 'package:hris_app_prototype/src/model/trip/cars/response_car_model.dart';
import 'package:hris_app_prototype/src/model/trip/cars/update_car_model.dart';
import 'package:hris_app_prototype/src/model/trip/cars/create_car_model.dart';
import 'package:hris_app_prototype/src/model/trip/create_trip_model.dart';
import 'package:hris_app_prototype/src/model/trip/cars/cars_model.dart';
import 'package:hris_app_prototype/src/model/trip/dropdown_province_model.dart';
import 'package:hris_app_prototype/src/model/trip/dropdown_tripertype_model.dart';
import 'package:hris_app_prototype/src/model/trip/dropdown_triptype_model.dart';
import 'package:hris_app_prototype/src/model/trip/finish_trip_model.dart';
import 'package:hris_app_prototype/src/model/trip/get_trip_by_id_model.dart';
import 'package:hris_app_prototype/src/model/trip/hotels/create_hotel_model.dart';
import 'package:hris_app_prototype/src/model/trip/hotels/dropdown_hotel_type_model.dart';
import 'package:hris_app_prototype/src/model/trip/hotels/hotel_data_all_model.dart';
import 'package:hris_app_prototype/src/model/trip/hotels/response_hotel_model.dart';
import 'package:hris_app_prototype/src/model/trip/hotels/update_hotel_model.dart';
import 'package:hris_app_prototype/src/model/trip/move_triper_model.dart';
import 'package:hris_app_prototype/src/model/trip/response_trip_model.dart';
import 'package:hris_app_prototype/src/model/trip/response_triper_model.dart';
import 'package:hris_app_prototype/src/model/trip/trip_data_all_model.dart';
import 'package:hris_app_prototype/src/model/trip/update_trip_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiTripService {
  static String baseUrl = "http://192.168.0.205/StecApi/Hr";
  static String sharedToken = "";

//car dropdown
  static getCarsDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetCar"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      CarsModel data = carsModelFromJson(response.body);
      return data;
    } else {
      return null;
    }
  }

//car on trip dropdown
  static getCarsOnTripDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetCarOnTrip"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      CarsModel data = carsModelFromJson(response.body);
      return data;
    } else {
      return null;
    }
  }

//triptype dropdown
  static getTripTypeDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetTripTypeAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      TripTypeDropdownModel data = tripTypeDropdownModelFromJson(response.body);
      return data;
    } else {
      return null;
    }
  }

  //tripertype dropdown
  static getTriperTypeDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetTravelRequestTypeAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      TriperTypeDropdownModel data =
          triperTypeDropdownModelFromJson(response.body);
      return data;
    } else {
      return null;
    }
  }

  //province dropdown
  static getProvinceDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetProvinceAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      ProvinceDropdownModel data = provinceDropdownModelFromJson(response.body);
      return data;
    } else {
      return null;
    }
  }

  //createTrip
  static Future createTrip(CreateTripModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewTrip"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseCreateTripModel data =
          responseCreateTripModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

//get trip data
  static Future<TripDataModel?> getAllTripData(
      String startDate, String endDate) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse(
          "http://192.168.0.205/StecApi/Hr/GetTripAll?startDate=$startDate&endDate=$endDate"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      TripDataModel? data = tripDataModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<TripDataModel?> getTripDataDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse("$baseUrl/GetTrip"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      TripDataModel? data = tripDataModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

//
  static Future<TripDataByIdModel?> getTripDataById(String tripId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse("$baseUrl/GetTripById?tripId=$tripId&condition=get"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      TripDataByIdModel? data = tripDataByIdModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  //updateTrip
  static Future updateTrip(UpdateTripModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.put(
      Uri.parse("$baseUrl/UpdateTrip"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseCreateTripModel data =
          responseCreateTripModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

//cancel trip
  static Future cancelTrip(CancelTripModel? cancelModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.put(
      Uri.parse(
          "$baseUrl/CancelTrip?tripId=${cancelModel!.tripId}&cancelBy=${cancelModel.cancelBy}&condition=cancel&comment=${cancelModel.comment}"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
    );
    if (response.statusCode == 200) {
      ResponseCreateTripModel data =
          responseCreateTripModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  //finish trip
  static Future finishTrip(FinishTripModel? finishModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.put(
      Uri.parse(
          "$baseUrl/FinishTrip?tripId=${finishModel!.tripId}&endMileageNumber=${finishModel.endMileageNumber}&finishBy=${finishModel.finishBy}"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
    );
    if (response.statusCode == 200) {
      ResponseCreateTripModel data =
          responseCreateTripModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

//Car
  //get car data
  static Future<CarsModel?> getCarsData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse("$baseUrl/GetCarAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      CarsModel? data = carsModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  // get dropdown car type
  static getCarTypeDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetCarTypeAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      CarTypeModel data = carTypeModelFromJson(response.body);
      return data;
    } else {
      return null;
    }
  }

  //createCar
  static Future createCar(CreateCarsModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewCar"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseCarModel data = responseCarModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  //update car
  static Future updateCar(UpdateCarModel? updateModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.put(
      Uri.parse("$baseUrl/UpdateCar"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(updateModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseCarModel data = responseCarModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

//Hotel
  // get dropdownHoteltype
  static getHotelTypeDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetHotelTypeAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      HotelTypeModel data = hotelTypeModelFromJson(response.body);
      return data;
    } else {
      return null;
    }
  }

  //get hotel data
  static Future<HotelDataModel?> getHotelsData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse("$baseUrl/GetHotelAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      HotelDataModel? data = hotelDataModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  //createhotel
  static Future createHotel(CreateHotelModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewHotel"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseHotelModel data = responseHotelModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  //updatehotel
  static Future updateHotel(UpdateHotelModel? updateModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.put(
      Uri.parse("$baseUrl/EditHotel"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(updateModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseHotelModel data = responseHotelModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

//change car
  static Future changeCar(ChangeCarModel? updateModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.put(
      Uri.parse("$baseUrl/TripChangeCar"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(updateModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseCreateTripModel data =
          responseCreateTripModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

// move triper
  static Future moveTriper(MoveTriperModel? updateModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.put(
      Uri.parse("$baseUrl/MoveTriper"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(updateModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseTriperModel data = responseTriperModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  // Car check
  static Future<bool> checkCar(
      String carId, String startDate, String endDate) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse(
          "$baseUrl/CheckCar?carId=$carId&startDate=$startDate&endDate=$endDate"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      CheckCarModel? data = checkCarModelFromJson(response.body);
      if (data.status == true) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
