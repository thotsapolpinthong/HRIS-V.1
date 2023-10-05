part of 'personal_bloc.dart';

abstract class PersonalEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NextPage extends PersonalEvent {}

class BackPage extends PersonalEvent {}

class FetchDataList extends PersonalEvent {}
