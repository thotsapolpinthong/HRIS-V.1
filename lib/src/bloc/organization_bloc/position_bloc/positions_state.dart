// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'positions_bloc.dart';

class PositionsState extends Equatable {
  final GetPositionModel? positionModel;
  final bool isDataLoading;
  final bool onSearchData;
  final bool isCreated;
  const PositionsState({
    this.positionModel,
    this.isDataLoading = true,
    this.onSearchData = false,
    this.isCreated = false,
  });

  PositionsState copyWith({
    GetPositionModel? positionModel,
    bool? isDataLoading,
    bool? onSearchData,
    bool? isCreated,
  }) {
    return PositionsState(
      positionModel: positionModel ?? this.positionModel,
      isDataLoading: isDataLoading ?? this.isDataLoading,
      onSearchData: onSearchData ?? this.onSearchData,
      isCreated: isCreated ?? this.isCreated,
    );
  }

  @override
  List<Object?> get props => [
        positionModel,
        isDataLoading,
        onSearchData,
        isCreated,
      ];
}
