part of 'positions_bloc.dart';

abstract class PositionsEvent extends Equatable {
  const PositionsEvent();

  @override
  List<Object> get props => [];
}

class FetchDataEvent extends PositionsEvent {}

class SearchEvent extends PositionsEvent {}

class DissSearchEvent extends PositionsEvent {}

class CreatedPositionEvent extends PositionsEvent {
  final CreatedPositionModel? createdPosition;

  const CreatedPositionEvent({required this.createdPosition});
}
