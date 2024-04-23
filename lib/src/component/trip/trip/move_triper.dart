// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/trip/get_trip_by_id_model.dart';
import 'package:hris_app_prototype/src/model/trip/move_triper_model.dart';
import 'package:hris_app_prototype/src/model/trip/trip_data_all_model.dart';
import 'package:hris_app_prototype/src/services/api_trip_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoveTriper extends StatefulWidget {
  final TripData tripData;
  final TriperDatum data;
  const MoveTriper({
    Key? key,
    required this.tripData,
    required this.data,
  }) : super(key: key);

  @override
  State<MoveTriper> createState() => _MoveTriperState();
}

class _MoveTriperState extends State<MoveTriper> {
  List<TripDatum> tripDataList = [];
  String? tripDataId;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  Future fetchDropdown() async {
    TripDataModel? tripData = await ApiTripService.getTripDataDropdown();

    setState(() {
      tripDataList = tripData?.tripData ?? [];
      tripDataList
          .removeWhere((element) => element.tripId == widget.tripData.tripId);
    });
  }

  Future moveDialog() async {
    AwesomeDialog(
            width: 400,
            context: context,
            animType: AnimType.topSlide,
            dialogType: DialogType.info,
            dialogBackgroundColor: mygreycolors,
            dialogBorderRadius: BorderRadius.circular(14),
            body: const Column(
              children: [
                TextThai(text: "ต้องการย้ายผู้ร่วมทริป"),
                Gap(5),
              ],
            ),
            btnCancelOnPress: () {},
            btnOkOnPress: () async {
              String? employeeId;
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              employeeId = preferences.getString("employeeId")!;
              MoveTriperModel updateModel = MoveTriperModel(
                  triperId: widget.data.triperId,
                  newTripId: tripDataId.toString(),
                  changeBy: employeeId);

              bool success = await ApiTripService.moveTriper(updateModel);
              alertDialog(success, 0);
            },
            btnOkColor: mythemecolor)
        .show();
  }

  alertDialog(bool success, int type) {
    AwesomeDialog(
      // 0 cancel , 1 finish
      dismissOnTouchOutside: false,
      width: 400,
      context: context,
      animType: AnimType.topSlide,
      dialogType: success == true ? DialogType.success : DialogType.error,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Column(
            children: [
              Text(
                success == true
                    ? type == 0
                        ? 'Move Triper Success.'
                        : ''
                    : type == 0
                        ? 'Move Triper Fail.'
                        : '',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              TextThai(
                text: success == true
                    ? type == 0
                        ? 'ย้ายผู้ร่วมทริป สำเร็จ'
                        : ''
                    : type == 0
                        ? 'ย้ายผู้ร่วมทริป ไม่สำเร็จ'
                        : '',
                textStyle: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
      btnOkColor: success == true ? Colors.greenAccent : Colors.red,
      btnOkOnPress: () {
        if (success == true) {
          Navigator.pop(context);
          Navigator.pop(context);
          // context.read<TripBloc>().add(GetAllTripDataEvents(
          //     startDate: widget.startDate, endDate: widget.endDate));
        } else {}
      },
    ).show();
  }

  @override
  void initState() {
    super.initState();
    fetchDropdown();
    firstName.text = widget.data.employeeData.firstNameTh;
    lastName.text = widget.data.employeeData.lastNameTh;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                DropdownGlobalOutline(
                    labeltext: 'เลือกทริปที่ต้องการย้ายไป',
                    value: tripDataId,
                    items: tripDataList.map((e) {
                      String destination = e.destination
                          .map((i) => i.provinceNameTh.toString())
                          .join(", ");
                      return DropdownMenuItem<String>(
                        value: e.tripId.toString(),
                        child: Container(
                            constraints: const BoxConstraints(
                                maxWidth: 400, minWidth: 100),
                            child: Text(
                                "${e.startDate} - ${e.endDate}  $destination")),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        tripDataId = newValue.toString();
                      });
                    },
                    validator: null),
                const Gap(10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormFieldGlobalWithOutLine(
                          controller: firstName,
                          labelText: "ชื่อ",
                          hintText: "",
                          validatorless: null,
                          enabled: false),
                    ),
                    Expanded(
                      child: TextFormFieldGlobalWithOutLine(
                          controller: lastName,
                          labelText: "นามสกุล",
                          hintText: "",
                          validatorless: null,
                          enabled: false),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        MySaveButtons(
          text: "Submit",
          onPressed: tripDataId == widget.tripData.tripId
              ? null
              : () {
                  setState(() {
                    moveDialog();
                  });
                },
        )
      ],
    );
  }
}
