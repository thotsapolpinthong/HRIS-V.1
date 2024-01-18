part of 'organization_bloc.dart';

class OrganizationState extends Equatable {
  final GetOrganizationAllModel? organizationDataTableModel;
  final bool isDataLoading;
  final bool onSearchData;
  const OrganizationState({
    this.isDataLoading = true,
    this.organizationDataTableModel,
    this.onSearchData = false,
  });

  OrganizationState copyWith({
    bool? isDataLoading,
    bool? onSearchData,
    GetOrganizationAllModel? organizationDataTableModel,
  }) {
    return OrganizationState(
      isDataLoading: isDataLoading ?? this.isDataLoading,
      organizationDataTableModel:
          organizationDataTableModel ?? this.organizationDataTableModel,
      onSearchData: onSearchData ?? this.onSearchData,
    );
  }

  @override
  List<Object?> get props => [
        isDataLoading,
        organizationDataTableModel,
        onSearchData,
      ];
}
