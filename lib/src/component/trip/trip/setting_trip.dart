// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/trip_bloc/trip_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee/datatable_employee.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/component/trip/trip/move_triper.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';
import 'package:hris_app_prototype/src/model/trip/create_trip_model.dart';
import 'package:hris_app_prototype/src/model/trip/cars/cars_model.dart';
import 'package:hris_app_prototype/src/model/trip/dropdown_province_model.dart';
import 'package:hris_app_prototype/src/model/trip/dropdown_tripertype_model.dart';
import 'package:hris_app_prototype/src/model/trip/dropdown_triptype_model.dart';
import 'package:hris_app_prototype/src/model/trip/get_trip_by_id_model.dart';
import 'package:hris_app_prototype/src/model/trip/hotels/hotel_data_all_model.dart';
import 'package:hris_app_prototype/src/model/trip/update_trip_model.dart';
import 'package:hris_app_prototype/src/services/api_trip_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingTrip extends StatefulWidget {
  final int type; //type 0 = create, type 1 = edit
  final String? statusType; //prepare / on-trip
  final String? tripId;
  final String startDate;
  final String endDate;
  const SettingTrip(
      {super.key,
      required this.type,
      this.tripId,
      this.statusType,
      required this.startDate,
      required this.endDate});

  @override
  State<SettingTrip> createState() => _SettingTripState();
}

enum IconLabel {
  // DropdownMenuEntry labels and values for the second dropdown menu.
  smile('Smile', Icons.sentiment_satisfied_outlined),
  cloud(
    'Cloud',
    Icons.cloud_outlined,
  ),
  brush('Brush', Icons.brush_outlined),
  heart('Heart', Icons.favorite);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}
// DropdownMenuEntry labels and values for the first dropdown menu.

enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Orange', Colors.orange),
  grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}

class _SettingTripState extends State<SettingTrip> {
  bool isExpandedTriper = false;
  //trip details.
  TextEditingController destination = TextEditingController();
  List<String> destinationList = [];
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController description = TextEditingController();

//รายละเอียดผู้เดินทาง
  TextEditingController name = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController position = TextEditingController();
  TextEditingController memberStartDate = TextEditingController();
  TextEditingController memberEndDate = TextEditingController();
  String? employeeId;

//ค่าใช้จ่าย
  bool isCheckedAllowance = false;
  bool isCheckedHotel = false;
  bool isCheckedOther = false;
  bool isCheckedGasoline = false;
  TextEditingController descOther = TextEditingController();
  TextEditingController costOther = TextEditingController();
  TextEditingController descGasoline = TextEditingController();
  TextEditingController costAllowance = TextEditingController();

//model triper
  List<Triper> tripers = []; //รวมคนทั้งหมดเข้า ทริป

//model create
  List<MemberTrip> members = []; //ใช้เฉพาะ ui
  // to create api
  CreateTripModel? createModel;
  // ค่าใช้จ่ายส่วนบุคคล
  List<Expenditure> membercost = [];

//dropdown
  bool isDropdownLoading = true;
  //trip type
  List<TripTypeDatum> tripTypeList = [];
  String? tripTypesId;

  List<ProvinceDatum> provinceList = [];
  String? provinceId;

// car
  List<CarDatum> carData = [];
  String? carId;
  String? carMileage;
  String? checkcarId;

//triper type
  List<TriperTypeDatum> triperTypeList = [];
  String? triperTypeId;
  String? triperTypeName;

//hotel
  List<HotelDatum> hostelList = [];
  String? hostelId;
  String? hostelName;
  String? hotelCost;

// model edit
  TripDataByIdModel? tripDataById;
  List<TriperDatum> editTriperList = [];
// ค่าใช้จ่ายส่วนบุคคล
  List<Expendition> editTripercost = [];
//model update
  UpdateTripModel? updateModel;
//model test
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  ColorLabel? selectedColor;
  IconLabel? selectedIcon;

//Function ----------------------------------------------------

// Select date
  Future<void> selectvalidFromDate(int type) async {
//0 = start , 1 = end
    DateTime? picker = await showDatePicker(
      // selectableDayPredicate: (DateTime val) => val.weekday == 7 ? false : true,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 2)),
      lastDate: DateTime(9999),
    );
    if (picker != null) {
      setState(() {
        if (type == 0) {
          startDate.text = picker.toString().split(" ")[0];
        } else {
          endDate.text = picker.toString().split(" ")[0];
        }
        if (widget.type == 0) {
          memberStartDate.text = startDate.text;
          memberEndDate.text = endDate.text;
        }
      });
    }
  }

// Select date
  Future<void> selectvalidFromMemberDate(int type) async {
//0 = start , 1 = end
    DateTime start = DateTime.parse(startDate.text);
    DateTime end = DateTime.parse(endDate.text);
    DateTime? picker = await showDatePicker(
      // selectableDayPredicate: (DateTime val) => val.weekday == 7 ? false : true,
      context: context,
      initialDate: start,
      firstDate: start,
      lastDate: end,
    );
    if (picker != null) {
      setState(() {
        if (type == 0) {
          memberStartDate.text = picker.toString().split(" ")[0];
        } else {
          memberEndDate.text = picker.toString().split(" ")[0];
        }
      });
    }
  }

  //check car for create
  Future checkCar(String carId, String startDate, String endDate) async {
    bool success = await ApiTripService.checkCar(carId, startDate, endDate);
    setState(() {
      if (success) {
        isExpandedTriper = !isExpandedTriper;
      } else {
        AwesomeDialog(
            width: 370,
            context: context,
            animType: AnimType.topSlide,
            dialogType: DialogType.error,
            dialogBackgroundColor: mygreycolors,
            dialogBorderRadius: BorderRadius.circular(14),
            btnOkOnPress: () {},
            btnOkColor: const Color.fromARGB(255, 216, 68, 68),
            body: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextThai(
                    text: "คิวรถในวันที่ ดังกล่าวไม่ว่าง",
                  ),
                  TextThai(text: "แก้ไขโดยการ เปลี่ยนรถหรือเปลี่ยนวันที่"),
                ],
              ),
            )).show();
      }
    });
  }

