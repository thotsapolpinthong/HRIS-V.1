import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';
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
  }
}
