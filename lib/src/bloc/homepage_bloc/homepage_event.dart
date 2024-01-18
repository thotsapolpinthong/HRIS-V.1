part of 'homepage_bloc.dart';

abstract class HomepageEvent extends Equatable {
  const HomepageEvent();

  @override
  List<Object> get props => [];
}

class ExpandedMenuEvent extends HomepageEvent {}

class PersonPageEvent extends HomepageEvent {}

class OrgPageEvent extends HomepageEvent {}

class EmployeePageEvent extends HomepageEvent {}

class EssPageEvent extends HomepageEvent {}

class WelfarePageEvent extends HomepageEvent {}

class PayrollPageEvent extends HomepageEvent {}

class TimePageEvent extends HomepageEvent {}

class ReportPageEvent extends HomepageEvent {}

class DashboardPageEvent extends HomepageEvent {}

class CalendarPageEvent extends HomepageEvent {}

class ShiftPageEvent extends HomepageEvent {}
