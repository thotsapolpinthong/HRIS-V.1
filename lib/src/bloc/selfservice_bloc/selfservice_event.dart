part of 'selfservice_bloc.dart';

@immutable
abstract class SelfserviceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDataManualWorkDateEvent extends SelfserviceEvent {
  final String employeeId;

  FetchDataManualWorkDateEvent({required this.employeeId});
}
