import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/trip/cars/cars_datatable.dart';
import 'package:hris_app_prototype/src/component/trip/hotel/hotel_datatable.dart';
import 'package:hris_app_prototype/src/component/trip/trip/trip_datatable.dart';

class OffSideLayout extends StatefulWidget {
  const OffSideLayout({super.key});

  @override
  State<OffSideLayout> createState() => _OffSideLayoutState();
}

class _OffSideLayoutState extends State<OffSideLayout> {
  int isExpandedPage = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Gap(12),
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(child: Container()),
                  Expanded(
                    child: SizedBox(
                      height: 35,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: isExpandedPage == 0 ? 2 : 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(10))),
                            backgroundColor: isExpandedPage == 0
                                ? mythemecolor
                                : Colors.grey[350],
                          ),
                          onPressed: () {
                            setState(() {
                              isExpandedPage = 0;
                            });
                          },
                          child: Text(
                            "Trips management.",
                            style: TextStyle(
                                color: isExpandedPage == 0
                                    ? Colors.white
                                    : Colors.black54),
                          )),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 35,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: isExpandedPage == 1 ? 2 : 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(0))),
                            backgroundColor: isExpandedPage == 1
                                ? mythemecolor
                                : Colors.grey[350],
                          ),
                          onPressed: () {
                            setState(() {
                              isExpandedPage = 1;
                            });
                          },
                          child: Text(
                            "Cars management.",
                            style: TextStyle(
                                color: isExpandedPage == 1
                                    ? Colors.white
                                    : Colors.black54),
                          )),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 35,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: isExpandedPage == 2 ? 2 : 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(10))),
                            backgroundColor: isExpandedPage == 2
                                ? mythemecolor
                                : Colors.grey[350],
                          ),
                          onPressed: () {
                            setState(() {
                              isExpandedPage = 2;
                            });
                          },
                          child: Text(
                            "Hotels management.",
                            style: TextStyle(
                                color: isExpandedPage == 2
                                    ? Colors.white
                                    : Colors.black54),
                          )),
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              )),
          if (isExpandedPage == 0)
            const Expanded(flex: 19, child: TripDatatable())
          else if (isExpandedPage == 1)
            const Expanded(flex: 19, child: CarDatatable())
          else
            const Expanded(flex: 19, child: HotelDatatable())
        ],
      ),
    );
  }
}
