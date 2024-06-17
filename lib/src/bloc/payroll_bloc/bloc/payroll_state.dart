// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payroll_bloc.dart';

@immutable
class PayrollState extends Equatable {
  //to payroll
  final TimeRecordModel? timeRecordData;
  final bool isToPayrollLoading;
  const PayrollState({
    this.timeRecordData,
    this.isToPayrollLoading = false,
  });

  PayrollState copyWith({
    TimeRecordModel? timeRecordData,
    bool? isToPayrollLoading,
  }) {
    return PayrollState(
      timeRecordData: timeRecordData,
      isToPayrollLoading: isToPayrollLoading ?? this.isToPayrollLoading,
    );
  }

  @override
  List<Object?> get props => [timeRecordData, isToPayrollLoading];
}