//select employee
  getEmployeeData() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: mygreycolors,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: SafeArea(
                child: SizedBox(
                    width: 1200,
                    height: MediaQuery.of(context).size.height - 20,
                    child: const DatatableEmployee(
                      isSelected: true,
                      isSelectedOne: true,
                    )),
              ));
        });
  }

  //Move triper
  moveTriperDialog(TriperDatum data) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                    backgroundColor: mygreycolors,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: TitleDialog(
                      title: "ย้ายผู้ร่วมทริป",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    content: SizedBox(
                        width: 560,
                        height: 180,
                        child: MoveTriper(
                          data: data,
                          tripData: tripDataById!.tripData,
                        )),
                  ));
        });
  }

  addCostMembertrip() {
    // check member cost
    if (isCheckedAllowance == true) {
      //costOther
      membercost.add(Expenditure(
          expenditureTypeId: "00",
          cost: costAllowance.text,
          description: "ค่าเบี้ยเลี้ยง"));
    } else {
      membercost.removeWhere((element) => element.expenditureTypeId == "00");
    }
    if (isCheckedGasoline == true) {
      //gasoline
      membercost.add(Expenditure(
          expenditureTypeId: "02",
          cost: descGasoline.text,
          description: "ค่าน้ำมัน"));
    } else {
      membercost.removeWhere((element) => element.expenditureTypeId == "02");
    }
    if (isCheckedHotel == true) {
      //hotel
      membercost.add(Expenditure(
          expenditureTypeId: "01",
          cost: hotelCost.toString(), //รอ มีตารางโรงแรม
          description: hostelName.toString()));
    } else {
      membercost.removeWhere((element) => element.expenditureTypeId == "01");
    }
    if (isCheckedOther == true) {
      //costOther
      membercost.add(Expenditure(
          expenditureTypeId: "03",
          cost: costOther.text,
          description: descOther.text));
    } else {
      membercost.removeWhere((element) => element.expenditureTypeId == "03");
    }
  }

//functions edit triper & cost
  editCostMembertrip() {
    // check member cost
    if (isCheckedAllowance == true) {
      //allowance
      editTripercost.add(Expendition(
          expenditureId: "",
          expenditureTypeId: "00",
          triperId: "",
          cost: costAllowance.text,
          description: "ค่าเบี้ยเลี้ยง"));
    } else {
      editTripercost
          .removeWhere((element) => element.expenditureTypeId == "00");
    }
    if (isCheckedGasoline == true) {
      //gasoline
      editTripercost.add(Expendition(
          expenditureId: "",
          expenditureTypeId: "02",
          triperId: "",
          cost: descGasoline.text,
          description: "ค่าน้ำมัน"));
    } else {
      editTripercost
          .removeWhere((element) => element.expenditureTypeId == "02");
    }
    if (isCheckedHotel == true) {
      //hotel
      editTripercost.add(Expendition(
          expenditureId: "",
          expenditureTypeId: "01",
          triperId: "",
          cost: "800", //รอ มีตารางโรงแรม
          description: hostelName.toString()));
    } else {
      editTripercost
          .removeWhere((element) => element.expenditureTypeId == "01");
    }
    if (isCheckedOther == true) {
      //costOther
      editTripercost.add(Expendition(
          expenditureId: "",
          expenditureTypeId: "03",
          triperId: "",
          cost: costOther.text,
          description: descOther.text));
    } else {
      editTripercost
          .removeWhere((element) => element.expenditureTypeId == "03");
    }
    editTripercost;
    editTriper();
  }

  editTriper() {
    bool foundEmployeeId = false;
    for (var element in editTriperList) {
      if (element.employeeId == employeeId) {
        element.triperTypeData.triperTypeId = triperTypeId!;
        element.startDate = memberStartDate.text;
        element.endDate = memberEndDate.text;
        element.expendition = editTripercost;
        foundEmployeeId = true;
      }
    }
    if (!foundEmployeeId) {
      editTriperList.add(TriperDatum(
          triperId: "",
          employeeId: employeeId.toString(),
          employeeData: EmployeeData(
              firstNameTh: name.text.toString(),
              firstNameEn: "",
              lastNameTh: "",
              lastNameEn: ""),
          position: Position(
              positionOrganizationId: "",
              positionOrganizationName: position.text),
          organization: Organization(
              organizationId: "",
              organizationCode: "",
              organizationName: department.text),
          triperTypeData: TriperTypeData(
              triperTypeId: triperTypeId!, triperTypeName: triperTypeName!),
          tripId: "",
          expendition: editTripercost,
          triperStatus: "",
          startDate: memberStartDate.text,
          endDate: memberEndDate.text));
    }
    editTripercost = [];
    name.text = "";
    department.text = "";
    position.text = "";
    memberStartDate.text = "";
    memberEndDate.text = "";
    isCheckedAllowance = false;
    isCheckedGasoline = false;
    isCheckedHotel = false;
    isCheckedOther = false;
    descGasoline.text = "";
    descOther.text = "";
    costOther.text = "";
    costAllowance.text = "";
    membercost = [];
    context.read<TripBloc>().add(ClearSelectEmployeeEvent());
  }

