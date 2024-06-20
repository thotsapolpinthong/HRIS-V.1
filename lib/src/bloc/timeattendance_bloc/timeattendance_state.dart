// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'timeattendance_bloc.dart';

class TimeattendanceState extends Equatable {
  final HolidayDataModel? holidayData;
  final GetShiftAllModel? shiftData;
  final List<EmployeeDatum>? selectedemployeeData;
  final List<EmployeeDatum>? selectedTemp;
  final bool isDataLoading;
  final bool onSearchData;
  final WorkdateSpaecialModel? workSpData;
  final GetLunchBreakModel? lunchBreakData;
  const TimeattendanceState({
    this.holidayData,
    this.shiftData,
    this.selectedemployeeData,
    this.selectedTemp,
    this.isDataLoading = true,
    this.onSearchData = false,
    this.workSpData,
    this.lunchBreakData,
  });

  TimeattendanceState copyWith({
    HolidayDataModel? holidayData,
    GetShiftAllModel? shiftData,
    List<EmployeeDatum>? selectedemployeeData,
    List<EmployeeDatum>? selectedTemp,
    bool? isDataLoading,
    bool? onSearchData,
    WorkdateSpaecialModel? workSpData,
    GetLunchBreakModel? lunchBreakData,
  }) {
    return TimeattendanceState(
        holidayData: holidayData ?? this.holidayData,
        shiftData: shiftData ?? this.shiftData,
        isDataLoading: isDataLoading ?? this.isDataLoading,
        onSearchData: onSearchData ?? this.onSearchData,
        selectedemployeeData: selectedemployeeData,
        selectedTemp: selectedTemp ?? this.selectedTemp,
        workSpData: workSpData,
        lunchBreakData: lunchBreakData);
  }

  @override
  List<Object?> get props => [
        holidayData,
        shiftData,
        selectedemployeeData,
        isDataLoading,
        onSearchData,
        selectedTemp,
        workSpData,
        lunchBreakData,
      ];
}
