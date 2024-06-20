import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/get_holiday_data_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/lunch_break_half/get_lbh_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/shift/get_shift_all_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/workdate_spacial/wd_sp_model.dart';
import 'package:hris_app_prototype/src/services/api_time_attendance_service.dart';
part 'timeattendance_event.dart';
part 'timeattendance_state.dart';

class TimeattendanceBloc
    extends Bloc<TimeattendanceEvent, TimeattendanceState> {
  TimeattendanceBloc() : super(const TimeattendanceState()) {
    on<FetchDataTimeAttendanceEvent>((event, emit) async {
      emit(state.copyWith(isDataLoading: true));
      emit(state.copyWith(
          holidayData: await ApiTimeAtendanceService.fetchDataTableEmployee(),
          isDataLoading: false));
    });

    on<FetchDataShiftEvent>((event, emit) async {
      emit(state.copyWith(isDataLoading: true));
      emit(state.copyWith(
          shiftData: await ApiTimeAtendanceService.fetchDataTableShift(),
          isDataLoading: false));
    });

    on<SearchEvent>((event, emit) => emit(state.copyWith(onSearchData: true)));
    on<DissSearchEvent>(
        (event, emit) => emit(state.copyWith(onSearchData: false)));
    on<CloseEvent>((event, emit) => emit(const TimeattendanceState()));

    on<OnSelectedTableEvent>(
      (event, emit) {
        emit(state.copyWith(isDataLoading: true));
        emit(state.copyWith(
            selectedTemp: event.selectedemployeeData, isDataLoading: false));
      },
    );
    on<DissSelectedEvent>((event, emit) {
      emit(state.copyWith(selectedemployeeData: []));
    });

    on<SubmitSelectedEvent>((event, emit) {
      emit(state.copyWith(selectedemployeeData: state.selectedTemp));
    });

    on<FetchWorkdateSpacialEvent>(
      (event, emit) async {
        emit(state.copyWith(isDataLoading: true));
        emit(state.copyWith(
            workSpData: await ApiTimeAtendanceService.getDataWorkSp(
                event.startDate, event.endDate),
            isDataLoading: false));
      },
    );

    on<FetchLunchBreakHalfEvent>(
      (event, emit) async {
        emit(state.copyWith(isDataLoading: true));
        emit(state.copyWith(
            lunchBreakData: await ApiTimeAtendanceService.getDataLunchBreakHalf(
                event.startDate, event.endDate),
            isDataLoading: false));
      },
    );
    // on<OnSelectedAddEvent>((event, emit) {
    //   // สร้างรายการใหม่ที่เป็นสำเนาของ selectedemployeeData
    //   List<EmployeeDatum> updatedList = [];

    //   // เพิ่ม employeeData ในรายการที่สร้าง
    //   updatedList.add(event.employeeData);

    //   emit(state.copyWith(selectedemployeeData: updatedList));
    // });
  }
}
