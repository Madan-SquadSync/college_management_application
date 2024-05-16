import 'package:flutter/material.dart';

abstract class FacultyResultEvent {}

class FacultyResultInitialEvent extends FacultyResultEvent {
  BuildContext context;
  FacultyResultInitialEvent({required this.context});
}

class FacultyResultUpdateUiEvent extends FacultyResultEvent {}

class FacultyResultRetrieveStudentEvent extends FacultyResultEvent {
  final String batch;
  final String section;
  final BuildContext context;
  FacultyResultRetrieveStudentEvent(
      {required this.batch, required this.context, required this.section});
}
