part of 'position_org_bloc.dart';

abstract class PositionOrgEvent extends Equatable {
  const PositionOrgEvent();

  @override
  List<Object> get props => [];
}

class FetchDataPositionOrgEvent extends PositionOrgEvent {
  final String organizationId;

  const FetchDataPositionOrgEvent({required this.organizationId});
}

class CloseEvent extends PositionOrgEvent {}

class SearchEvent extends PositionOrgEvent {}

class DissSearchEvent extends PositionOrgEvent {}
