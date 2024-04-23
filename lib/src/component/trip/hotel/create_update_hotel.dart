import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/trip_bloc/trip_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/trip/dropdown_province_model.dart';
import 'package:hris_app_prototype/src/model/trip/hotels/create_hotel_model.dart';
import 'package:hris_app_prototype/src/model/trip/hotels/dropdown_hotel_type_model.dart';
import 'package:hris_app_prototype/src/model/trip/hotels/hotel_data_all_model.dart';
import 'package:hris_app_prototype/src/model/trip/hotels/update_hotel_model.dart';
import 'package:hris_app_prototype/src/services/api_trip_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class CreateUpdateHotels extends StatefulWidget {
  final int type;
  final HotelDatum? hoteldata;
  const CreateUpdateHotels({Key? key, required this.type, this.hoteldata})
      : super(key: key);

  @override
  State<CreateUpdateHotels> createState() => _CreateUpdateHotelsState();
}

class _CreateUpdateHotelsState extends State<CreateUpdateHotels> {
  final GlobalKey<FormState> _updateKey = GlobalKey<FormState>();
//textformfield
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  bool? status;
  //

//dropdown
  List<ProvinceDatum> provinceList = [];
  String? provinceId;
  List<HotelTypeDatum> hotelTypeList = [];
  String? hotelTypeId;

  Future getDropdown() async {
    ProvinceDropdownModel province = await ApiTripService.getProvinceDropdown();
    HotelTypeModel hotelType = await ApiTripService.getHotelTypeDropdown();
    setState(() {
      provinceList = province.provinceData;
      hotelTypeList = hotelType.hotelTypeData;
    });
  }

  Future createCar() async {
    String? employeeId;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    CreateHotelModel createModel = CreateHotelModel(
        hotelTypeId: hotelTypeId!,
        price: price.text,
        hotelName: name.text,
        provinceId: provinceId!,
        description: description.text,
        createBy: employeeId);
    bool success = await ApiTripService.createHotel(createModel);
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
                  updateHotel(comment.text);
                });
              } else {}
            },
            btnOkColor: mythemecolor)
        .show();
  }

  Future updateHotel(String comment) async {
    String? employeeId;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    UpdateHotelModel updateModel = UpdateHotelModel(
        hotelId: widget.hoteldata!.hotelId,
        hotelTypeId: hotelTypeId!,
        price: price.text,
        hotelName: name.text,
        provinceId: provinceId!,
        description: description.text,
        modifyBy: employeeId);
    bool success = await ApiTripService.updateHotel(updateModel);
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
          context.read<TripBloc>().add(GetAllHotelDataEvents());
          Navigator.pop(context);
        } else {}
      },
    ).show();
  }

  @override
  void initState() {
    super.initState();
    getDropdown();
    if (widget.type == 1) {
      HotelDatum data = widget.hoteldata!;
      hotelTypeId = data.hotelType.hotelTypeId;
      provinceId = data.province.provinceId;
      name.text = data.hotelName;
      price.text = data.price;
      description.text =
          data.hotelDescription == "No data" ? "" : data.hotelDescription;
      status = data.status == "Active" ? true : false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: DropdownGlobal(
                        labeltext: 'ประเภทที่พัก',
                        value: hotelTypeId,
                        items: hotelTypeList.map((e) {
                          return DropdownMenuItem<String>(
                            value: e.hotelTypeId.toString(),
                            child: Container(
                                width: 58,
                                constraints: const BoxConstraints(
                                    maxWidth: 150, minWidth: 100),
                                child: Text(e.hotelTypeName)),
                            onTap: () {},
                          );
                        }).toList(),
                        onChanged: (newValue) async {
                          setState(() {
                            hotelTypeId = newValue.toString();
                          });
                        },
                        validator: null),
                  ),
                  const Gap(5),
                  Expanded(
                    child: DropdownGlobal(
                        labeltext: 'จังหวัด',
                        value: provinceId,
                        items: provinceList.map((e) {
                          return DropdownMenuItem<String>(
                            value: e.provinceId.toString(),
                            child: Container(
                                width: 58,
                                constraints: const BoxConstraints(
                                    maxWidth: 150, minWidth: 100),
                                child: Text(e.provinceNameTh)),
                            onTap: () {},
                          );
                        }).toList(),
                        onChanged: (newValue) async {
                          setState(() {
                            provinceId = newValue.toString();
                          });
                        },
                        validator: null),
                  ),
                ],
              ),
              const Gap(10),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                  flex: 4,
                  child: TextFormFieldGlobal(
                      controller: name,
                      labelText: "ชื่อที่พัก",
                      hintText: "",
                      validatorless: null,
                      enabled: true),
                ),
                const Gap(5),
                Expanded(
                  flex: 2,
                  child: TextFormFieldGlobal(
                      controller: price,
                      labelText: "ราคาห้องพัก(บาท)",
                      hintText: "",
                      validatorless: Validatorless.number("ระบุเป็นจำนวนเงิน"),
                      enabled: true),
                )
              ]),
              const Gap(10),
              TextFormFieldGlobal(
                  controller: description,
                  labelText: "รายละเอียด",
                  hintText: "",
                  validatorless: null,
                  enabled: true),
            ],
          ),
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.type == 0
                ? Container()
                : Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: status == true ? 2 : 0,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(6))),
                              backgroundColor: status == true
                                  ? Colors.greenAccent
                                  : Colors.grey[300],
                            ),
                            onPressed: () {
                              setState(() {
                                status = true;
                              });
                            },
                            child: Text(
                              "Active",
                              style: TextStyle(
                                  color: status == true
                                      ? Colors.black87
                                      : Colors.black45),
                            )),
                      ),
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: status == false ? 2 : 0,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(6))),
                              backgroundColor: status == false
                                  ? Colors.red[800]
                                  : Colors.grey[300],
                            ),
                            onPressed: () {
                              setState(() {
                                status = false;
                              });
                            },
                            child: Text(
                              "Inactive",
                              style: TextStyle(
                                  color: status == false
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
                    createCar();
                  } else {
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
