import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc() : super(const HomepageState()) {
    on<HomepageEvent>((event, emit) {});

    on<ExpandedMenuEvent>(
        (event, emit) => emit(state.copyWith(expandMenu: !state.expandMenu)));
    on<PersonPageEvent>((event, emit) => emit(state.copyWith(pageNumber: 0)));
    on<OrgPageEvent>((event, emit) => emit(state.copyWith(pageNumber: 1)));
    on<EmployeePageEvent>((event, emit) => emit(state.copyWith(pageNumber: 2)));
    on<EssPageEvent>((event, emit) => emit(state.copyWith(pageNumber: 3)));
    on<WelfarePageEvent>((event, emit) => emit(state.copyWith(pageNumber: 4)));
    on<PayrollPageEvent>((event, emit) => emit(state.copyWith(pageNumber: 5)));
    //time attendance
    on<CalendarPageEvent>(
        (event, emit) => emit(state.copyWith(pageNumber: 6.1)));
    on<ShiftPageEvent>((event, emit) => emit(state.copyWith(pageNumber: 6.2)));
    on<WorkSpPageEvent>((event, emit) => emit(state.copyWith(pageNumber: 6.3)));
    on<HalfHlbPageEvent>(
        (event, emit) => emit(state.copyWith(pageNumber: 6.4)));
//
    on<DashboardPageEvent>(
        (event, emit) => emit(state.copyWith(pageNumber: 8)));
    on<TripPageEvent>((event, emit) => emit(state.copyWith(pageNumber: 9)));
    //payroll
    on<SubPayroll1PageEvent>(
        (event, emit) => emit(state.copyWith(pageNumber: 5.1)));
    on<SubPayrollPage2Event>(
        (event, emit) => emit(state.copyWith(pageNumber: 5.2)));
    on<SubPayrollPage3Event>(
        (event, emit) => emit(state.copyWith(pageNumber: 5.3)));
    on<SubPayrollPage4Event>(
        (event, emit) => emit(state.copyWith(pageNumber: 5.4)));
    on<SubPayrollPage5Event>(
        (event, emit) => emit(state.copyWith(pageNumber: 5.5)));
    //Report
    on<ReportPageEvent>((event, emit) => emit(state.copyWith(pageNumber: 7)));
    //Role
    on<RolePageEvent>((event, emit) => emit(state.copyWith(pageNumber: 10)));
  }
}
