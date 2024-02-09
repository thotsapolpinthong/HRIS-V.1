// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'employee_bloc.dart';

abstract class EmployeeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDataTableEmployeeEvent extends EmployeeEvent {}

class SearchEmpEvent extends EmployeeEvent {}

class DissSearchEmpEvent extends EmployeeEvent {}

class FetchDataLeaveEmployeeEvent extends EmployeeEvent {
  final String employeeId;
  FetchDataLeaveEmployeeEvent({
    required this.employeeId,
  });
}
