part of 'position_org_bloc.dart';

class PositionOrgState extends Equatable {
  final GetPositionOrgByOrgIdModel? positionOrganizationDataModel;
  final bool isDataLoading;
  final bool onSearchData;
  const PositionOrgState({
    this.positionOrganizationDataModel,
    this.isDataLoading = true,
    this.onSearchData = false,
  });

  PositionOrgState copyWith({
    GetPositionOrgByOrgIdModel? positionOrganizationDataModel,
    bool? isDataLoading,
    bool? onSearchData,
  }) {
    return PositionOrgState(
      positionOrganizationDataModel:
          positionOrganizationDataModel ?? this.positionOrganizationDataModel,
      isDataLoading: isDataLoading ?? this.isDataLoading,
      onSearchData: onSearchData ?? this.onSearchData,
    );
  }

  @override
  List<Object?> get props => [
        positionOrganizationDataModel,
        isDataLoading,
        onSearchData,
      ];
}
