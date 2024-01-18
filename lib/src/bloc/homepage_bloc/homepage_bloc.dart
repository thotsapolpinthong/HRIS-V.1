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
    on<TimePageEvent>((event, emit) => emit(state.copyWith(pageNumber: 6)));
    on<CalendarPageEvent>(
        (event, emit) => emit(state.copyWith(pageNumber: 61)));
    on<ShiftPageEvent>((event, emit) => emit(state.copyWith(pageNumber: 62)));
    on<ReportPageEvent>((event, emit) => emit(state.copyWith(pageNumber: 7)));
    on<DashboardPageEvent>(
        (event, emit) => emit(state.copyWith(pageNumber: 8)));
  }
}
