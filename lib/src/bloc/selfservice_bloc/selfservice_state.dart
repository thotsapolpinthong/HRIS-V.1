part of 'selfservice_bloc.dart';

@immutable
class SelfServiceState extends Equatable {
  final ManualWorkDateRequestModel? manualRequestData;
  final bool isManualDataLoading;

  const SelfServiceState({
    this.manualRequestData,
    this.isManualDataLoading = true,
  });

  SelfServiceState copyWith({
    ManualWorkDateRequestModel? manualRequestData,
    bool? isManualDataLoading,
  }) {
    return SelfServiceState(
      manualRequestData: manualRequestData,
      isManualDataLoading: isManualDataLoading ?? this.isManualDataLoading,
    );
  }

  @override
  List<Object?> get props => [
        manualRequestData,
        isManualDataLoading,
      ];
}
