// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/trip_bloc/trip_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/trip/cars/dropdown_car_type_model.dart';
import 'package:hris_app_prototype/src/model/trip/cars/cars_model.dart';
import 'package:hris_app_prototype/src/model/trip/cars/create_car_model.dart';
import 'package:hris_app_prototype/src/model/trip/cars/update_car_model.dart';
import 'package:hris_app_prototype/src/services/api_trip_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class CreateUpdateCars extends StatefulWidget {
  final int type; // 0 = create, 1 = update

  final CarDatum? carData;
  const CreateUpdateCars({Key? key, required this.type, this.carData})
      : super(key: key);

  @override
  State<CreateUpdateCars> createState() => _CreateUpdateCarsState();
}

class _CreateUpdateCarsState extends State<CreateUpdateCars> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _updateKey = GlobalKey<FormState>();

  List<MockupModel> brand = [
    MockupModel(id: "0", name: "Toyota"),
    MockupModel(id: "1", name: "Isuzu"),
    MockupModel(id: "2", name: "Honda"),
    MockupModel(id: "3", name: "Ford"),
    MockupModel(id: "4", name: "Mitsubushi"),
    MockupModel(id: "5", name: "Mazda"),
    MockupModel(id: "6", name: "Nissan"),
    MockupModel(id: "7", name: "Suzuki"),
    MockupModel(id: "8", name: "Hino"),
    MockupModel(id: "9", name: "Scania"),
    MockupModel(id: "10", name: "Volvo"),
    MockupModel(id: "11", name: "BMW"),
    MockupModel(id: "11", name: "Audi"),
  ];
  String? brandName;

  //textformfield
  TextEditingController carModel = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController mileage = TextEditingController();
  TextEditingController description = TextEditingController();
  String status = "ว่าง";

  //car type
  List<CarTypeDatum> carTypeData = [];
  String? carTypeId;

  Future createCar() async {
    String? employeeId;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    CreateCarsModel createModel = CreateCarsModel(
        carTypeId: carTypeId!,
        carRegistationNumber: number.text,
        carColor: description.text,
        carBrand: brandName!,
        carModel: carModel.text,
        mileageNumber: mileage.text,
        createBy: employeeId);
    bool success = await ApiTripService.createCar(createModel);
    alertDialog(success, 0);
  }

  updateDialog() {
    TextEditingController comment = TextEditingController();
    AwesomeDialog(
            width: 400,
            context: context,
            animType: AnimType.topSlide,
            dialogType: DialogType.info,
            dialogBackgroundColor: mygreycolors,
            btnCancelColor: Colors.red[800],
            dialogBorderRadius: BorderRadius.circular(14),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _updateKey,
                child: Column(
                  children: [
                    const TextThai(text: "หมายเหตุ*"),
                    const Gap(5),
                    TextFormFieldGlobal(
                        controller: comment,
                        labelText: "รายละเอียด",
                        hintText: "",
                        validatorless: Validatorless.required(
                            "โปรดระบุรายละเอียดการแก้ไข"),
                        enabled: true),
                    const Gap(5),
                  ],
                ),
              ),
            ),
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              if (_updateKey.currentState!.validate()) {
                setState(() {
                  updateCar(comment.text);
                });
              } else {}
            },
            btnOkColor: mythemecolor)
        .show();
  }

  Future updateCar(String comment) async {
    String? employeeId;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    UpdateCarModel updateModel = UpdateCarModel(
        carId: widget.carData!.carId,
        carTypeId: carTypeId!,
        carRegistation: number.text,
        carColor: description.text,
        carBrand: brandName!,
        carModel: carModel.text,
        carStatus: status,
        modifiedBy: employeeId,
        comment: comment);

    bool success = await ApiTripService.updateCar(updateModel);
    alertDialog(success, 1);
  }

  alertDialog(bool success, int type) {
    AwesomeDialog(
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
                        ? 'Created Success.'
                        : 'Updated Success.'
                    : type == 0
                        ? 'Created Fail.'
                        : 'Updated Fail.',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              TextThai(
                text: success == true
                    ? type == 0
                        ? 'เพิ่มข้อมูล สำเร็จ'
                        : 'แก้ไขข้อมูล สำเร็จ'
                    : type == 0
                        ? 'เพิ่มข้อมูล ไม่สำเร็จ'
                        : 'แก้ไขข้อมูล ไม่สำเร็จ',
                textStyle: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
      btnOkColor: success == true ? Colors.greenAccent : Colors.red,
      btnOkOnPress: () {
        if (success == true) {
          context.read<TripBloc>().add(GetAllCarDataEvents());
          Navigator.pop(context);
        } else {}
      },
    ).show();
  }

  Future fetchDropdown() async {
    CarTypeModel cartype = await ApiTripService.getCarTypeDropdown();

    setState(() {
      carTypeData = cartype.carTypeData;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDropdown();
    if (widget.type == 1) {
      CarDatum data = widget.carData!;
      carTypeId = data.carTypeData.carTypeId;
      carModel.text = data.carModel;
      brandName = data.carBrand;
      number.text = data.carRegistation;
      description.text = data.carColor;
      status = data.carStatus;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Column(
          children: [
            DropdownGlobal(
                labeltext: "ประเภทรถ",
                value: carTypeId,
                items: carTypeData.map((e) {
                  return DropdownMenuItem<String>(
                    value: e.carTypeId,
                    child: Container(
                        constraints:
                            const BoxConstraints(maxWidth: 300, minWidth: 80),
                        child: Text(e.carName)),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    carTypeId = newValue.toString();
                  });
                },
                validator: null),
            const Gap(10),
            Row(
              children: [
                Expanded(
                  child: DropdownGlobal(
                      labeltext: "ยี่ห้อ",
                      value: brandName,
                      items: brand.map((e) {
                        return DropdownMenuItem<String>(
                          value: e.name,
                          child: Container(
                              constraints: const BoxConstraints(
                                  maxWidth: 120, minWidth: 80),
                              child: Text("${e.id} : ${e.name}")),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          brandName = newValue.toString();
                        });
                      },
                      validator: null),
                ),
                const Gap(10),
                Expanded(
                  child: TextFormFieldGlobal(
                      controller: carModel,
                      labelText: "รุ่น",
                      hintText: "",
                      validatorless: null,
                      enabled: true),
                )
              ],
            ),
            const Gap(10),
            Row(
              children: [
                Expanded(
                  child: TextFormFieldGlobal(
                      controller: number,
                      labelText: "ทะเบียนรถ",
                      hintText: "",
                      validatorless: null,
                      enabled: true),
                ),
                const Gap(10),
                Expanded(
                  child: TextFormFieldGlobal(
                      controller: mileage,
                      labelText: "เลขไมล์",
                      hintText: "",
                      validatorless: null,
                      enabled: true),
                )
              ],
            ),
            const Gap(10),
            TextFormFieldGlobal(
                controller: description,
                labelText: "รายละเอียด",
                hintText: "",
                validatorless: null,
                enabled: true),
          ],
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.type == 0
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 29,
                        width: 80,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: status == "0" ? 2 : 0,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(6))),
                              backgroundColor: status == "0"
                                  ? Colors.greenAccent
                                  : Colors.grey[300],
                            ),
                            onPressed: () {
                              setState(() {
                                status = "0";
                              });
                            },
                            child: Text(
                              "ว่าง",
                              style: TextStyle(
                                  color: status == "0"
                                      ? Colors.black87
                                      : Colors.black45),
                            )),
                      ),
                      // SizedBox(
                      //   width: 80,
                      //   height: 29,
                      //   child: ElevatedButton(
                      //       style: ElevatedButton.styleFrom(
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.horizontal(
                      //                 right: Radius.circular(0))),
                      //         elevation: status == "ใช้งาน" ? 2 : 0,
                      //         backgroundColor: status == "ใช้งาน"
                      //             ? mythemecolor
                      //             : Colors.grey[300],
                      //       ),
                      //       onPressed: () {
                      //         setState(() {
                      //           status = "ใช้งาน";
                      //         });
                      //       },
                      //       child: Text(
                      //         "ใช้งาน",
                      //         style: TextStyle(
                      //             color: status == "ใช้งาน"
                      //                 ? Colors.white
                      //                 : Colors.black45),
                      //       )),
                      // ),
                      SizedBox(
                        width: 83,
                        height: 29,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(0))),
                              elevation: status == "2" ? 2 : 0,
                              backgroundColor: status == "2"
                                  ? Colors.amberAccent
                                  : Colors.grey[300],
                            ),
                            onPressed: () {
                              setState(() {
                                status = "2";
                              });
                            },
                            child: Text(
                              "ซ่อมบำรุง",
                              style: TextStyle(
                                  color: status == "2"
                                      ? Colors.black87
                                      : Colors.black45),
                            )),
                      ),
                      SizedBox(
                        width: 80,
                        height: 29,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: status == "3" ? 2 : 0,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(6))),
                              backgroundColor: status == "3"
                                  ? Colors.red[800]
                                  : Colors.grey[300],
                            ),
                            onPressed: () {
                              setState(() {
                                status = "3";
                              });
                            },
                            child: Text(
                              "เพิกถอน",
                              style: TextStyle(
                                  color: status == "3"
                                      ? Colors.white
                                      : Colors.black45),
                            )),
                      ),
                    ],
                  ),
            MySaveButtons(
              text: widget.type == 0 ? "Add" : "Update",
              onPressed: () {
                setState(() {
                  if (widget.type == 0) {
                    //create
                    createCar();
                  } else {
                    // update
                    updateDialog();
                  }
                });
              },
            ),
          ],
        )
      ],
    );
  }
}

class MockupModel {
  final String id;
  final String name;
  MockupModel({
    required this.id,
    required this.name,
  });
}
