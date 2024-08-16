// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/trip_bloc/trip_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/trip/cars/cars_model.dart';
import 'package:hris_app_prototype/src/model/trip/cars/change_car_model.dart';
import 'package:hris_app_prototype/src/model/trip/trip_data_all_model.dart';
import 'package:hris_app_prototype/src/services/api_trip_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class ChangeCarOnTrip extends StatefulWidget {
  final TripDatum tripData;
  final String startDate;
  final String endDate;
  const ChangeCarOnTrip({
    Key? key,
    required this.tripData,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);

  @override
  State<ChangeCarOnTrip> createState() => _ChangeCarOnTripState();
}

class _ChangeCarOnTripState extends State<ChangeCarOnTrip> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController mileage1 = TextEditingController();
  TextEditingController carNumber1 = TextEditingController();

  List<CarDatum> carDataList = [];
  String? carId1;

  List<TripDatum> tripDataList1 = [];
  String? tripDataId1;

  List<TripDatum> tripDataList2 = [];
  String? tripDataId2;

  TextEditingController mileage2 = TextEditingController();
  TextEditingController carNumber2 = TextEditingController();
  String? carId2;

  Future fetchDropdown() async {
    CarsModel? car = await ApiTripService.getCarsData();
    TripDataModel? tripData = await ApiTripService.getTripDataDropdown();

    setState(() {
      carDataList = car?.carData ?? [];
      tripDataList1 = tripData?.tripData ?? [];
      tripDataList2 = tripData?.tripData ?? [];
    });
  }

  Future changeDialog(String tripId) async {
    AwesomeDialog(
            width: 400,
            context: context,
            animType: AnimType.topSlide,
            dialogType: DialogType.info,
            dialogBackgroundColor: mygreycolors,
            dialogBorderRadius: BorderRadius.circular(14),
            body: const Column(
              children: [
                TextThai(text: "ต้องการสลับ/เปลี่ยนรถภายในทริป"),
                Gap(5),
              ],
            ),
            btnCancelOnPress: () {},
            btnOkOnPress: () async {
              String? employeeId;
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              employeeId = preferences.getString("employeeId")!;
              ChangeCarModel updateModel = ChangeCarModel(
                  tripId1: widget.tripData.tripId,
                  mileageNumber1: mileage1.text,
                  tripId2: tripId,
                  mileageNumber2: mileage2.text,
                  changeBy: employeeId);
              bool success = await ApiTripService.changeCar(updateModel);
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
                        ? 'Change Car Success.'
                        : ''
                    : type == 0
                        ? 'Change Car Fail.'
                        : '',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              TextThai(
                text: success == true
                    ? type == 0
                        ? 'สลับ / เปลี่ยนรถ สำเร็จ'
                        : ''
                    : type == 0
                        ? 'สลับ / เปลี่ยนรถ ไม่สำเร็จ'
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
          context.read<TripBloc>().add(GetAllTripDataEvents(
              startDate: widget.startDate, endDate: widget.endDate));
        } else {}
      },
    ).show();
  }

  @override
  void initState() {
    super.initState();
    fetchDropdown();
    tripDataId1 = widget.tripData.tripId;
    carId1 = widget.tripData.carData.carId;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: TextThai(
                      text: "ทริปที่ 1",
                      textStyle: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Gap(5),
                  DropdownGlobalOutline(
                      labeltext: '',
                      value: tripDataId1,
                      items: tripDataList1.map((e) {
                        String destination = e.destination
                            .map((i) => i.provinceNameTh.toString())
                            .join(", ");
                        return DropdownMenuItem<String>(
                          value: e.tripId.toString(),
                          enabled: false,
                          onTap: null,
                          child: Container(
                              constraints: const BoxConstraints(
                                  maxWidth: 400, minWidth: 100),
                              child: Text(
                                  "${e.startDate} - ${e.endDate}  $destination ${e.carData.carModel} ${e.carData.carRegistation}")),
                        );
                      }).toList(),
                      onChanged: null,
                      validator: null),
                  const Gap(5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: DropdownGlobalOutline(
                          labeltext: 'รถ',
                          value: carId1,
                          items: carDataList.map((e) {
                            return DropdownMenuItem<String>(
                              value: e.carId.toString(),
                              enabled: false,
                              child: Container(
                                  width: 58,
                                  constraints: const BoxConstraints(
                                      maxWidth: 150, minWidth: 100),
                                  child: Text(e.carRegistation)),
                            );
                          }).toList(),
                          onChanged: null,
                          validator: null,
                          enable: false,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextFormFieldGlobalWithOutLine(
                            controller: mileage1,
                            labelText: "เลขไมล์",
                            hintText: "",
                            validatorless: Validatorless.multiple([
                              Validatorless.required("โปรดระบุเลขไมล์"),
                              Validatorless.number("กรอกเฉพาะตัวเลข"),
                            ]),
                            enabled: true),
                      ),
                    ],
                  ),
                  //
                  const Gap(10),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: TextThai(
                      text: "ทริปที่ 2",
                      textStyle: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Gap(5),
                  DropdownGlobalOutline(
                      labeltext: 'เลือกทริปที่ต้องการสลับรถ',
                      value: tripDataId2,
                      items: tripDataList2.map((e) {
                        String destination = e.destination
                            .map((i) => i.provinceNameTh.toString())
                            .join(", ");

                        return DropdownMenuItem<String>(
                          value: e.tripId.toString(),
                          child: Container(
                              constraints: const BoxConstraints(
                                  maxWidth: 400, minWidth: 100),
                              child: Text(
                                  "${e.startDate} - ${e.endDate}  $destination ${e.carData.carModel} ${e.carData.carRegistation}")),
                          onTap: () {
                            setState(() {
                              carId2 = e.carData.carId;
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          tripDataId2 = newValue.toString();
                        });
                      },
                      validator: null),
                  const Gap(5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: DropdownGlobalOutline(
                          labeltext: 'รถ',
                          value: carId2,
                          items: carDataList.map((e) {
                            return DropdownMenuItem<String>(
                              value: e.carId.toString(),
                              enabled: false,
                              child: Container(
                                  width: 58,
                                  constraints: const BoxConstraints(
                                      maxWidth: 150, minWidth: 100),
                                  child: Text(e.carRegistation)),
                            );
                          }).toList(),
                          onChanged: null,
                          validator: null,
                          enable: false,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextFormFieldGlobalWithOutLine(
                            controller: mileage2,
                            labelText: "เลขไมล์",
                            hintText: "",
                            validatorless: Validatorless.multiple([
                              Validatorless.required("โปรดระบุเลขไมล์"),
                              Validatorless.number("กรอกเฉพาะตัวเลข"),
                            ]),
                            enabled: true),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          MySaveButtons(
            text: "Submit",
            onPressed: tripDataId1 == tripDataId2
                ? null
                : () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        changeDialog(tripDataId2.toString());
                      });
                    }
                  },
          )
        ],
      ),
    );
  }
}
