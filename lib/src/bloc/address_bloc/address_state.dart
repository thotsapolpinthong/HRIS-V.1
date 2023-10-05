part of 'address_bloc.dart';

class AddressState extends Equatable {
  final bool isCheckedIdCard;
  final bool isCheckedPresent;
  const AddressState(
      {this.isCheckedIdCard = false, this.isCheckedPresent = false});

  AddressState copyWith({
    bool? isCheckedIdCard,
    bool? isCheckedPresent,
  }) {
    return AddressState(
        isCheckedIdCard: isCheckedIdCard ?? this.isCheckedIdCard,
        isCheckedPresent: isCheckedPresent ?? this.isCheckedPresent);
  }

  @override
  List<Object> get props => [isCheckedIdCard, isCheckedPresent];
}
