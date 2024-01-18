part of 'organization_bloc.dart';

abstract class OrganizationEvent extends Equatable {
  const OrganizationEvent();

  @override
  List<Object> get props => [];
}

class FetchDataTableOrgEvent extends OrganizationEvent {}

class SearchEvent extends OrganizationEvent {}

class DissSearchEvent extends OrganizationEvent {}
