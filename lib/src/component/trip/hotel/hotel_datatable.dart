import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_app_prototype/src/bloc/trip_bloc/trip_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/component/trip/hotel/create_update_hotel.dart';
import 'package:hris_app_prototype/src/model/trip/hotels/hotel_data_all_model.dart';

class HotelDatatable extends StatefulWidget {
  const HotelDatatable({super.key});

  @override
  State<HotelDatatable> createState() => _HotelDatatableState();
}

class _HotelDatatableState extends State<HotelDatatable> {
  //table
  int rowIndex = 10;
  int? sortColumnIndex;
  bool sort = true;
  TextEditingController search = TextEditingController();

//data
  List<HotelDatum> hotelData = [];
  List<HotelDatum> filterData = [];
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
              title: "Create Hotel.",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            content: SizedBox(
              width: 420,
              height: 260,
              child: CreateUpdateHotels(
                type: type,
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    context.read<TripBloc>().add(GetAllHotelDataEvents());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        child: Scaffold(
          body: BlocBuilder<TripBloc, TripState>(
            builder: (context, state) {
              if (state.onSearchHotelData == false || hotelData == []) {
                hotelData = state.hotelDataModel?.hotelData ?? [];
                filterData = state.hotelDataModel?.hotelData ?? [];
              } else {}
              return state.isHotelDataLoading == true
                  ? myLoadingScreen
                  : SizedBox(
                      height: double.infinity,
                      width: double.infinity,
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
                                      "Hotel Table.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800),
                                    ),
                                    SizedBox(
                                      width: 300,
                                      height: 42,
                                      child: TextFormFieldSearch(
                                        controller: search,
                                        onChanged: (value) {},
                                        enabled: true,
                                      ),
                                    )
                                  ],
                                ),
                                actions: [
                                  Tooltip(
                                    message: 'Create Hotel',
                                    child: MyFloatingButton(
                                      icon: const Icon(
                                        Icons.add,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        showDialogCar(0);
                                      },
                                    ),
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
                                  DataColumn(label: textThai("ประเภทที่พัก")),
                                  DataColumn(label: textThai("จังหวัด")),
                                  DataColumn(label: textThai("ชื่อที่พัก")),
                                  DataColumn(label: textThai("ราคาห้องพัก")),
                                  DataColumn(label: textThai("รายละเอียด")),
                                  DataColumn(label: textThai("สถานะ")),
                                  DataColumn(label: textThai("การจัดการ")),
                                ],
                                source: DataTable(
                                    context: context, hotelData: hotelData)),
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
  final List<HotelDatum> hotelData;
  DataTable({
    required this.context,
    required this.hotelData,
  });
  //test data
  List<TestSource> data = [
    TestSource(
        name: "Hotel A",
        price: "800",
        address: "ต.ห้วยทราย อ.แม่ริม จ.เชียงใหม่ 50180",
        description: "",
        status: "Active"),
    TestSource(
        name: "Hotel B",
        price: "850",
        address: "ต.ห้วยทราย อ.แม่ริม จ.เชียงใหม่ 50180",
        description: "",
        status: "Active"),
    TestSource(
        name: "Hotel C",
        price: "700",
        address: "ต.ห้วยทราย อ.แม่ริม จ.เชียงใหม่ 50180",
        description: "มีกุ๊กกู๋ ห้อง 102",
        status: "Inactive"),
  ];

//functions
  showDialogCar(int type, HotelDatum hoteldata) {
    // type 0 = create , type 1 = update
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: mygreycolors,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: TitleDialog(
              title: "Edit Hotel.",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            content: SizedBox(
              width: 420,
              height: 260,
              child: CreateUpdateHotels(
                type: type,
                hoteldata: hoteldata,
              ),
            ),
          );
        });
  }

  @override
  DataRow getRow(int index) {
    // final row = data[index];
    final datarow = hotelData[index];
    return DataRow(
        color:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          return index % 2 == 0 ? Colors.white : myrowscolors;
        }),
        cells: [
          DataCell(Text(datarow.hotelType.hotelTypeName)),
          DataCell(Text(datarow.province.provinceNameTh)),
          DataCell(Text(datarow.hotelName)),
          DataCell(Text(datarow.price)),
          DataCell(Text(datarow.hotelDescription == "No data"
              ? ""
              : datarow.hotelDescription)),
          DataCell(
            SizedBox(
              height: 40,
              width: 80,
              child: Card(
                  elevation: 2,
                  color: datarow.status == "Active"
                      ? Colors.greenAccent
                      : Colors.red[800],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Center(
                      child: Text(
                        datarow.status,
                        style: TextStyle(
                            color: datarow.status == "Active"
                                ? Colors.black87
                                : mygreycolors),
                      ),
                    ),
                  )),
            ),
          ),
          DataCell(SizedBox(
            height: 32,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: myambercolors,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              child: const Icon(Icons.edit),
              onPressed: () {
                showDialogCar(1, hotelData[index]);
              },
            ),
          )),
        ]);
  }

  @override
  int get rowCount => hotelData.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class TestSource {
  final String name;
  final String price;
  final String address;
  final String description;
  final String status;
  TestSource({
    required this.name,
    required this.price,
    required this.address,
    required this.description,
    required this.status,
  });
}
