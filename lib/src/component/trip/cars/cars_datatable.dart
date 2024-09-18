// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_app_prototype/src/bloc/trip_bloc/trip_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/component/trip/cars/create_update_cars.dart';
import 'package:hris_app_prototype/src/model/trip/cars/cars_model.dart';

class CarDatatable extends StatefulWidget {
  const CarDatatable({super.key});

  @override
  State<CarDatatable> createState() => _CarDatatableState();
}

class _CarDatatableState extends State<CarDatatable> {
  //table
  int rowIndex = 10;
  int? sortColumnIndex;
  bool sort = true;
  TextEditingController search = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
// data
  List<CarDatum>? carsData;
  List<CarDatum> filterData = [];

  showDialogCar(int type) {
    //type 0 = create , type 1 = update
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: mygreycolors,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: TitleDialog(
              title: "Create Car.",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            content: SizedBox(
              width: 420,
              height: 320,
              child: CreateUpdateCars(
                type: type,
              ),
            ),
          );
        });
  }

  Future fetchCarsData() async {
    // CarsModel? data = await ApiTripService.getCarsData();
    // setState(() {
    //   carsData = data?.carData;
    // });
    context.read<TripBloc>().add(GetAllCarDataEvents());
  }

  @override
  void initState() {
    super.initState();
    fetchCarsData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        child: Scaffold(
          body: BlocBuilder<TripBloc, TripState>(
            builder: (context, state) {
              if (state.onSearchCarData == false || carsData == null) {
                carsData = state.carsDataModel?.carData ?? [];
                filterData = state.carsDataModel?.carData ?? [];
              } else {}
              return state.isCarDataLoading == true
                  ? myLoadingScreen
                  : SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: PaginatedDataTable(
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Car Table.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800),
                                    ),
                                    SizedBox(
                                      width: 300,
                                      height: 42,
                                      child: TextFormFieldSearch(
                                        controller: search,
                                        onChanged: (value) {
                                          if (value == '') {
                                            context
                                                .read<TripBloc>()
                                                .add(DissSearchCarEvent());
                                          } else {
                                            setState(() {
                                              context
                                                  .read<TripBloc>()
                                                  .add(SearchCarEvent());
                                              carsData =
                                                  filterData.where((element) {
                                                final number = element
                                                    .carRegistation
                                                    .toLowerCase()
                                                    .contains(
                                                        value.toLowerCase());
                                                final brand = element.carBrand
                                                    .toLowerCase()
                                                    .contains(
                                                        value.toLowerCase());
                                                final model = element.carModel
                                                    .toLowerCase()
                                                    .contains(
                                                        value.toLowerCase());
                                                final carType = element
                                                    .carTypeData.carName
                                                    .toLowerCase()
                                                    .contains(
                                                        value.toLowerCase());
                                                final description = element
                                                    .carColor
                                                    .toLowerCase()
                                                    .contains(
                                                        value.toLowerCase());

                                                return number ||
                                                    brand ||
                                                    model ||
                                                    carType ||
                                                    description;
                                              }).toList();
                                            });
                                          }
                                        },
                                        enabled: true,
                                      ),
                                    )
                                  ],
                                ),
                                actions: [
                                  MyFloatingButton(
                                    icon: const Icon(
                                      Icons.add,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      showDialogCar(0);
                                    },
                                  ),
                                ],
                                columnSpacing: 30,
                                showFirstLastButtons: true,
                                rowsPerPage: rowIndex,
                                availableRowsPerPage: const [5, 10, 20],
                                sortColumnIndex: sortColumnIndex,
                                sortAscending: sort,
                                onRowsPerPageChanged: (value) {
                                  setState(() {
                                    rowIndex = value!;
                                  });
                                },
                                columns: [
                                  DataColumn(label: textThai("ทะเบียนรถ")),
                                  DataColumn(label: textThai("ยี่ห้อ/รุ่น")),
                                  DataColumn(label: textThai("ประเภทรถ")),
                                  DataColumn(label: textThai("เลขไมล์ (กม.)")),
                                  DataColumn(label: textThai("รายละเอียดรถ")),
                                  DataColumn(label: textThai("สถานะ")),
                                  DataColumn(label: textThai("การจัดการ")),
                                ],
                                source: DataTable(
                                    context: context, carsData: carsData)),
                          ),
                        ),
                      ),
                    );
            },
          ),
        ));
  }

  Widget textThai(String text) {
    return TextThai(
      textStyle: const TextStyle(fontWeight: FontWeight.w500),
      text: text,
    );
  }
}

