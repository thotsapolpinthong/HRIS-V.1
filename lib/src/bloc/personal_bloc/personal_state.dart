part of 'personal_bloc.dart';

class PersonalState extends Equatable {
  final int pageNumber;
  final List<PersonDatum>? personData;
  final bool isCreatedProfile;
  final bool isCreatedAddress;
  final bool isCreatedIdCard;
  final bool isCreatedPassport;
  final bool isCreatedEducation;
  final bool isCreatedFamily;
  final bool isCreatedContact;
  final bool isDataloading;
  final bool isExpandedAddressId;
  final bool isExpandedAddressPresent;
  final bool isValidateProfile;
  final bool onContinue;

  final bool onSearchData;

  final PersonCreateModel? personcreatedmodel;

  final Createaddressmodel? createaddressmodelPermanent;
  final Createaddressmodel? createaddressmodelId;
  final Createaddressmodel? createaddressmodelPresent;

  final AddNewIdcardModel? newIdcardModel;
  final CreatePassportModel? passportModel;

  final CreateeducationModel? creatededucationModel;

  final CreateFamilyModel? createFamilyModel;

  final CreateContactModel? createContactModel;

  final bool profileValidateState;
  final bool addressValidateState;
  final bool cardValidateState;
  final bool educationValidateState;
  final bool familyValidateState;
  final bool contactValidateState;
  const PersonalState({
    this.pageNumber = 1,
    this.personData,
    this.isCreatedProfile = false,
    this.isCreatedAddress = false,
    this.isCreatedIdCard = false,
    this.isCreatedPassport = false,
    this.isCreatedEducation = false,
    this.isCreatedFamily = false,
    this.isCreatedContact = false,
    this.personcreatedmodel,
    this.createaddressmodelId,
    this.createaddressmodelPermanent,
    this.createaddressmodelPresent,
    this.isExpandedAddressId = true,
    this.isExpandedAddressPresent = true,
    this.newIdcardModel,
    this.passportModel,
    this.creatededucationModel,
    this.createFamilyModel,
    this.createContactModel,
    this.isValidateProfile = false,
    this.isDataloading = true,
    this.onContinue = false,
    this.onSearchData = false,
    this.profileValidateState = false,
    this.addressValidateState = false,
    this.cardValidateState = false,
    this.educationValidateState = false,
    this.familyValidateState = false,
    this.contactValidateState = false,
  });

  PersonalState copyWith({
    int? pageNumber,
    List<PersonDatum>? personData,
    bool? isCreatedProfile,
    bool? isCreatedAddress,
    bool? isCreatedIdCard,
    bool? isCreatedPassport,
    bool? isCreatedEducation,
    bool? isCreatedFamily,
    bool? isCreatedContact,
    PersonCreateModel? personcreatedmodel,
    bool? isValidateProfile,
    bool? onContinue,
    Createaddressmodel? createaddressmodelPermanent,
    Createaddressmodel? createaddressmodelId,
    Createaddressmodel? createaddressmodelPresent,
    bool? isExpandedAddressId,
    bool? isExpandedAddressPresent,
    AddNewIdcardModel? newIdcardModel,
    CreatePassportModel? passportModel,
    CreateeducationModel? creatededucationModel,
    CreateFamilyModel? createFamilyModel,
    CreateContactModel? createContactModel,
    bool? onSearchData,
    bool? isDataloading,
    bool? profileValidateState,
    bool? addressValidateState,
    bool? cardValidateState,
    bool? educationValidateState,
    bool? familyValidateState,
    bool? contactValidateState,
  }) {
    return PersonalState(
      pageNumber: pageNumber ?? this.pageNumber,
      personData: personData ?? this.personData,
      onSearchData: onSearchData ?? this.onSearchData,
      isDataloading: isDataloading ?? this.isDataloading,
      onContinue: onContinue ?? this.onContinue,
      // person
      personcreatedmodel: personcreatedmodel ?? this.personcreatedmodel,
      isValidateProfile: isValidateProfile ?? this.isValidateProfile,
      // create address
      createaddressmodelPermanent:
          createaddressmodelPermanent ?? this.createaddressmodelPermanent,
      createaddressmodelId: createaddressmodelId ?? this.createaddressmodelId,
      createaddressmodelPresent:
          createaddressmodelPresent ?? this.createaddressmodelPresent,
      isExpandedAddressId: isExpandedAddressId ?? this.isExpandedAddressId,
      isExpandedAddressPresent:
          isExpandedAddressPresent ?? this.isExpandedAddressPresent,
      //card
      newIdcardModel: newIdcardModel ?? this.newIdcardModel,
      passportModel: passportModel ?? this.passportModel,
      //education
      creatededucationModel:
          creatededucationModel ?? this.creatededucationModel,

      //family
      createFamilyModel: createFamilyModel ?? this.createFamilyModel,

      //contact
      createContactModel: createContactModel ?? this.createContactModel,
      //status
      isCreatedProfile: isCreatedProfile ?? this.isCreatedProfile,
      isCreatedAddress: isCreatedAddress ?? this.isCreatedAddress,
      isCreatedIdCard: isCreatedIdCard ?? this.isCreatedIdCard,
      isCreatedPassport: isCreatedPassport ?? this.isCreatedPassport,
      isCreatedEducation: isCreatedEducation ?? this.isCreatedEducation,
      isCreatedFamily: isCreatedFamily ?? this.isCreatedFamily,
      isCreatedContact: isCreatedContact ?? this.isCreatedContact,
      profileValidateState: profileValidateState ?? this.profileValidateState,
      addressValidateState: addressValidateState ?? this.addressValidateState,
      cardValidateState: cardValidateState ?? this.cardValidateState,
      educationValidateState:
          educationValidateState ?? this.educationValidateState,
      familyValidateState: familyValidateState ?? this.familyValidateState,
      contactValidateState: contactValidateState ?? this.contactValidateState,
    );
  }

  @override
  List<Object?> get props => [
        pageNumber,
        personData,
        isCreatedProfile,
        isCreatedAddress,
        isCreatedIdCard,
        isCreatedPassport,
        isCreatedEducation,
        isCreatedFamily,
        isCreatedContact,
        personcreatedmodel,
        isValidateProfile,
        createaddressmodelPermanent,
        createaddressmodelId,
        createaddressmodelPresent,
        isExpandedAddressId,
        isExpandedAddressPresent,
        newIdcardModel,
        passportModel,
        creatededucationModel,
        createFamilyModel,
        createContactModel,
        onSearchData,
        isDataloading,
        onContinue,
        profileValidateState,
        addressValidateState,
        cardValidateState,
        educationValidateState,
        familyValidateState,
        contactValidateState,
      ];
}
