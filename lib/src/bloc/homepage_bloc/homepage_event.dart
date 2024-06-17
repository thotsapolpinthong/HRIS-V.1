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

//payroll
class PayrollPageEvent extends HomepageEvent {}

class SubPayroll1PageEvent extends HomepageEvent {}

class SubPayrollPage2Event extends HomepageEvent {}
//end payroll

class TripPageEvent extends HomepageEvent {}

class ReportPageEvent extends HomepageEvent {}

class DashboardPageEvent extends HomepageEvent {}

// time attendance
class CalendarPageEvent extends HomepageEvent {}

class ShiftPageEvent extends HomepageEvent {}

class WorkSpPageEvent extends HomepageEvent {}

class HalfHlbPageEvent extends HomepageEvent {}
