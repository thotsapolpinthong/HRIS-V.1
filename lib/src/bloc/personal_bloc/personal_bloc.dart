import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hris_app_prototype/src/model/person/allperson_model.dart';
import 'package:hris_app_prototype/src/services/api_web_service.dart';

part 'personal_event.dart';
part 'personal_state.dart';

class PersonalBloc extends Bloc<PersonalEvent, PersonalState> {
  PersonalBloc() : super(PersonalState()) {
    //
    on<NextPage>((event, emit) async {
      emit(state.copyWith(pageNumber: state.pageNumber + 1));
      PersonData? _personData = await ApiService.fetchAllPersonalData();
      emit(state.copyWith(personData: _personData));
    });

    on<BackPage>((event, emit) async {
      emit(state.copyWith(pageNumber: state.pageNumber - 1));
      PersonData? _personData = await ApiService.fetchAllPersonalData();
      emit(state.copyWith(personData: _personData));
    });
    on<FetchDataList>((event, emit) async {
      PersonData? _personData = await ApiService.fetchAllPersonalData();
      emit(state.copyWith(personData: _personData));
    });
  }
}
