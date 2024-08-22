import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hris_app_prototype/src/model/organization/position_org/get_position_org_by_org_id_model.dart';
import 'package:hris_app_prototype/src/services/api_org_service.dart';

part 'position_org_event.dart';
part 'position_org_state.dart';

class PositionOrgBloc extends Bloc<PositionOrgEvent, PositionOrgState> {
  PositionOrgBloc() : super(const PositionOrgState()) {
    on<PositionOrgEvent>((event, emit) {});
    on<FetchDataPositionOrgEvent>((event, emit) async {
      emit(state.copyWith(isDataLoading: true));
      emit(state.copyWith(
          positionOrganizationDataModel:
              await ApiOrgService.fetchPositionOrgByOrgId(event.organizationId),
          isDataLoading: false));
    });
    on<SearchEvent>((event, emit) => emit(state.copyWith(onSearchData: true)));
    on<DissSearchEvent>(
        (event, emit) => emit(state.copyWith(onSearchData: false)));
    on<CloseEvent>((event, emit) {
      // emit(state.copyWith(
      //     isDataLoading: true, positionOrganizationDataModel: null));
      emit(const PositionOrgState());
    });
  }
}
