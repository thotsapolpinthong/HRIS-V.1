// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'trip_bloc.dart';

class TripState extends Equatable {
  final EmployeeDatum? employeeData;
  //trip
  final TripDataModel? tripAllDataModel;
  final bool isAllTripDataLoading;
  final bool onSearchData;
  //car
  final CarsModel? carsDataModel;
  final bool isCarDataLoading;
  final bool onSearchCarData;
  //hotel
  final HotelDataModel? hotelDataModel;
  final bool isHotelDataLoading;
  final bool onSearchHotelData;
  const TripState({
    this.employeeData,
    this.tripAllDataModel,
    this.isAllTripDataLoading = false,
    this.onSearchData = false,
    this.carsDataModel,
    this.isCarDataLoading = false,
    this.onSearchCarData = false,
    this.hotelDataModel,
    this.isHotelDataLoading = false,
    this.onSearchHotelData = false,
  });

  TripState copyWith({
    EmployeeDatum? employeeData,
    TripDataModel? tripAllDataModel,
    bool? isAllTripDataLoading,
    bool? onSearchData,
    CarsModel? carsDataModel,
    bool? isCarDataLoading,
    bool? onSearchCarData,
    HotelDataModel? hotelDataModel,
    bool? isHotelDataLoading,
    bool? onSearchHotelData,
  }) {
    return TripState(
      employeeData: employeeData,
      tripAllDataModel: tripAllDataModel ?? this.tripAllDataModel,
      isAllTripDataLoading: isAllTripDataLoading ?? this.isAllTripDataLoading,
      onSearchData: onSearchData ?? this.onSearchData,
      carsDataModel: carsDataModel ?? this.carsDataModel,
      isCarDataLoading: isCarDataLoading ?? this.isCarDataLoading,
      onSearchCarData: onSearchCarData ?? this.onSearchCarData,
      hotelDataModel: hotelDataModel ?? this.hotelDataModel,
      isHotelDataLoading: isHotelDataLoading ?? this.isHotelDataLoading,
      onSearchHotelData: onSearchHotelData ?? this.onSearchHotelData,
    );
  }

  @override
  List<Object?> get props => [
        employeeData,
        tripAllDataModel,
        isAllTripDataLoading,
        onSearchData,
        carsDataModel,
        isCarDataLoading,
        onSearchCarData,
        hotelDataModel,
        isHotelDataLoading,
        onSearchHotelData,
      ];
}
