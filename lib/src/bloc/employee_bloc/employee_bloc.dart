import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model/leave_amount_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model/leave_data_employee_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model/leave_quota_employee_model.dart';
import 'package:hris_app_prototype/src/model/self_service/ot/ot_request_model.dart';
import 'package:hris_app_prototype/src/services/api_employee_self_service.dart';
import 'package:hris_app_prototype/src/services/api_employee_service.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(const EmployeeState()) {
    on<EmployeeEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FetchDataTableEmployeeEvent>((event, emit) async {
      emit(state.copyWith(isDataLoading: true));
      emit(state.copyWith(
          employeeAllDataModel:
              await ApiEmployeeService.fetchDataTableEmployee("1"),
          isDataLoading: false));
    });

    on<SearchEmpEvent>(
        (event, emit) => emit(state.copyWith(onSearchData: true)));
    on<DissSearchEmpEvent>(
        (event, emit) => emit(state.copyWith(onSearchData: false)));

    on<FetchDataLeaveEmployeeEvent>((event, emit) async {
      emit(state.copyWith(isleaveLoading: true));
      emit(state.copyWith(
          leaveDataEmployee:
              await ApiEmployeeSelfService.getLeaveRequestByEmployeeId(
                  event.employeeId),
          quotaData:
              await ApiEmployeeService.getLeaveQuotaById(event.employeeId),
          leaveAmount: await ApiEmployeeSelfService.getLeaveAmountByEmployeeId(
              event.employeeId),
          isleaveLoading: false));
    });

    on<FetchDataOtEmployeeEvent>((event, emit) async {
      emit(state.copyWith(isOtLoading: true));
      emit(state.copyWith(
          otRequestData: await ApiEmployeeSelfService.getOtRequestByEmployeeId(
              event.employeeId),
          isOtLoading: false));
    });

    on<ClearStateOtEvent>(
        (event, emit) => emit(state.copyWith(otRequestData: null)));
    on<ClearStateLeaveEvent>(
        (event, emit) => emit(state.copyWith(leaveDataEmployee: null)));
  }
}
