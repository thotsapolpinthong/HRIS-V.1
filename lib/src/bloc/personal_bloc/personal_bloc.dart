import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hris_app_prototype/src/model/address/addAddress/add_address_model.dart';
import 'package:hris_app_prototype/src/model/cardinfomation/idcard/add/create_idcard_model.dart';
import 'package:hris_app_prototype/src/model/cardinfomation/passport/add/createpassport_model.dart';
import 'package:hris_app_prototype/src/model/contact_person/add/create_contact_model.dart';
import 'package:hris_app_prototype/src/model/education/add/create_education_model.dart';
import 'package:hris_app_prototype/src/model/family_member/add/create_family_model.dart';
import 'package:hris_app_prototype/src/model/person/allperson_model.dart';
import 'package:hris_app_prototype/src/model/person/createperson_model.dart';
import 'package:hris_app_prototype/src/services/api_web_service.dart';

part 'personal_event.dart';
part 'personal_state.dart';

class PersonalBloc extends Bloc<PersonalEvent, PersonalState> {
  PersonalBloc() : super(const PersonalState()) {
    //

    on<FetchDataList>((event, emit) async {
      emit(state.copyWith(isDataloading: true));
      PersonData? _personData = await ApiService.fetchAllPersonalData();
      emit(state.copyWith(
          personData: _personData!.personData, isDataloading: false));
    });

// LastStep on stepper (onContinue)
    on<CreatedPersonalEvent>((event, emit) async {
      emit(state.copyWith(
          isCreatedProfile:
              await ApiService.addPersonalData(state.personcreatedmodel)));
      emit(state.copyWith(
          isCreatedAddress: await ApiService.addAddressByTypeAndId(
              state.createaddressmodelPermanent)));
      await ApiService.addAddressByTypeAndId(state.createaddressmodelId);
      await ApiService.addAddressByTypeAndId(state.createaddressmodelPresent);
      if (state.newIdcardModel != null) {
        emit(state.copyWith(
            isCreatedIdCard:
                await ApiService.addIdCardbyId(state.newIdcardModel)));
      } else {}
      if (state.passportModel != null) {
        emit(state.copyWith(
            isCreatedPassport:
                await ApiService.addPassportbyId(state.passportModel)));
      } else {}

      emit(state.copyWith(
          isCreatedEducation:
              await ApiService.addEducationbyId(state.creatededucationModel)));
      emit(state.copyWith(
          isCreatedFamily:
              await ApiService.createFamilyById(state.createFamilyModel)));
      emit(state.copyWith(
          isCreatedContact:
              await ApiService.createContactById(state.createContactModel)));
    });
// validate & continue
    on<IsValidateProfileEvent>(
        (event, emit) => emit(state.copyWith(isValidateProfile: true)));

    on<IsNotValidateProfileEvent>(
        (event, emit) => emit(state.copyWith(isValidateProfile: false)));

    on<ProfileValidateEvent>((event, emit) {
      if (state.isValidateProfile == true) {
        emit(state.copyWith(profileValidateState: true));
      } else {
        emit(state.copyWith(profileValidateState: false));
      }
    });
    on<AddressValidateEvent>((event, emit) {
      if (state.isValidateProfile == true) {
        emit(state.copyWith(addressValidateState: true));
      } else {
        emit(state.copyWith(addressValidateState: false));
      }
    });
    on<CardValidateEvent>((event, emit) {
      if (state.isValidateProfile == true) {
        emit(state.copyWith(cardValidateState: true));
      } else {
        emit(state.copyWith(cardValidateState: false));
      }
    });
    on<EducationValidateEvent>((event, emit) {
      if (state.isValidateProfile == true) {
        emit(state.copyWith(educationValidateState: true));
      } else {
        emit(state.copyWith(educationValidateState: false));
      }
    });
    on<FamilyValidateEvent>((event, emit) {
      if (state.isValidateProfile == true) {
        emit(state.copyWith(familyValidateState: true));
      } else {
        emit(state.copyWith(familyValidateState: false));
      }
    });
    on<ContactValidateEvent>((event, emit) {
      if (state.isValidateProfile == true) {
        emit(state.copyWith(contactValidateState: true));
      } else {
        emit(state.copyWith(contactValidateState: false));
      }
    });

    on<ContinueEvent>((event, emit) => emit(state.copyWith(onContinue: true)));
    on<DissContinueEvent>(
        (event, emit) => emit(state.copyWith(onContinue: false)));
//event personal prefile
    on<CreatedprofileEvent>((event, emit) {
      emit(state.copyWith(personcreatedmodel: event.personcreatedmodel));
      state.personcreatedmodel;
    });

//event address
    on<CreatedAddressPermanentEvent>((event, emit) {
      emit(state.copyWith(
          createaddressmodelPermanent: event.createaddressmodelPermanent));
      state.createaddressmodelPermanent;
    });

    on<CreatedaddressmodelIdEvent>((event, emit) {
      emit(state.copyWith(createaddressmodelId: event.createaddressmodelId));
      state.createaddressmodelId;
    });

    on<CreatedaddressmodelPresentEvent>((event, emit) {
      emit(state.copyWith(
          createaddressmodelPresent: event.createaddressmodelPresent));
      state.createaddressmodelPresent;
    });

    on<IsExpandedIdEvent>((event, emit) {
      if (event.isexpanded == true) {
        emit(state.copyWith(isExpandedAddressId: true));
      } else {
        emit(state.copyWith(isExpandedAddressId: false));
      }
    });

    on<IsExpandedPresentEvent>((event, emit) {
      if (event.isexpanded == true) {
        emit(state.copyWith(isExpandedAddressPresent: true));
      } else {
        emit(state.copyWith(isExpandedAddressPresent: false));
        state.createaddressmodelPermanent;
        state.createaddressmodelId;
        state.createaddressmodelPresent;
      }
    });
    //event Card Information
    on<CreatedIdCardEvent>((event, emit) {
      emit(state.copyWith(newIdcardModel: event.newIdcardModel));
    });
    on<CreatedPassportEvent>((event, emit) {
      emit(state.copyWith(passportModel: event.passportModel));
    });

    //Event Education Information
    on<CreatedEducationEvent>((event, emit) {
      emit(state.copyWith(creatededucationModel: event.creatededucationModel));
    });

    //Event Family
    on<CreatedFamilyModelEvent>((event, emit) {
      emit(state.copyWith(createFamilyModel: event.createFamilyModel));
    });

    //Event Contact Information
    on<CreatedContactModelEvent>((event, emit) {
      emit(state.copyWith(createContactModel: event.createContactModel));
    });

    on<StateClearEvent>((event, emit) {
      emit(state.copyWith(
        isValidateProfile: false,
        onSearchData: false,
        onContinue: false,
        profileValidateState: false,
        addressValidateState: false,
        cardValidateState: false,
        educationValidateState: false,
        familyValidateState: false,
        contactValidateState: false,
        isCreatedProfile: false,
        isCreatedAddress: false,
        isCreatedIdCard: false,
        isCreatedPassport: false,
        isCreatedEducation: false,
        isCreatedFamily: false,
        isCreatedContact: false,
        isExpandedAddressId: true,
        isExpandedAddressPresent: true,
      ));
    });

    on<SearchEvent>((event, emit) {
      emit(state.copyWith(onSearchData: true));
    });
    on<DissSearchEvent>((event, emit) {
      emit(state.copyWith(onSearchData: false));
    });
  }
}
