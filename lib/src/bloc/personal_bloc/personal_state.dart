part of 'personal_bloc.dart';

class PersonalState extends Equatable {
  final int pageNumber;
  final PersonData? personData;
  PersonalState({
    this.pageNumber = 1,
    this.personData,
  });

  PersonalState copyWith({
    int? pageNumber,
    PersonData? personData,
  }) {
    return PersonalState(
      pageNumber: pageNumber ?? this.pageNumber,
      personData: personData ?? this.personData,
    );
  }

  @override
  List<Object?> get props => [pageNumber, personData];
}
