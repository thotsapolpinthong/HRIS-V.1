import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';
import 'package:hris_app_prototype/src/model/trip/cars/cars_model.dart';
import 'package:hris_app_prototype/src/model/trip/hotels/hotel_data_all_model.dart';
import 'package:hris_app_prototype/src/model/trip/trip_data_all_model.dart';
import 'package:hris_app_prototype/src/services/api_trip_service.dart';

part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  TripBloc() : super(const TripState()) {
    on<TripEvent>((event, emit) {
      // TODO: implement event handler
    });
// create trip
    on<SelectEmployeeEvent>((event, emit) {
      emit(state.copyWith(employeeData: event.employeeData));
    });

    on<ClearSelectEmployeeEvent>((event, emit) {
      emit(state.copyWith(employeeData: null));
    });

//trip
    on<GetAllTripDataEvents>(((event, emit) async {
      emit(state.copyWith(isAllTripDataLoading: true));
      emit(state.copyWith(
          tripAllDataModel: await ApiTripService.getAllTripData(
              event.startDate, event.endDate),
          isAllTripDataLoading: false));
    }));

    on<SearchTripEvent>((event, emit) {
      emit(state.copyWith(onSearchData: true));
    });
    on<DissSearchTripEvent>((event, emit) {
      emit(state.copyWith(onSearchData: false));
    });
    //---end trip

    //car
    on<GetAllCarDataEvents>(((event, emit) async {
      emit(state.copyWith(isCarDataLoading: true));
      emit(state.copyWith(
          carsDataModel: await ApiTripService.getCarsData(),
          isCarDataLoading: false));
    }));
    on<SearchCarEvent>((event, emit) {
      emit(state.copyWith(onSearchCarData: true));
    });
    on<DissSearchCarEvent>((event, emit) {
      emit(state.copyWith(onSearchCarData: false));
    });
    //---end car

    //hotel
    on<GetAllHotelDataEvents>(((event, emit) async {
      emit(state.copyWith(isHotelDataLoading: true));
      emit(state.copyWith(
          hotelDataModel: await ApiTripService.getHotelsData(),
          isHotelDataLoading: false));
    }));
    on<SearchHotelEvent>((event, emit) {
      emit(state.copyWith(onSearchHotelData: true));
    });
    on<DissSearchHotelEvent>((event, emit) {
      emit(state.copyWith(onSearchHotelData: false));
    });
    //---end car
  }
}
