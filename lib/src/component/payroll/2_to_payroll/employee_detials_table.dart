// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/model/payroll/to_payroll/time_record_emp_model.dart';
import 'package:hris_app_prototype/src/model/payroll/to_payroll/time_record_model.dart';
import 'package:hris_app_prototype/src/services/api_payroll_service.dart';

//----------------------------------Main--------------------------------
class EmpDetailTable extends StatefulWidget {
  final TimeRecordDatum empData;
  final String startDate;
  final String finishDate;
  final String wDate;
  const EmpDetailTable({
    Key? key,
    required this.empData,
    required this.startDate,
    required this.finishDate,
    required this.wDate,
  }) : super(key: key);

  @override
  State<EmpDetailTable> createState() => _EmpDetailTableState();
}

class _EmpDetailTableState extends State<EmpDetailTable> {
  bool isLoading = true;
  //table
  bool isDataLoading = false;
  int rowIndex = 31;
  int? sortColumnIndex;
  bool sort = true;
  TextEditingController search = TextEditingController();
  bool onSearch = false;
  List<EmployeeWorkTime> empWtList = [];
  List<EmployeeWorkTime> filterData = [];
//count
  double wHCount = 0;
  double tCount = 0;
  double leaveCount = 0;
  double nOtCount = 0;
  double hOtCount = 0;
  TextEditingController fill0 = TextEditingController();
  TextEditingController fill1 = TextEditingController();
  TextEditingController fill2 = TextEditingController();
  TextEditingController fill3 = TextEditingController();
  TextEditingController fill4 = TextEditingController();
  TextEditingController fill5 = TextEditingController();

  Future fetchData() async {
    TimeRecordEmpModel? data = await ApiPayrollService.getTimeRecordEmp(
        widget.empData.employeeId, widget.startDate, widget.finishDate);
    if (data != null) {
      setState(() {
        empWtList = data.employeeWorkTime;
        isLoading = false;

        for (var e in empWtList) {
          fill0.text = widget.wDate.toString();
          wHCount += double.parse(e.workHoliday ?? "0");
          fill1.text = wHCount.toString();
          tCount += double.parse(e.trip ?? "0");
          fill2.text = tCount.toString();
          leaveCount += double.parse(e.nLeave ?? "0");
          fill3.text = leaveCount.toString();
          nOtCount += double.parse(e.normalOt ?? "0");
          fill4.text = nOtCount.toString();
          hOtCount += double.parse(e.holidayOt ?? "0");
          fill5.text = hOtCount.toString();
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    fetchData();
    fill1.text = leaveCount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TitleDialog(
                title:
                    "Lot number :  ${widget.startDate} - ${widget.finishDate} | Employee Id : ${widget.empData.employeeId} | ${widget.empData.departmentName} | ${widget.empData.staffType} | ${widget.empData.firstName} ${widget.empData.lastName}",
                color: headerbluecolors,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Gap(5),
              isLoading == true
                  ? myLoadingScreen
                  : SizedBox(
                      width: double.infinity,
                      child: PaginatedDataTable(
                          header: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Row(
                              children: [
                                const Expanded(
                                    child: Text(
                                  "Employee Details",
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                )),
                                Expanded(
                                    flex: 3,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Text(
                                          "Summary : ",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Gap(8),
                                        fCount(fill0, "Workdate(day)"),
                                        const Gap(8),
                                        fCount(fill2, "Trip(day)"),
                                        const Gap(8),
                                        fCount(fill1, "Holiday(day)"),
                                        const Gap(8),
                                        fCount(fill3, "Leave(hr.)"),
                                        const Gap(8),
                                        fCount(fill4, "OT-normal(hr.)"),
                                        const Gap(8),
                                        fCount(fill5, "OT-holiday(hr.)"),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          columnSpacing: 10,
                          showFirstLastButtons: true,
                          rowsPerPage: rowIndex,
                          availableRowsPerPage: const [31, 20, 10],
                          sortColumnIndex: sortColumnIndex,
                          sortAscending: sort,
                          onRowsPerPageChanged: (value) {
                            setState(() {
                              rowIndex = value!;
                            });
                          },
                          columns: const [
                            DataColumn(label: Text("Date")),
                            DataColumn(label: Text("Date type")),
                            DataColumn(label: Text("Check In")),
                            DataColumn(label: Text("Check Out")),
                            DataColumn(label: Text("Holiday(day)")),
                            DataColumn(label: Text("Trip(day)")),
                            DataColumn(label: Text("Leave(hr.)")),
                            DataColumn(label: Text("Leave type")),
                            DataColumn(label: Text("OT-normal(hr.)")),
                            DataColumn(label: Text("OT-holiday(hr.)")),
                          ],
                          source: PersonDataTableSource(empWtList, context)),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget fCount(TextEditingController controller, String labelText) {
    return SizedBox(
      width: 120,
      height: 45,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10.0),
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black87),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.black87),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabled: false,
            filled: true,
            fillColor: Colors.white),
      ),
    );
  }
}

class PersonDataTableSource extends DataTableSource {
  final BuildContext context;
  final List<EmployeeWorkTime>? data;

  PersonDataTableSource(
    this.data,
    this.context,
  );
  TextEditingController comment = TextEditingController();

  @override
  DataRow getRow(int index) {
    final d = data![index];
    return DataRow(
        color: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          return index % 2 == 0 ? Colors.white : Colors.grey[50]!;
        }),
        cells: [
          DataCell(Text(d.date)),
          DataCell(d.holiday == null
              ? const Text("วันทำงาน")
              : Text(
                  d.holiday!,
                  style: TextStyle(color: Colors.red[800]),
                )),
          // DataCell(Text("${d.titleName} ${d.firstName}  ${d.lastName}")),
          DataCell(Text(d.checkIn?.substring(0, 8) ?? "-")),
          DataCell(Text(d.checkOut?.substring(0, 8) ?? "-")),
          DataCell(Text(d.workHoliday ?? "-")),
          DataCell(Text(d.trip ?? "-")),
          DataCell(Text(d.nLeave ?? "-")),
          DataCell(Text(d.leaveType ?? "-")),
          DataCell(Text(d.normalOt ?? "-")),
          DataCell(Text(d.holidayOt ?? "-")),
        ]);
  }

  @override
  int get rowCount => data?.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
