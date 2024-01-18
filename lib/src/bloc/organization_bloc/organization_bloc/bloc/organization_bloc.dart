import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hris_app_prototype/src/model/organization/organization/get_org_all_model.dart';
import 'package:hris_app_prototype/src/services/api_org_service.dart';

part 'organization_event.dart';
part 'organization_state.dart';

class OrganizationBloc extends Bloc<OrganizationEvent, OrganizationState> {
  OrganizationBloc() : super(const OrganizationState()) {
    on<OrganizationEvent>((event, emit) {});

    on<FetchDataTableOrgEvent>((event, emit) async {
      emit(state.copyWith(isDataLoading: true));
      emit(state.copyWith(
          organizationDataTableModel:
              await ApiOrgService.fetchDataTableOrganization(),
          isDataLoading: false));
    });

    on<SearchEvent>((event, emit) => emit(state.copyWith(onSearchData: true)));
    on<DissSearchEvent>(
        (event, emit) => emit(state.copyWith(onSearchData: false)));
  }
}
