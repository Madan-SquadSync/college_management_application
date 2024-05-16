import 'package:flutter/material.dart';
import 'package:nricse123/bussiness/entites/student.dart';

abstract class TakeAttendanceEvent {}

class TakeAttendanceInitialEvent extends TakeAttendanceEvent {
  BuildContext context;
  TakeAttendanceInitialEvent({required this.context});
}

class TakeAttendanceUpdateUiEvent extends TakeAttendanceEvent {}

class TakeAttendanceRetrieveStudentEvent extends TakeAttendanceEvent {
  final String batch;
  final String section;
  final BuildContext context;
  TakeAttendanceRetrieveStudentEvent(
      {required this.batch, required this.context, required this.section});
}

class TakeAttendanceAddAbsentStudentEvent extends TakeAttendanceEvent {
  final Student student;
  TakeAttendanceAddAbsentStudentEvent({required this.student});
}

class TakeAttendanceUploadTheAttendaceEvent extends TakeAttendanceEvent {
  BuildContext context;
  String date;
  List<String> periods;
  String subject;
  String teacherName;
  List<Student> absentStudents;
  List<Student> presentStudents;
  TakeAttendanceUploadTheAttendaceEvent(
      {required this.absentStudents,
      required this.context,
      required this.date,
      required this.periods,
      required this.presentStudents,
      required this.subject,
      required this.teacherName});
}
