import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(const AddressState()) {
    on<AddressEvent>((event, emit) {});

    on<AddressEventIDcardCheckbox>((event, emit) {
      // emit(state.copyWith(isCheckedIdCard: state.isCheckedIdCard = !isCheckedIdCard));
    });
  }
}
