import 'package:flutter/material.dart';
import 'package:hris_app_prototype/src/component/personal/address/add/1_add_address_layout.dart';
import 'package:hris_app_prototype/src/component/personal/cardinfo/idcard/add/1_add_idcard_layout.dart';
import 'package:hris_app_prototype/src/component/personal/contact_person/add/1_add_contact.dart';
import 'package:hris_app_prototype/src/component/personal/education/add/1_add_education_layout.dart';
import 'package:hris_app_prototype/src/component/personal/family/add/1_add_family_layout.dart';
import 'package:hris_app_prototype/src/component/personal/person/add/add_person_personal.dart';

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
          content: Expanded(child: Addpersonal(personId: widget.personId)),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text('Address'),
          content: Expanded(
              flex: 4, child: AddAddressbyperson(personId: widget.personId)),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text('Card Infomation'),
          content: Expanded(
              flex: 2, child: AddCardInfoLayout(personId: widget.personId)),
        ),
        Step(
          state: currentStep > 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 3,
          title: const Text('Education'),
          content:
              Expanded(child: AddEducationLayout(personId: widget.personId)),
        ),
        Step(
            state: currentStep > 4 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 4,
            title: const Text('Family'),
            content:
                Expanded(child: AddFamilyLayout(personId: widget.personId))),
        Step(
            state: currentStep > 5 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 5,
            title: const Text('Contact'),
            content:
                Expanded(child: AddContactLayout(personId: widget.personId))),
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
                },
                child: const Text('X')),
          ),
          const SizedBox(
            width: 5,
          )
        ],
      ),
      body: isCompleted
          ? const Center(child: Text('Success'))
          : Center(
              child: SizedBox(
                child: Theme(
                  data: Theme.of(context).copyWith(
                      colorScheme:
                          const ColorScheme.light(primary: Colors.deepPurple)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stepper(
                      elevation: 0,
                      type: StepperType.horizontal,
                      steps: getSteps(),
                      currentStep: currentStep,
                      onStepTapped: (step) {
                        setState(() {
                          currentStep = step;
                        });
                      },
                      onStepContinue: () {
                        final isLastStep = currentStep == getSteps().length - 1;

                        if (isLastStep) {
                          setState(() => isCompleted = true);

                          print('complete');
                          //send data to server
                        } else {
                          setState(() => currentStep += 1);
                        }
                      },
                      onStepCancel: currentStep == 0
                          ? null
                          : () {
                              setState(() => currentStep -= 1);
                            },
                      controlsBuilder: (context, details) {
                        final isLastStep = currentStep == getSteps().length - 1;
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
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  onPressed: details.onStepContinue,
                                  child:
                                      Text(isLastStep ? 'CONFIRM' : 'Continue'),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
