part of 'department_bloc.dart';

class DepartmentState extends Equatable {
  final GetAllDepartmentModel? departmentModel;
  final bool isDataLoading;
  final bool onSearchData;
  const DepartmentState({
    this.departmentModel,
    this.isDataLoading = false,
    this.onSearchData = false,
  });
  DepartmentState copyWith({
    GetAllDepartmentModel? departmentModel,
    bool? isDataLoading,
    bool? onSearchData,
  }) {
    return DepartmentState(
      departmentModel: departmentModel ?? this.departmentModel,
      isDataLoading: isDataLoading ?? this.isDataLoading,
      onSearchData: onSearchData ?? this.onSearchData,
    );
  }

  @override
  List<Object?> get props => [
        departmentModel,
        isDataLoading,
        onSearchData,
      ];
}
