import 'package:flutter/material.dart';

abstract class AttendanceStatusEvent {}

class AttendanceStatusInitialEvent extends AttendanceStatusEvent {
  BuildContext context;
  AttendanceStatusInitialEvent({required this.context});
}

class AttendanceStatusUpdateUiEvent extends AttendanceStatusEvent {}

class AttendanceStatusRetrieveStudentEvent extends AttendanceStatusEvent {
  final String batch;
  final String section;
  final BuildContext context;
  AttendanceStatusRetrieveStudentEvent(
      {required this.batch, required this.context, required this.section});
}

class AttendanceStatusPickDateTimeEvent extends AttendanceStatusEvent {
  final DateTime dateTime;
   AttendanceStatusPickDateTimeEvent({required this.dateTime});
}