class DataTable extends DataTableSource {
  final BuildContext context;
  final List<CarDatum>? carsData;
  DataTable({
    required this.context,
    required this.carsData,
  });
  //test data
  List<TestSource> data = [
    TestSource(
        carId: "2กก 678",
        brand: "Toyota",
        model: "Revo",
        type: "นั่งสองตอนท้ายบรรทุก",
        mile: "150000",
        description: "มีหลังคาเสริม",
        status: "ว่าง"),
    TestSource(
        carId: "3กก 168",
        brand: "Toyota",
        model: "Revo",
        type: "นั่งสองตอนท้ายบรรทุก",
        mile: "150000",
        description: "ผ้าใบปิดท้าย",
        status: "ใช้งาน"),
    TestSource(
        carId: "4กก 328",
        brand: "Honda",
        model: "Hrv",
        type: "นั่งสองตอน",
        mile: "50000",
        description: "ใช้สำหรับผู้บริหาร",
        status: "ซ่อมบำรุง"),
    TestSource(
        carId: "4ก 6996",
        brand: "Isuzu",
        model: "Hrv",
        type: "นั่งสองตอน",
        mile: "10000",
        description: "",
        status: "เพิกถอน"),
  ];

  @override
  DataRow getRow(int index) {
    // final datarow = data[index];
    final datacar = carsData![index];
    return DataRow(
        color:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          return index % 2 == 0 ? Colors.white : myrowscolors;
        }),
        cells: [
          DataCell(Text(datacar.carRegistation)),
          DataCell(Text("${datacar.carBrand} / ${datacar.carModel}")),
          DataCell(Text(datacar.carTypeData.carName)),
          DataCell(Text(datacar.mileageNumber)),
          DataCell(Text(datacar.carColor)),
          DataCell(
            SizedBox(
              height: 40,
              width: 80,
              child: Card(
                  elevation: 2,
                  color: datacar.carStatus == "1"
                      ? mythemecolor
                      : datacar.carStatus == "0"
                          ? null
                          : datacar.carStatus == "2"
                              ? Colors.amberAccent
                              : Colors.red[800],
                  shape: datacar.carStatus == "0"
                      ? OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: mygreencolors),
                          borderRadius: BorderRadius.circular(6))
                      : RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Center(
                      child: Text(
                        datacar.carStatus == "0"
                            ? "ว่าง"
                            : datacar.carStatus == "1"
                                ? "ร่วมทริป"
                                : datacar.carStatus == "2"
                                    ? "ซ่อมบำรุง"
                                    : "เพิกถอน",
                        style: TextStyle(
                            color: datacar.carStatus == "3" ||
                                    datacar.carStatus == "1"
                                ? Colors.white
                                : Colors.grey[800]),
                      ),
                    ),
                  )),
            ),
          ),
          DataCell(datacar.carStatus == "" //
              ? Container()
              : SizedBox(
                  height: 32,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: myambercolors,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: const Icon(Icons.edit_rounded),
                    onPressed: () {
                      showDialogCar(1, datacar);
                    },
                  ),
                )),
        ]);
  }

  @override
  int get rowCount => carsData!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;

  //functions
  showDialogCar(int type, CarDatum carData) {
    //type 0 = create , type 1 = update
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: mygreycolors,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: TitleDialog(
              title: "Edit Car.",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            content: SizedBox(
              width: 420,
              height: 320,
              child: CreateUpdateCars(
                type: type,
                carData: carData,
              ),
            ),
          );
        });
  }
}

class TestSource {
  final String carId;
  final String brand;
  final String model;
  final String type;
  final String mile;
  final String description;
  final String status;
  TestSource({
    required this.carId,
    required this.brand,
    required this.model,
    required this.type,
    required this.mile,
    required this.description,
    required this.status,
  });
}
