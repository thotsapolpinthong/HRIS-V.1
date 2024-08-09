// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payroll_bloc.dart';

@immutable
class PayrollState extends Equatable {
  //to payroll
  final TimeRecordModel? timeRecordData;
  final bool isToPayrollLoading;
  final bool enabled;

  //tax deduction
  final List<int>? taxDeductionList;

  const PayrollState({
    this.timeRecordData,
    this.isToPayrollLoading = false,
    this.enabled = false,
    this.taxDeductionList,
  });

  PayrollState copyWith({
    TimeRecordModel? timeRecordData,
    bool? isToPayrollLoading,
    List<int>? taxDeductionList,
    bool? enabled,
  }) {
    return PayrollState(
      timeRecordData: timeRecordData ?? this.timeRecordData,
      isToPayrollLoading: isToPayrollLoading ?? this.isToPayrollLoading,
      taxDeductionList: taxDeductionList ?? this.taxDeductionList,
      enabled: enabled ?? this.enabled,
    );
  }

  @override
  List<Object?> get props =>
      [timeRecordData, isToPayrollLoading, taxDeductionList, enabled];
}
