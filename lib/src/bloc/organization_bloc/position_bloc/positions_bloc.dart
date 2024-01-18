import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hris_app_prototype/src/model/organization/position/created_position_model.dart';
import 'package:hris_app_prototype/src/model/organization/position/getpositionall_model.dart';
import 'package:hris_app_prototype/src/services/api_org_service.dart';

part 'positions_event.dart';
part 'positions_state.dart';

class PositionsBloc extends Bloc<PositionsEvent, PositionsState> {
  PositionsBloc() : super(const PositionsState()) {
    on<PositionsEvent>((event, emit) {});
    on<FetchDataEvent>((event, emit) async {
      emit(state.copyWith(isDataLoading: true));
      emit(state.copyWith(
          positionModel: await ApiOrgService.fetchAllPosition(),
          isDataLoading: false,
          onSearchData: false));
    });

    on<SearchEvent>((event, emit) {
      emit(state.copyWith(onSearchData: true));
    });
    on<DissSearchEvent>((event, emit) {
      emit(state.copyWith(onSearchData: false));
    });
    on<CreatedPositionEvent>((event, emit) async {
      emit(state.copyWith(isCreated: false));
      bool created =
          await ApiOrgService.createdPositions(event.createdPosition);
      if (created == true) {
        emit(state.copyWith(isCreated: true));
      } else {}
    });
  }
}
