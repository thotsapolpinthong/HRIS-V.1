part of 'employee_bloc.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}

class FetchDataTableEmployeeEvent extends EmployeeEvent {}

class SearchEmpEvent extends EmployeeEvent {}

class DissSearchEmpEvent extends EmployeeEvent {}
