// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'employee_bloc.dart';

class EmployeeState extends Equatable {
  final GetEmployeeAllDataModel? employeeAllDataModel;
  final bool isDataLoading;
  final bool onSearchData;
// leave menu Employee
  final LeaveRequestByEmployeeModel? leaveDataEmployee;
  final bool isleaveLoading;
  final LeaveRequestAmountModel? leaveAmount;
  final LeaveQuotaByEmployeeModel? quotaData;
// ot menu Employee
  final OtRequestModel? otRequestData;
  final bool isOtLoading;

  const EmployeeState({
    this.employeeAllDataModel,
    this.isDataLoading = true,
    this.onSearchData = false,
    this.leaveDataEmployee,
    this.isleaveLoading = true,
    this.leaveAmount,
    this.quotaData,
    this.otRequestData,
    this.isOtLoading = true,
  });

  EmployeeState copyWith({
    GetEmployeeAllDataModel? employeeAllDataModel,
    bool? isDataLoading,
    bool? onSearchData,
    LeaveRequestByEmployeeModel? leaveDataEmployee,
    bool? isleaveLoading,
    LeaveRequestAmountModel? leaveAmount,
    LeaveQuotaByEmployeeModel? quotaData,
    OtRequestModel? otRequestData,
    bool? isOtLoading,
  }) {
    return EmployeeState(
      employeeAllDataModel: employeeAllDataModel ?? this.employeeAllDataModel,
      isDataLoading: isDataLoading ?? this.isDataLoading,
      onSearchData: onSearchData ?? this.onSearchData,
      leaveDataEmployee: leaveDataEmployee,
      isleaveLoading: isleaveLoading ?? this.isleaveLoading,
      leaveAmount: leaveAmount ?? this.leaveAmount,
      quotaData: quotaData ?? this.quotaData,
      otRequestData: otRequestData,
      isOtLoading: isOtLoading ?? this.isOtLoading,
    );
  }

  @override
  List<Object?> get props => [
        employeeAllDataModel,
        isDataLoading,
        onSearchData,
        leaveDataEmployee,
        isleaveLoading,
        leaveAmount,
        quotaData,
        otRequestData,
        isOtLoading
      ];
}
