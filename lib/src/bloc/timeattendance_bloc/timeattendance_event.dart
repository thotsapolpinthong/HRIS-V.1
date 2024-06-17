// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'timeattendance_bloc.dart';

abstract class TimeattendanceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDataTimeAttendanceEvent extends TimeattendanceEvent {}

class FetchDataShiftEvent extends TimeattendanceEvent {}

class CloseEvent extends TimeattendanceEvent {}

class SearchEvent extends TimeattendanceEvent {}

class DissSearchEvent extends TimeattendanceEvent {}

class OnSelectedTableEvent extends TimeattendanceEvent {
  final List<EmployeeDatum>? selectedemployeeData;

  OnSelectedTableEvent({required this.selectedemployeeData});
}

class OnSelectedAddEvent extends TimeattendanceEvent {
  final EmployeeDatum employeeData;

  OnSelectedAddEvent({required this.employeeData});
}

class SubmitSelectedEvent extends TimeattendanceEvent {}

class DissSelectedEvent extends TimeattendanceEvent {}

class FetchWorkdateSpacialEvent extends TimeattendanceEvent {
  final String startDate;
  final String endDate;
  FetchWorkdateSpacialEvent({
    required this.startDate,
    required this.endDate,
  });
}
