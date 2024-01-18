part of 'timeattendance_bloc.dart';

class TimeattendanceState extends Equatable {
  final HolidayDataModel? holidayData;
  final GetShiftAllModel? shiftData;
  final List<EmployeeDatum>? selectedemployeeData;
  final List<EmployeeDatum>? selectedTemp;
  final bool isDataLoading;
  final bool onSearchData;
  const TimeattendanceState({
    this.holidayData,
    this.shiftData,
    this.selectedemployeeData,
    this.selectedTemp,
    this.isDataLoading = true,
    this.onSearchData = false,
  });

  TimeattendanceState copyWith({
    HolidayDataModel? holidayData,
    GetShiftAllModel? shiftData,
    List<EmployeeDatum>? selectedemployeeData,
    List<EmployeeDatum>? selectedTemp,
    bool? isDataLoading,
    bool? onSearchData,
  }) {
    return TimeattendanceState(
      holidayData: holidayData ?? this.holidayData,
      shiftData: shiftData ?? this.shiftData,
      isDataLoading: isDataLoading ?? this.isDataLoading,
      onSearchData: onSearchData ?? this.onSearchData,
      selectedemployeeData: selectedemployeeData ?? this.selectedemployeeData,
      selectedTemp:selectedTemp??this.selectedTemp,
    );
  }

  @override
  List<Object?> get props => [
        holidayData,
        shiftData,
        selectedemployeeData,
        isDataLoading,
        onSearchData,selectedTemp,
      ];
}
