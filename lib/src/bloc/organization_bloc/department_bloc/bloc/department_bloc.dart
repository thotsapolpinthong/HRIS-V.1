import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hris_app_prototype/src/model/organization/department/get_departmen_model.dart';
import 'package:hris_app_prototype/src/services/api_org_service.dart';

part 'department_event.dart';
part 'department_state.dart';

class DepartmentBloc extends Bloc<DepartmentEvent, DepartmentState> {
  DepartmentBloc() : super(const DepartmentState()) {
    on<DepartmentEvent>((event, emit) {});

    on<FetchDataEvent>((event, emit) async {
      emit(state.copyWith(isDataLoading: true));
      emit(state.copyWith(
          departmentModel: await ApiOrgService.fetchAllDepartment(),
          isDataLoading: false,
          onSearchData: false));
    });

    on<SearchEvent>((event, emit) {
      emit(state.copyWith(onSearchData: true));
    });
    on<DissSearchEvent>((event, emit) {
      emit(state.copyWith(onSearchData: false));
    });
  }
}
