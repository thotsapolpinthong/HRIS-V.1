import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hris_app_prototype/src/model/payroll/to_payroll/time_record_model.dart';
import 'package:hris_app_prototype/src/services/api_payroll_service.dart';
import 'package:meta/meta.dart';

part 'payroll_event.dart';
part 'payroll_state.dart';

class PayrollBloc extends Bloc<PayrollEvent, PayrollState> {
  PayrollBloc() : super(PayrollState()) {
    on<PayrollEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FetchTimeRecordDataEvent>((event, emit) async {
      emit(state.copyWith(isToPayrollLoading: true));
      emit(state.copyWith(
          timeRecordData: await ApiPayrollService.getTimeRecord(
            event.startDate,
            event.endDate,
          ),
          isToPayrollLoading: false));
    });
  }
}
