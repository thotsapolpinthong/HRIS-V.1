// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'personal_bloc.dart';

abstract class PersonalEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDataList extends PersonalEvent {}

class FetchDataNotInEmployeeList extends PersonalEvent {}

class CreatedPersonalEvent extends PersonalEvent {}

class StateClearEvent extends PersonalEvent {}

class SearchEvent extends PersonalEvent {}

class DissSearchEvent extends PersonalEvent {}

class ContinueEvent extends PersonalEvent {}

class DissContinueEvent extends PersonalEvent {}

class ProfileValidateEvent extends PersonalEvent {}

class AddressValidateEvent extends PersonalEvent {}

class CardValidateEvent extends PersonalEvent {}

class EducationValidateEvent extends PersonalEvent {}

class FamilyValidateEvent extends PersonalEvent {}

class ContactValidateEvent extends PersonalEvent {}

// Profile Event
class CreatedprofileEvent extends PersonalEvent {
  final PersonCreateModel? personcreatedmodel;

  CreatedprofileEvent({required this.personcreatedmodel});
}

class IsValidateProfileEvent extends PersonalEvent {}

class IsNotValidateProfileEvent extends PersonalEvent {}

//address event
class CreatedAddressPermanentEvent extends PersonalEvent {
  final Createaddressmodel? createaddressmodelPermanent;
  CreatedAddressPermanentEvent({required this.createaddressmodelPermanent});
}

class CreatedaddressmodelIdEvent extends PersonalEvent {
  final Createaddressmodel? createaddressmodelId;
  CreatedaddressmodelIdEvent({required this.createaddressmodelId});
}

class CreatedaddressmodelPresentEvent extends PersonalEvent {
  final Createaddressmodel? createaddressmodelPresent;
  CreatedaddressmodelPresentEvent({required this.createaddressmodelPresent});
}

class IsExpandedIdEvent extends PersonalEvent {
  final bool isexpanded;

  IsExpandedIdEvent({this.isexpanded = false});
}

class IsExpandedPresentEvent extends PersonalEvent {
  final bool isexpanded;

  IsExpandedPresentEvent({this.isexpanded = false});
}

// Card Information Event
class CreatedIdCardEvent extends PersonalEvent {
  final AddNewIdcardModel? newIdcardModel;

  CreatedIdCardEvent({required this.newIdcardModel});
}

class CreatedPassportEvent extends PersonalEvent {
  final CreatePassportModel? passportModel;

  CreatedPassportEvent({required this.passportModel});
}

//Education Information Event
class CreatedEducationEvent extends PersonalEvent {
  final CreateeducationModel creatededucationModel;

  CreatedEducationEvent({required this.creatededucationModel});
}

//Family Information Event
class CreatedFamilyModelEvent extends PersonalEvent {
  final CreateFamilyModel createFamilyModel;

  CreatedFamilyModelEvent({required this.createFamilyModel});
}

//Contact Information Event
class CreatedContactModelEvent extends PersonalEvent {
  final CreateContactModel createContactModel;

  CreatedContactModelEvent({required this.createContactModel});
}