//
  addTriper() {
    members.add(MemberTrip(
        employeeId: employeeId.toString(),
        name: name.text,
        departmen: department.text,
        position: position.text,
        triptypeName: triperTypeName.toString(),
        startDate: memberStartDate.text,
        endDate: memberEndDate.text,
        cost: membercost));

    // add real data member
    tripers.add(Triper(
        employeeId: employeeId.toString(),
        triperTypeId: triperTypeId.toString(),
        startDate: memberStartDate.text,
        endDate: memberStartDate.text,
        expenditure: membercost));

    employeeId = "";
    name.text = "";
    department.text = "";
    position.text = "";
    isCheckedAllowance = false;
    isCheckedHotel = false;
    isCheckedOther = false;
    isCheckedGasoline = false;
    descOther.text = "";
    costOther.text = "";
    descGasoline.text = "";
    costAllowance.text = "";
    membercost = [];
    context.read<TripBloc>().add(ClearSelectEmployeeEvent());
  }

  Future updateTrip() async {
    tripers = [];
    List<Triper> convertedTriperList = [];
    List<Expenditure> convertedCostList = [];
    for (var element in editTriperList) {
      for (var m in element.expendition) {
        Expenditure cost = Expenditure(
          expenditureTypeId: m.expenditureTypeId,
          cost: m.cost,
          description: m.description,
        );
        convertedCostList.add(cost);
      }
      Triper triper = Triper(
          employeeId: element.employeeId,
          triperTypeId: element.triperTypeData.triperTypeId,
          startDate: element.startDate,
          endDate: element.endDate,
          expenditure: convertedCostList);
      convertedTriperList.add(triper);
      convertedCostList = [];
    }
    String? sEmployeeId;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sEmployeeId = preferences.getString("employeeId")!;
    updateModel = UpdateTripModel(
        tripId: tripDataById!.tripData.tripId,
        tripTypeId: tripTypesId!,
        destination: destinationList,
        tripDescription: description.text,
        carId: carId.toString(),
        tripers: convertedTriperList,
        startDate: startDate.text,
        endDate: endDate.text,
        modifiedBy: sEmployeeId,
        comment: "Edit trip");
    updateModel;
    bool success = await ApiTripService.updateTrip(updateModel);
    alertDialog(success, 1);
    convertedTriperList = [];
  }

  Future createmodel() async {
    String? employeeId;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    createModel = CreateTripModel(
        tripTypeId: tripTypesId!,
        destination: destinationList,
        tripDescription: description.text,
        carId: carId.toString(),
        startMileage: carMileage.toString(),
        tripers: tripers,
        startDate: startDate.text,
        endDate: endDate.text,
        createBy: employeeId,
        oldTripId: "",
        condition: "new");
    createModel;
    bool success = await ApiTripService.createTrip(createModel);
    alertDialog(success, 0);
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
          context.read<TripBloc>().add(GetAllTripDataEvents(
              startDate: widget.startDate, endDate: widget.endDate));
          Navigator.pop(context);
        } else {}
      },
    ).show();
  }

  Future getDropdown() async {
    // if (widget.type == 0) {
    //   CarsModel? car = await ApiTripService.getCarsData();
    //   carData = car?.carData ?? [];
    // } else {
    //   CarsModel car = await ApiTripService.getCarsOnTripDropdown();
    //   carData = car.carData;
    // }
    CarsModel? car = await ApiTripService.getCarsData();
    carData = car?.carData ?? [];
    TripTypeDropdownModel tripType = await ApiTripService.getTripTypeDropdown();
    TriperTypeDropdownModel triperType =
        await ApiTripService.getTriperTypeDropdown();
    ProvinceDropdownModel province = await ApiTripService.getProvinceDropdown();
    HotelDataModel? hotel = await ApiTripService.getHotelsData();

    setState(() {
      tripTypeList = tripType.tripTypeData;
      triperTypeList = triperType.triperTypeData;
      provinceList = province.provinceData;
      hostelList = hotel!.hotelData;
      if (widget.type == 0) {
        isDropdownLoading = false;
      }
    });
  }

  Future getTripData() async {
    tripDataById = await ApiTripService.getTripDataById(widget.tripId!);

    setState(() {
      isExpandedTriper = true;
//  tripTypesId = tripDataById!.tripData.tr
      TripData data = tripDataById!.tripData;
      for (var element in data.destination) {
        destinationList.add(element.provinceId);
      }
      editTriperList = data.triperData;
      destination.text =
          data.destination.map((e) => e.provinceNameTh.toString()).join(", ");
      tripTypesId = data.tripTypeData.tripTypeId == ""
          ? "001"
          : data.tripTypeData.tripTypeId;
      carId = data.carData.carId;
      checkcarId = data.carData.carId;
      startDate.text = data.startDate;
      endDate.text = data.endDate;
      description.text = data.tripDescription;
      isDropdownLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.type == 1) {
      getTripData();
    }
    getDropdown();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: isDropdownLoading == true
            ? myLoadingScreen
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //trip details
                  Expanded(
                    flex: 2,
                    child: Card(
                      color: mygreycolors,
                      elevation: 0,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.black26, width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                const Gap(18),
                                DropdownGlobalOutline(
                                    labeltext: 'ประเภททริป',
                                    value: tripTypesId,
                                    items: tripTypeList.map((e) {
                                      return DropdownMenuItem<String>(
                                        value: e.tripTypeId.toString(),
                                        child: Container(
                                            width: 58,
                                            constraints: const BoxConstraints(
                                                maxWidth: 150, minWidth: 100),
                                            child: Text(e.tripTypeName)),
                                      );
                                    }).toList(),
                                    onChanged: isExpandedTriper == true
                                        ? null
                                        : (newValue) {
                                            setState(() {
                                              tripTypesId = newValue.toString();
                                            });
                                          },
                                    validator: null),
                                const Gap(5),
                                TextFormFieldGlobalWithOutLine(
                                    controller: destination,
                                    labelText: "จุดหมาย",
                                    hintText: "จุดหมาย",
                                    validatorless: null,
                                    suffixIcon: destination.text == ""
                                        ? null
                                        : IconButton(
                                            onPressed: () {
                                              setState(() {
                                                destination.text = "";
                                                destinationList = [];
                                              });
                                            },
                                            icon: const Icon(Icons.cancel)),
                                    readOnly: true,
                                    enabled: !isExpandedTriper),
                                DropdownGlobalOutline(
                                    labeltext: 'เลือกจุดหมาย',
                                    value: provinceId,
                                    items: provinceList.map((e) {
                                      return DropdownMenuItem<String>(
                                        value: e.provinceId.toString(),
                                        child: Container(
                                            width: 58,
                                            constraints: const BoxConstraints(
                                                maxWidth: 150, minWidth: 100),
                                            child: Text(e.provinceNameTh)),
                                        onTap: () {
                                          setState(() {
                                            if (destination.text == "") {
                                              destination.text =
                                                  e.provinceNameTh;
                                            } else {
                                              destination.text =
                                                  "${destination.text}, ${e.provinceNameTh}";
                                            }
                                          });
                                        },
                                      );
                                    }).toList(),
                                    onChanged: isExpandedTriper == true
                                        ? null
                                        : (newValue) async {
                                            setState(() {
                                              destinationList
                                                  .add(newValue.toString());
                                            });
                                          },
                                    validator: null),

                                const Gap(18),
                                TextFormFieldDatepickGlobalWithoutLine(
                                    controller: startDate,
                                    labelText: "วันเริ่มต้น",
                                    validatorless: null,
                                    enable: !isExpandedTriper,
                                    ontap: isExpandedTriper == true
                                        ? null
                                        : () {
                                            selectvalidFromDate(0);
                                          }),
                                const Gap(18),
                                TextFormFieldDatepickGlobalWithoutLine(
                                    controller: endDate,
                                    labelText: "วันสิ้นสุด",
                                    validatorless: null,
                                    enable: !isExpandedTriper,
                                    ontap: isExpandedTriper == true
                                        ? null
                                        : () {
                                            selectvalidFromDate(1);
                                          }),
                                const Gap(18),
                                DropdownGlobalOutline(
                                    labeltext: 'เลือกรถ',
                                    value: carId,
                                    items: carData.map((e) {
                                      return DropdownMenuItem<String>(
                                        value: e.carId.toString(),
                                        child: Container(
                                            width: 58,
                                            constraints: const BoxConstraints(
                                                maxWidth: 250, minWidth: 200),
                                            child: Text(
                                                "${e.carRegistation} ${e.carModel}")),
                                        onTap: () {
                                          setState(() {
                                            carMileage = e.mileageNumber;
                                          });
                                        },
                                      );
                                    }).toList(),
                                    onChanged: isExpandedTriper == true
                                        ? null
                                        : (newValue) {
                                            setState(() {
                                              carId = newValue.toString();
                                            });
                                          },
                                    validator: null),
                                const Gap(18),
                                TextFormFieldGlobalWithOutLine(
                                    controller: description,
                                    labelText: "Description",
                                    hintText: "รายละเอียดทริป",
                                    validatorless: null,
                                    enabled: !isExpandedTriper),
                                // DropdownMenu<ColorLabel>(
                                //   initialSelection: ColorLabel.green,
                                //   controller: colorController,
                                //   // requestFocusOnTap is enabled/disabled by platforms when it is null.
                                //   // On mobile platforms, this is false by default. Setting this to true will
                                //   // trigger focus request on the text field and virtual keyboard will appear
                                //   // afterward. On desktop platforms however, this defaults to true.
                                //   requestFocusOnTap: true,
                                //   label: const Text('Color'),
                                //   onSelected: (ColorLabel? color) {
                                //     setState(() {
                                //       selectedColor = color;
                                //     });
                                //   },
                                //   dropdownMenuEntries: ColorLabel.values
                                //       .map<DropdownMenuEntry<ColorLabel>>(
                                //           (ColorLabel color) {
                                //     return DropdownMenuEntry<ColorLabel>(
                                //       value: color,
                                //       label: color.label,
                                //       enabled: color.label != 'Grey',
                                //       style: MenuItemButton.styleFrom(
                                //         foregroundColor: color.color,
                                //       ),
                                //     );
                                //   }).toList(),
                                // ),
                                Expanded(child: Container()),
                                SizedBox(
                                  height: 34,
                                  width: 80,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: isExpandedTriper
                                              ? Colors.greenAccent
                                              : mythemecolor,
                                          padding: const EdgeInsets.all(1),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                      onPressed: carId == null ||
                                              tripTypesId == null
                                          ? null
                                          : widget.statusType == "on-trip"
                                              ? null
                                              : () {
                                                  setState(() {
                                                    if (isExpandedTriper ==
                                                        false) {
                                                      if (widget.statusType ==
                                                              "prepare" &&
                                                          carId == checkcarId) {
                                                        isExpandedTriper =
                                                            !isExpandedTriper;
                                                      } else {
                                                        checkCar(
                                                            carId!,
                                                            startDate.text,
                                                            endDate.text);
                                                      }
                                                    } else {
                                                      isExpandedTriper =
                                                          !isExpandedTriper;
                                                    }
                                                  });
                                                },
                                      child: isExpandedTriper
                                          ? Transform.flip(
                                              flipX: true,
                                              child: const Icon(
                                                  Icons.redo_sharp,
                                                  color: Colors.black87),
                                            )
                                          : const Text("Submit")),
                                ),
                                const Gap(18),
                              ],
                            ),
                            if (isExpandedTriper)
                              const Center(
                                  child: Icon(
                                Icons.lock,
                                color: Color.fromARGB(195, 158, 158, 158),
                                size: 200,
                              ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  //triper details
                  Expanded(
                    flex: 8,
                    child: isExpandedTriper == false
                        ? Container()
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Card(
                                      color: mygreycolors,
                                      elevation: 0,
                                      shape: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                              color: Colors.black26, width: 2)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 12),
                                        child: SingleChildScrollView(
                                          child:
                                              BlocBuilder<TripBloc, TripState>(
                                            builder: (context, state) {
                                              EmployeeDatum? e =
                                                  state.employeeData;
                                              if (e != null) {
                                                employeeId = e.employeeId;
                                                name.text =
                                                    "${e.personData.fisrtNameTh} ${e.personData.lastNameTh}";
                                                department.text = e
                                                    .positionData
                                                    .organizationData
                                                    .departMentData
                                                    .deptNameTh;
                                                position.text = e
                                                    .positionData
                                                    .positionData
                                                    .positionNameTh;
                                              }
                                              return Column(
                                                // รายละเอียด triper details.
                                                children: [
                                                  SizedBox(
                                                      width: double.infinity,
                                                      child: Card(
                                                          elevation: 2,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        16,
                                                                    vertical:
                                                                        8),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                //รายละเอียดเดินทาง
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      const TextThai(
                                                                          text:
                                                                              "รายละเอียดผู้เดินทาง :"),
                                                                      SizedBox(
                                                                        height:
                                                                            35,
                                                                        child: ElevatedButton(
                                                                            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                                                                            onPressed: widget.statusType == "on-trip"
                                                                                ? null
                                                                                : () {
                                                                                    getEmployeeData();
                                                                                  },
                                                                            child: const TextThai(
                                                                              text: "เลือกพนักงาน",
                                                                            )),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: double
                                                                      .infinity,
                                                                  child: Card(
                                                                    color:
                                                                        mygreycolors,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              20,
                                                                          vertical:
                                                                              12),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Expanded(
                                                                                child: TextFormFieldGlobalWithOutLine(controller: name, labelText: "ชื่อ - นามสกุล", hintText: "", validatorless: null, enabled: false),
                                                                              ),
                                                                              const Gap(12),
                                                                              Expanded(
                                                                                child: TextFormFieldGlobalWithOutLine(controller: department, labelText: "แผนก", hintText: "", validatorless: null, enabled: false),
                                                                              ),
                                                                              const Gap(12),
                                                                              Expanded(
                                                                                child: TextFormFieldGlobalWithOutLine(controller: position, labelText: "ตำแหน่ง", hintText: "", validatorless: null, enabled: false),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const Gap(
                                                                              10),
                                                                          Row(
                                                                            children: [
                                                                              Expanded(
                                                                                child: DropdownGlobalOutline(
                                                                                    labeltext: 'ประเภทผู้เดินทาง',
                                                                                    value: triperTypeId,
                                                                                    items: triperTypeList.map((e) {
                                                                                      return DropdownMenuItem<String>(
                                                                                        value: e.triperTypeId.toString(),
                                                                                        child: Container(width: 58, constraints: const BoxConstraints(maxWidth: 150, minWidth: 100), child: Text(e.triperTypeName)),
                                                                                        onTap: () {
                                                                                          setState(() {
                                                                                            triperTypeName = e.triperTypeName.toString();
                                                                                          });
                                                                                        },
                                                                                      );
                                                                                    }).toList(),
                                                                                    onChanged: (newValue) {
                                                                                      setState(() {
                                                                                        triperTypeId = newValue.toString();
                                                                                      });
                                                                                    },
                                                                                    validator: null),
                                                                              ),
                                                                              const Gap(12),
                                                                              Expanded(
                                                                                child: TextFormFieldDatepickGlobalWithoutLine(
                                                                                    controller: memberStartDate,
                                                                                    labelText: "วันเริ่มต้น",
                                                                                    validatorless: null,
                                                                                    ontap: () {
                                                                                      if (widget.type == 1) {
                                                                                        setState(() {
                                                                                          selectvalidFromMemberDate(0);
                                                                                        });
                                                                                      }
                                                                                    }),
                                                                              ),
                                                                              const Gap(12),
                                                                              Expanded(
                                                                                child: TextFormFieldDatepickGlobalWithoutLine(
                                                                                    controller: memberEndDate,
                                                                                    labelText: "วันสิ้นสุด",
                                                                                    validatorless: null,
                                                                                    ontap: () {
                                                                                      if (widget.type == 1) {
                                                                                        setState(() {
                                                                                          selectvalidFromMemberDate(1);
                                                                                        });
                                                                                      }
                                                                                    }),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const Gap(5),
                                                                const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8.0),
                                                                  child: TextThai(
                                                                      text:
                                                                          "ค่าใช้จ่าย :"),
                                                                ),
                                                                SizedBox(
                                                                  width: double
                                                                      .infinity,
                                                                  child: Card(
                                                                    color:
                                                                        mygreycolors,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              20,
                                                                          vertical:
                                                                              12),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Checkbox(
                                                                            activeColor:
                                                                                mythemecolor,
                                                                            value:
                                                                                isCheckedAllowance,
                                                                            onChanged:
                                                                                (bool? value) {
                                                                              setState(() {
                                                                                isCheckedAllowance = value!;
                                                                                if (isCheckedAllowance == false) {
                                                                                  // //allowance
                                                                                  // membercost.add(Expenditure(expenditureTypeId: "00", cost: "300", description: "ค่าเบี้ยเลี้ยง"));

                                                                                  membercost.removeWhere((element) => element.expenditureTypeId == "00");
                                                                                }
                                                                              });
                                                                            },
                                                                          ),
                                                                          const TextThai(
                                                                              text: "ค่าเบี้ยเลี้ยง"),
                                                                          const Gap(
                                                                              5),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child: TextFormFieldGlobalWithOutLine(
                                                                                controller: costAllowance,
                                                                                inputFormatters: [
                                                                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                                                ],
                                                                                labelText: "ค่าเบี้ยเลี้ยง",
                                                                                hintText: "",
                                                                                validatorless: null,
                                                                                enabled: isCheckedAllowance),
                                                                          ),
                                                                          const Gap(
                                                                              5),
                                                                          Checkbox(
                                                                            activeColor:
                                                                                mythemecolor,
                                                                            value:
                                                                                isCheckedGasoline,
                                                                            onChanged:
                                                                                (bool? value) {
                                                                              setState(() {
                                                                                isCheckedGasoline = value!;
                                                                                if (isCheckedGasoline == false) {
                                                                                  //remove
                                                                                  membercost.removeWhere((element) => element.expenditureTypeId == "02");
                                                                                  descGasoline.text = "";
                                                                                }
                                                                              });
                                                                            },
                                                                          ),
                                                                          const TextThai(
                                                                              text: "ค่าน้ำมัน"),
                                                                          const Gap(
                                                                              5),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child: TextFormFieldGlobalWithOutLine(
                                                                                controller: descGasoline,
                                                                                inputFormatters: [
                                                                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                                                ],
                                                                                labelText: "ค่าน้ำมัน",
                                                                                hintText: "",
                                                                                validatorless: null,
                                                                                enabled: isCheckedGasoline),
                                                                          ),
                                                                          const Gap(
                                                                              5),
                                                                          Checkbox(
                                                                            activeColor:
                                                                                mythemecolor,
                                                                            value:
                                                                                isCheckedHotel,
                                                                            onChanged:
                                                                                (bool? value) {
                                                                              setState(() {
                                                                                isCheckedHotel = value!;
                                                                                if (isCheckedHotel == false) {
                                                                                  //remove
                                                                                  membercost.removeWhere((element) => element.expenditureTypeId == "01");
                                                                                }
                                                                              });
                                                                            },
                                                                          ),
                                                                          const TextThai(
                                                                              text: "ค่าที่พัก"),
                                                                          const Gap(
                                                                              5),
                                                                          Expanded(
                                                                            flex:
                                                                                3,
                                                                            child: DropdownGlobalOutline(
                                                                                labeltext: 'เลือกที่พัก',
                                                                                value: hostelName,
                                                                                items: isCheckedHotel
                                                                                    ? hostelList.map((e) {
                                                                                        return DropdownMenuItem<String>(
                                                                                          value: e.hotelName.toString(),
                                                                                          child: Container(constraints: const BoxConstraints(maxWidth: 130, minWidth: 80), child: Text(e.hotelName)),
                                                                                          onTap: () {
                                                                                            setState(() {
                                                                                              hostelName = e.hotelName;
                                                                                              hotelCost = e.price;
                                                                                              hostelId = e.hotelId;
                                                                                            });
                                                                                          },
                                                                                        );
                                                                                      }).toList()
                                                                                    : null,
                                                                                onChanged: (newValue) async {
                                                                                  setState(() {
                                                                                    hostelName = newValue.toString();
                                                                                  });
                                                                                },
                                                                                validator: null),
                                                                          ),
                                                                          const Gap(
                                                                              5),
                                                                          Checkbox(
                                                                            activeColor:
                                                                                mythemecolor,
                                                                            value:
                                                                                isCheckedOther,
                                                                            onChanged:
                                                                                (bool? value) {
                                                                              setState(() {
                                                                                isCheckedOther = value!;
                                                                                if (isCheckedOther == false) {
                                                                                  //remove
                                                                                  membercost.removeWhere((element) => element.expenditureTypeId == "03");
                                                                                  descOther.text == "";
                                                                                }
                                                                              });
                                                                            },
                                                                          ),
                                                                          const TextThai(
                                                                              text: "อื่น ๆ"),
                                                                          const Gap(
                                                                              5),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child: TextFormFieldGlobalWithOutLine(
                                                                                controller: costOther,
                                                                                inputFormatters: [
                                                                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                                                ],
                                                                                labelText: "จำนวนเงิน",
                                                                                hintText: "",
                                                                                validatorless: null,
                                                                                enabled: isCheckedOther),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                3,
                                                                            child: TextFormFieldGlobalWithOutLine(
                                                                                controller: descOther,
                                                                                labelText: "รายละเอียด",
                                                                                hintText: "",
                                                                                validatorless: null,
                                                                                enabled: isCheckedOther),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(),
                                                                    widget.type ==
                                                                            1
                                                                        ? Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(4.0),
                                                                            child:
                                                                                SizedBox(
                                                                              width: 160,
                                                                              height: 32,
                                                                              child: ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                                                                                onPressed: widget.statusType == "on-trip"
                                                                                    ? null
                                                                                    : () {
                                                                                        setState(() {
                                                                                          editCostMembertrip();
                                                                                        });
                                                                                      },
                                                                                child: const TextThai(text: "เพิ่ม / แก้ไข", textStyle: TextStyle(color: Colors.black)),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : MySaveButtons(
                                                                            text:
                                                                                "+ Add",
                                                                            onPressed: name.text == "" ||
                                                                                    // tripTypesId == "" ||
                                                                                    startDate.text == "" ||
                                                                                    endDate.text == ""
                                                                                ? null
                                                                                : () {
                                                                                    setState(() {
                                                                                      //add member
                                                                                      addCostMembertrip();
                                                                                      addTriper();
                                                                                    });
                                                                                  },
                                                                          ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ))),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    //
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 0),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: widget.type == 0
                                            ? ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: members.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 2),
                                                    child: Card(
                                                      elevation: 2,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: ExpansionTile(
                                                          // leading: Icon(Icons
                                                          //     .personal_injury_outlined),
                                                          title: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              TextThai(
                                                                text:
                                                                    "${members[index].triptypeName} | ชื่อ : ${members[index].name} | แผนก : ${members[index].departmen} | ตำแหน่ง : ${members[index].position} |",
                                                              ),
                                                              RowDeleteBox(
                                                                  onPressed:
                                                                      () {
                                                                setState(() {
                                                                  tripers.removeWhere((element) =>
                                                                      element
                                                                          .employeeId ==
                                                                      members[index]
                                                                          .employeeId);
                                                                  members.removeWhere((element) =>
                                                                      element
                                                                          .employeeId ==
                                                                      members[index]
                                                                          .employeeId);
                                                                });
                                                              })
                                                            ],
                                                          ),
                                                          children: [
                                                            Container(
                                                              color:
                                                                  mygreycolors,
                                                              child: ListTile(
                                                                leading:
                                                                    const TextThai(
                                                                  text:
                                                                      "สรุปค่าใช้จ่าย",
                                                                ),
                                                                title:
                                                                    TitleExpanded(
                                                                  members:
                                                                      members,
                                                                  index: index,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                })
                                            : ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    editTriperList.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 2),
                                                    child: Card(
                                                      elevation: 2,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: ExpansionTile(
                                                          // leading: Icon(Icons
                                                          //     .personal_injury_outlined),
                                                          title: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              TextThai(
                                                                text:
                                                                    "${editTriperList[index].triperTypeData.triperTypeName}  |  ชื่อ : ${editTriperList[index].employeeData.firstNameTh} ${editTriperList[index].employeeData.lastNameTh}  |  แผนก : ${editTriperList[index].organization.organizationName}  | ตำแหน่ง : ${editTriperList[index].position.positionOrganizationName}",
                                                              ),
                                                              Row(
                                                                children: [
                                                                  if (widget
                                                                          .statusType ==
                                                                      "on-trip")
                                                                    SizedBox(
                                                                      width: 40,
                                                                      height:
                                                                          38,
                                                                      child:
                                                                          ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            backgroundColor:
                                                                                Colors.lightBlue,
                                                                            padding: const EdgeInsets.all(1)),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            moveTriperDialog(editTriperList[index]);
                                                                          });
                                                                        },
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .repeat_rounded,
                                                                          size:
                                                                              22,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  const Gap(5),
                                                                  if (widget
                                                                          .statusType ==
                                                                      "prepare")
                                                                    SizedBox(
                                                                      width: 40,
                                                                      height:
                                                                          38,
                                                                      child:
                                                                          ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            padding:
                                                                                const EdgeInsets.all(1)),
                                                                        child: const Icon(
                                                                            Icons.edit),
                                                                        onPressed:
                                                                            () {
                                                                          name.text =
                                                                              "${editTriperList[index].employeeData.firstNameTh} ${editTriperList[index].employeeData.lastNameTh}";
                                                                          department.text = editTriperList[index]
                                                                              .organization
                                                                              .organizationName;
                                                                          position.text = editTriperList[index]
                                                                              .position
                                                                              .positionOrganizationName;
                                                                          memberStartDate.text =
                                                                              editTriperList[index].startDate;
                                                                          memberEndDate.text =
                                                                              editTriperList[index].endDate;
                                                                          List<Expendition> allowance = editTriperList[index]
                                                                              .expendition
                                                                              .where((element) => element.expenditureTypeId == "00")
                                                                              .toList();
                                                                          List<Expendition> hotel = editTriperList[index]
                                                                              .expendition
                                                                              .where((element) => element.expenditureTypeId == "01")
                                                                              .toList();
                                                                          List<Expendition> gas = editTriperList[index]
                                                                              .expendition
                                                                              .where((element) => element.expenditureTypeId == "02")
                                                                              .toList();
                                                                          List<Expendition> other = editTriperList[index]
                                                                              .expendition
                                                                              .where((element) => element.expenditureTypeId == "03")
                                                                              .toList();

                                                                          setState(
                                                                              () {
                                                                            employeeId =
                                                                                editTriperList[index].employeeId;
                                                                            triperTypeId =
                                                                                editTriperList[index].triperTypeData.triperTypeId;
                                                                            isCheckedAllowance = allowance.isEmpty
                                                                                ? false
                                                                                : true;

                                                                            //hostelId
                                                                            hostelName =
                                                                                hotel[0].description;
                                                                            isCheckedGasoline = gas.isEmpty
                                                                                ? false
                                                                                : true;

                                                                            isCheckedHotel = hotel.isEmpty
                                                                                ? false
                                                                                : true;
                                                                            isCheckedOther = other.isEmpty
                                                                                ? false
                                                                                : true;
                                                                            costAllowance.text = allowance.isEmpty
                                                                                ? ""
                                                                                : allowance[0].cost;
                                                                            descGasoline.text = gas.isEmpty
                                                                                ? ""
                                                                                : gas[0].cost;
                                                                            descOther.text = other.isEmpty
                                                                                ? ""
                                                                                : other[0].description;
                                                                            costOther.text = other.isEmpty
                                                                                ? ""
                                                                                : other[0].cost;
                                                                          });
                                                                        },
                                                                      ),
                                                                    ),
                                                                  const Gap(5),
                                                                  if (widget
                                                                          .statusType !=
                                                                      "on-trip")
                                                                    RowDeleteBox(
                                                                        onPressed:
                                                                            () {
                                                                      setState(
                                                                          () {
                                                                        editTriperList.removeWhere((element) =>
                                                                            element.employeeId ==
                                                                            editTriperList[index].employeeId);
                                                                      });
                                                                    }),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          children: [
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      172,
                                                                      210,
                                                                      226,
                                                                      255),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8)),
                                                              child: ListTile(
                                                                leading:
                                                                    const TextThai(
                                                                  text:
                                                                      "สรุปค่าใช้จ่าย",
                                                                ),
                                                                title:
                                                                    TitleExpandedEdit(
                                                                  editTriperList:
                                                                      editTriperList,
                                                                  index: index,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                      ),
                                    ),
                                  ],
                                ),
                                if (tripers.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextThai(
                                              text:
                                                  "ผู้ร่วมทริปทั้งหมด  ${tripers.length}  คน"),
                                          const Gap(10),
                                          SizedBox(
                                            width: 200,
                                            height: 35,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6))),
                                              onPressed: tripers
                                                      .where((element) =>
                                                          element
                                                              .triperTypeId ==
                                                          "001")
                                                      .isEmpty
                                                  ? null
                                                  : () {
                                                      setState(() {
                                                        createmodel();
                                                      });
                                                    },
                                              child: const TextThai(
                                                  text: "สร้างทริป"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (editTriperList.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextThai(
                                              text:
                                                  "ผู้ร่วมทริปทั้งหมด  ${editTriperList.length}  คน"),
                                          const Gap(10),
                                          SizedBox(
                                            width: 200,
                                            height: 35,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6))),
                                              onPressed: editTriperList
                                                      .where((element) =>
                                                          element.triperTypeData
                                                              .triperTypeId ==
                                                          "001")
                                                      .isEmpty
                                                  ? null
                                                  : () {
                                                      setState(() {
                                                        updateTrip();
                                                      });
                                                    },
                                              child: const TextThai(
                                                  text: "บันทึกการเปลี่ยนแปลง"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                  ),
                ],
              ));
  }
}

