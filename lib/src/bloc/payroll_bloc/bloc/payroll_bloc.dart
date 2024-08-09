import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hris_app_prototype/src/model/payroll/tax_deduction/tax_deduction_all_model.dart';
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

    on<SelectTaxDeductionListEvent>((event, emit) {
      emit(state.copyWith(enabled: true));
      emit(state.copyWith(taxDeductionList: event.taxDeductionList));
      emit(state.copyWith(enabled: false));
    });
  }
}
