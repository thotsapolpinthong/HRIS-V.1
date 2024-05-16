import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_app_prototype/src/bloc/personal_bloc/personal_bloc.dart';
import 'package:hris_app_prototype/src/component/personal/address/add/1_add_address_layout.dart';
import 'package:hris_app_prototype/src/component/personal/cardinfo/idcard/add/1_add_idcard_layout.dart';
import 'package:hris_app_prototype/src/component/personal/contact_person/add/1_add_contact.dart';
import 'package:hris_app_prototype/src/component/personal/education/add/1_add_education_layout.dart';
import 'package:hris_app_prototype/src/component/personal/family/add/1_add_family_layout.dart';
import 'package:hris_app_prototype/src/component/personal/person/add/add_person_personal.dart';
import 'package:lottie/lottie.dart';

class MyWidget extends StatefulWidget {
  final String personId;
  const MyWidget({super.key, required this.personId});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int currentStep = 0;
  bool isCompleted = false;
  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text('Profile'),
          content: Addpersonal(personId: widget.personId),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text('Address'),
          content: AddAddressbyperson(personId: widget.personId),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text('Card Infomation'),
          content: AddCardInfoLayout(personId: widget.personId),
        ),
        Step(
          state: currentStep > 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 3,
          title: const Text('Education'),
          content: AddEducationLayout(personId: widget.personId),
        ),
        Step(
            state: currentStep > 4 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 4,
            title: const Text('Family'),
            content: AddFamilyLayout(personId: widget.personId)),
        Step(
            state: currentStep > 5 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 5,
            title: const Text('Contact'),
            content: AddContactLayout(personId: widget.personId)),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 35,
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.red[700]),
                onPressed: () {
                  Navigator.pop(context);
                  context.read<PersonalBloc>().add(StateClearEvent());
                  context.read<PersonalBloc>().add(FetchDataList());
                },
                child: const Text('X')),
          ),
          const SizedBox(
            width: 5,
          )
        ],
      ),
      backgroundColor: Colors.grey[50],
      body: isCompleted
          ? BlocBuilder<PersonalBloc, PersonalState>(
              builder: (context, state) {
                return Center(
                    child: Row(
                  children: [
                    Expanded(
                        child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      elevation: 4,
                      child: SizedBox(
                        height: 320,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Created Profile.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              state.isCreatedProfile == true
                                  ? Lottie.asset('assets/successful.json',
                                      width: 500,
                                      height: 260,
                                      frameRate: FrameRate(60))
                                  : Lottie.asset('assets/fail.json',
                                      width: 500,
                                      height: 250,
                                      frameRate: FrameRate(60)),
                              state.isCreatedProfile == true
                                  ? const Text('Successfully')
                                  : const Text('Unsuccessful')
                            ]),
                      ),
                    ).animate().fade()),
                    Expanded(
                        child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      elevation: 4,
                      child: SizedBox(
                        height: 320,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Created Address.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              state.isCreatedAddress == true
                                  ? Lottie.asset('assets/successful.json',
                                      width: 500,
                                      height: 260,
                                      frameRate: FrameRate(60))
                                  : Lottie.asset('assets/fail.json',
                                      width: 500,
                                      height: 250,
                                      frameRate: FrameRate(60)),
                              state.isCreatedAddress == true
                                  ? const Text('Successfully')
                                  : const Text('Unsuccessful')
                            ]),
                      ),
                    ).animate().fade(delay: 200.ms)),
                    Expanded(
                        child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      elevation: 4,
                      child: SizedBox(
                        height: 320,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Created ID Card.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              state.isCreatedIdCard == true
                                  ? Lottie.asset('assets/successful.json',
                                      width: 500,
                                      height: 260,
                                      frameRate: FrameRate(60))
                                  : Lottie.asset('assets/fail.json',
                                      width: 500,
                                      height: 250,
                                      frameRate: FrameRate(60)),
                              state.isCreatedIdCard == true
                                  ? const Text('Successfully')
                                  : const Text('Unsuccessful')
                            ]),
                      ),
                    ).animate().fade(delay: 400.ms)),
                    Expanded(
                        child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      elevation: 4,
                      child: SizedBox(
                        height: 320,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Created Passport.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              state.isCreatedPassport == true
                                  ? Lottie.asset('assets/successful.json',
                                      width: 500,
                                      height: 260,
                                      frameRate: FrameRate(60))
                                  : Lottie.asset('assets/fail.json',
                                      width: 500,
                                      height: 250,
                                      frameRate: FrameRate(60)),
                              state.isCreatedPassport == true
                                  ? const Text('Successfully')
                                  : const Text('Unsuccessful')
                            ]),
                      ),
                    ).animate().fade(delay: 600.ms)),
                    Expanded(
                        child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      elevation: 4,
                      child: SizedBox(
                        height: 320,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Created Education.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              state.isCreatedEducation == true
                                  ? Lottie.asset('assets/successful.json',
                                      width: 500,
                                      height: 260,
                                      frameRate: FrameRate(60))
                                  : Lottie.asset('assets/fail.json',
                                      width: 500,
                                      height: 250,
                                      frameRate: FrameRate(60)),
                              state.isCreatedEducation == true
                                  ? const Text('Successfully')
                                  : const Text('Unsuccessful')
                            ]),
                      ),
                    ).animate().fade(delay: 800.ms)),
                    Expanded(
                        child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      elevation: 4,
                      child: SizedBox(
                        height: 320,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Created Family.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              state.isCreatedFamily == true
                                  ? Lottie.asset('assets/successful.json',
                                      width: 500,
                                      height: 260,
                                      frameRate: FrameRate(60))
                                  : Lottie.asset('assets/fail.json',
                                      width: 500,
                                      height: 250,
                                      frameRate: FrameRate(60)),
                              state.isCreatedFamily == true
                                  ? const Text('Successfully')
                                  : const Text('Unsuccessful')
                            ]),
                      ),
                    ).animate().fade(delay: 1000.ms)),
                    Expanded(
                        child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      elevation: 4,
                      child: SizedBox(
                        height: 320,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Created Contact.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              state.isCreatedContact == true
                                  ? Lottie.asset('assets/successful.json',
                                      width: 500,
                                      height: 260,
                                      frameRate: FrameRate(60))
                                  : Lottie.asset('assets/fail.json',
                                      width: 500,
                                      height: 250,
                                      frameRate: FrameRate(60)),
                              state.isCreatedContact == true
                                  ? const Text('Successfully')
                                  : const Text('Unsuccessful')
                            ]),
                      ),
                    ).animate().fade(delay: 1200.ms)),
                  ],
                ));
              },
            )
          : Center(
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocBuilder<PersonalBloc, PersonalState>(
                    builder: (context, state) {
                      return Stepper(
                        elevation: 0,
                        type: StepperType.horizontal,
                        steps: getSteps(),
                        currentStep: currentStep,
                        // onStepTapped: (step) {
                        //   setState(() {
                        //     currentStep = step;
                        //   });
                        // },
                        onStepContinue: () {
                          final isLastStep =
                              currentStep == getSteps().length - 1;

                          if (isLastStep) {
                            setState(() => isCompleted = true);
                            context
                                .read<PersonalBloc>()
                                .add(CreatedPersonalEvent());
                            if (state.contactValidateState == true) {
                              context.read<PersonalBloc>().add(ContinueEvent());
                            } else {
                              context
                                  .read<PersonalBloc>()
                                  .add(DissContinueEvent());
                            }
                          }
                          if (currentStep == 0) {
                            setState(() => currentStep += 1);
                            if (state.addressValidateState == true) {
                              context.read<PersonalBloc>().add(ContinueEvent());
                            } else {
                              context
                                  .read<PersonalBloc>()
                                  .add(DissContinueEvent());
                            }
                          } else if (currentStep == 1) {
                            setState(() => currentStep += 1);
                            if (state.cardValidateState == true) {
                              context.read<PersonalBloc>().add(ContinueEvent());
                            } else {
                              context
                                  .read<PersonalBloc>()
                                  .add(DissContinueEvent());
                            }
                          } else if (currentStep == 2) {
                            setState(() => currentStep += 1);
                            if (state.educationValidateState == true) {
                              context.read<PersonalBloc>().add(ContinueEvent());
                            } else {
                              context
                                  .read<PersonalBloc>()
                                  .add(DissContinueEvent());
                            }
                          } else if (currentStep == 3) {
                            setState(() => currentStep += 1);
                            if (state.familyValidateState == true) {
                              context.read<PersonalBloc>().add(ContinueEvent());
                            } else {
                              context
                                  .read<PersonalBloc>()
                                  .add(DissContinueEvent());
                            }
                          } else if (currentStep == 4) {
                            setState(() => currentStep += 1);
                            if (state.contactValidateState == true) {
                              context.read<PersonalBloc>().add(ContinueEvent());
                            } else {
                              context
                                  .read<PersonalBloc>()
                                  .add(DissContinueEvent());
                            }
                          } else {}
                        },
                        onStepCancel: currentStep == 0
                            ? null
                            : () {
                                if (currentStep == 1) {
                                  setState(() => currentStep -= 1);
                                  if (state.profileValidateState == true) {
                                    context
                                        .read<PersonalBloc>()
                                        .add(ContinueEvent());
                                  }
                                } else if (currentStep == 2) {
                                  setState(() => currentStep -= 1);
                                  if (state.addressValidateState == true) {
                                    context
                                        .read<PersonalBloc>()
                                        .add(ContinueEvent());
                                  }
                                } else if (currentStep == 3) {
                                  setState(() => currentStep -= 1);
                                  if (state.cardValidateState == true) {
                                    context
                                        .read<PersonalBloc>()
                                        .add(ContinueEvent());
                                  }
                                } else if (currentStep == 4) {
                                  setState(() => currentStep -= 1);
                                  if (state.educationValidateState == true) {
                                    context
                                        .read<PersonalBloc>()
                                        .add(ContinueEvent());
                                  }
                                } else if (currentStep == 5) {
                                  setState(() => currentStep -= 1);
                                  if (state.familyValidateState == true) {
                                    context
                                        .read<PersonalBloc>()
                                        .add(ContinueEvent());
                                  }
                                } else {}
                              },
                        controlsBuilder: (context, details) {
                          final isLastStep =
                              currentStep == getSteps().length - 1;
                          return Container(
                            margin: const EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(flex: 4, child: Container()),
                                if (currentStep != 0)
                                  Expanded(
                                    flex: 1,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey),
                                      onPressed: details.onStepCancel,
                                      child: const Text('Back'),
                                    ),
                                  ),
                                const SizedBox(width: 12),
                                if (state.onContinue == true)
                                  Expanded(
                                    flex: 1,
                                    child: ElevatedButton(
                                      onPressed: details.onStepContinue,
                                      child: Text(
                                          isLastStep ? 'CONFIRM' : 'Continue'),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
