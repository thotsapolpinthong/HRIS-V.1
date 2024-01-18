part of 'employee_bloc.dart';

class EmployeeState extends Equatable {
  final GetEmployeeAllDataModel? employeeAllDataModel;

  final bool isDataLoading;
  final bool onSearchData;
  const EmployeeState({
    this.employeeAllDataModel,
    this.isDataLoading = true,
    this.onSearchData = false,
  });

  EmployeeState copyWith({
    GetEmployeeAllDataModel? employeeAllDataModel,
    bool? isDataLoading,
    bool? onSearchData,
  }) {
    return EmployeeState(
      employeeAllDataModel: employeeAllDataModel ?? this.employeeAllDataModel,
      isDataLoading: isDataLoading ?? this.isDataLoading,
      onSearchData: onSearchData ?? this.onSearchData,
    );
  }

  @override
  List<Object?> get props => [
        employeeAllDataModel,
        isDataLoading,
        onSearchData,
      ];
}