class TitleExpanded extends StatelessWidget {
  const TitleExpanded({
    super.key,
    required this.members,
    required this.index,
  });

  final List<MemberTrip> members;
  final int index;

  @override
  Widget build(BuildContext context) {
    List<Expenditure> hotel = members[index]
        .cost
        .where((element) => element.expenditureTypeId == "01")
        .toList();
    List<Expenditure> gas = members[index]
        .cost
        .where((element) => element.expenditureTypeId == "02")
        .toList();
    List<Expenditure> other = members[index]
        .cost
        .where((element) => element.expenditureTypeId == "03")
        .toList();
    return Row(
      children: [
        Icon(
          members[index]
                  .cost
                  .where((element) => element.expenditureTypeId == "00")
                  .isNotEmpty
              ? Icons.check_box_rounded
              : Icons.check_box_outline_blank_rounded,
          color: mythemecolor,
        ),
        const Gap(5),
        const TextThai(
          text: "ค่าเบี้ยเลี้ยง",
        ),
        const Gap(15),
        Icon(
          members[index]
                  .cost
                  .where((element) => element.expenditureTypeId == "02")
                  .isNotEmpty
              ? Icons.check_box_rounded
              : Icons.check_box_outline_blank_rounded,
          color: mythemecolor,
        ),
        const Gap(5),
        const TextThai(
          text: "ค่าน้ำมัน",
        ),
        const Gap(5),
        TextThai(
            text: members[index]
                    .cost
                    .where((element) => element.expenditureTypeId == "02")
                    .isNotEmpty
                ? ": ${gas[0].cost} บาท"
                : ""),
        const Gap(10),
        Icon(
          members[index]
                  .cost
                  .where((element) => element.expenditureTypeId == "01")
                  .isNotEmpty
              ? Icons.check_box_rounded
              : Icons.check_box_outline_blank_rounded,
          color: mythemecolor,
        ),
        const Gap(5),
        const TextThai(
          text: "ค่าที่พัก",
        ),
        const Gap(5),
        TextThai(
            text: members[index]
                    .cost
                    .where((element) => element.expenditureTypeId == "01")
                    .isNotEmpty
                ? ": ${hotel[0].cost} บาท"
                : ""),
        const Gap(10),
        Icon(
          members[index]
                  .cost
                  .where((element) => element.expenditureTypeId == "03")
                  .isNotEmpty
              ? Icons.check_box_rounded
              : Icons.check_box_outline_blank_rounded,
          color: mythemecolor,
        ),
        const Gap(5),
        const TextThai(
          text: "อื่น ๆ",
        ),
        const Gap(5),
        TextThai(
            text: members[index]
                    .cost
                    .where((element) => element.expenditureTypeId == "03")
                    .isNotEmpty
                ? ": ${other[0].description}  ${other[0].cost} บาท"
                : ""),
      ],
    );
  }
}

