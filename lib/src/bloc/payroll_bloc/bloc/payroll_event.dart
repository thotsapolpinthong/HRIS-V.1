// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payroll_bloc.dart';

@immutable
abstract class PayrollEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchTimeRecordDataEvent extends PayrollEvent {
  final String startDate;
  final String endDate;
  FetchTimeRecordDataEvent({
    required this.startDate,
    required this.endDate,
  });
}

class SelectTaxDeductionListEvent extends PayrollEvent {
  final List<int> taxDeductionList;
  SelectTaxDeductionListEvent({
    required this.taxDeductionList,
  });
}
