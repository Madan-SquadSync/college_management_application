import 'package:flutter/material.dart';

abstract class TodayAttendanceEvent {}

class TodayAttendanceInitialEvent extends TodayAttendanceEvent {
  final String date;
  final String rollNumber;
  final BuildContext context;
  TodayAttendanceInitialEvent(
      {required this.context, required this.date, required this.rollNumber});
}