class TitleExpandedEdit extends StatelessWidget {
  const TitleExpandedEdit({
    super.key,
    required this.editTriperList,
    required this.index,
  });

  final List<TriperDatum> editTriperList;
  final int index;

  @override
  Widget build(BuildContext context) {
    List<Expendition> hotel = editTriperList[index]
        .expendition
        .where((element) => element.expenditureTypeId == "01")
        .toList();
    List<Expendition> gas = editTriperList[index]
        .expendition
        .where((element) => element.expenditureTypeId == "02")
        .toList();
    List<Expendition> other = editTriperList[index]
        .expendition
        .where((element) => element.expenditureTypeId == "03")
        .toList();
    return Row(
      children: [
        Icon(
          editTriperList[index]
                  .expendition
                  .where((element) => element.expenditureTypeId == "00")
                  .isNotEmpty
              ? Icons.check_box_rounded
              : Icons.check_box_outline_blank_rounded,
          color: mythemecolor,
        ),
        const Gap(5),
        const TextThai(
          text: "ค่าเบี้ยเลี้ยง",
        ),
        const Gap(15),
        Icon(
          editTriperList[index]
                  .expendition
                  .where((element) => element.expenditureTypeId == "02")
                  .isNotEmpty
              ? Icons.check_box_rounded
              : Icons.check_box_outline_blank_rounded,
          color: mythemecolor,
        ),
        const Gap(5),
        const TextThai(
          text: "ค่าน้ำมัน",
        ),
        const Gap(5),
        TextThai(
            text: editTriperList[index]
                    .expendition
                    .where((element) => element.expenditureTypeId == "02")
                    .isNotEmpty
                ? ": ${gas[0].cost} บาท"
                : ""),
        const Gap(10),
        Icon(
          editTriperList[index]
                  .expendition
                  .where((element) => element.expenditureTypeId == "01")
                  .isNotEmpty
              ? Icons.check_box_rounded
              : Icons.check_box_outline_blank_rounded,
          color: mythemecolor,
        ),
        const Gap(5),
        const TextThai(
          text: "ค่าที่พัก",
        ),
        const Gap(5),
        TextThai(
            text: editTriperList[index]
                    .expendition
                    .where((element) => element.expenditureTypeId == "01")
                    .isNotEmpty
                ? ": ${hotel[0].cost} บาท"
                : ""),
        const Gap(10),
        Icon(
          editTriperList[index]
                  .expendition
                  .where((element) => element.expenditureTypeId == "03")
                  .isNotEmpty
              ? Icons.check_box_rounded
              : Icons.check_box_outline_blank_rounded,
          color: mythemecolor,
        ),
        const Gap(5),
        const TextThai(
          text: "อื่น ๆ",
        ),
        const Gap(5),
        TextThai(
            text: editTriperList[index]
                    .expendition
                    .where((element) => element.expenditureTypeId == "03")
                    .isNotEmpty
                ? ": ${other[0].description}  ${other[0].cost} บาท"
                : ""),
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

class MemberTrip {
  final String employeeId;
  final String name;
  final String departmen;
  final String position;
  final String triptypeName;
  final String startDate;
  final String endDate;
  final List<Expenditure> cost;
  MemberTrip({
    required this.employeeId,
    required this.name,
    required this.departmen,
    required this.position,
    required this.triptypeName,
    required this.startDate,
    required this.endDate,
    required this.cost,
  });
}
