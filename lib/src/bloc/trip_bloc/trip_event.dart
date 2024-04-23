// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'trip_bloc.dart';

abstract class TripEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SelectEmployeeEvent extends TripEvent {
  final EmployeeDatum employeeData;

  SelectEmployeeEvent({required this.employeeData});
}

class ClearSelectEmployeeEvent extends TripEvent {}

//trip
class GetAllTripDataEvents extends TripEvent {
  final String startDate;
  final String endDate;
  GetAllTripDataEvents({
    required this.startDate,
    required this.endDate,
  });
}

class SearchTripEvent extends TripEvent {}

class DissSearchTripEvent extends TripEvent {}

//car
class GetAllCarDataEvents extends TripEvent {}

class SearchCarEvent extends TripEvent {}

class DissSearchCarEvent extends TripEvent {}

//hotel
class GetAllHotelDataEvents extends TripEvent {}

class SearchHotelEvent extends TripEvent {}

class DissSearchHotelEvent extends TripEvent {}
