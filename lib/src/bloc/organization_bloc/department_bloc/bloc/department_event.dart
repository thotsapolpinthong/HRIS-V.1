part of 'department_bloc.dart';

abstract class DepartmentEvent extends Equatable {
  const DepartmentEvent();

  @override
  List<Object> get props => [];
}

class FetchDataEvent extends DepartmentEvent {}

class SearchEvent extends DepartmentEvent {}

class DissSearchEvent extends DepartmentEvent {}
