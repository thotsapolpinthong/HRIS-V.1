import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hris_app_prototype/src/model/self_service/workdate/request_model.dart';
import 'package:hris_app_prototype/src/services/api_employee_self_service.dart';
import 'package:meta/meta.dart';

part 'selfservice_event.dart';
part 'selfservice_state.dart';

class SelfServiceBloc extends Bloc<SelfserviceEvent, SelfServiceState> {
  SelfServiceBloc() : super(const SelfServiceState()) {
    on<SelfserviceEvent>((event, emit) {});

    on<FetchDataManualWorkDateEvent>((event, emit) async {
      emit(state.copyWith(isManualDataLoading: true));
      emit(state.copyWith(
          manualRequestData:
              await ApiEmployeeSelfService.getRequestManualWorkDateByEmployeeId(
            event.employeeId,
          ),
          isManualDataLoading: false));
    });
  }
}
