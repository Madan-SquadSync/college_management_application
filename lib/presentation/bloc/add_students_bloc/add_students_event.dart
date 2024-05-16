import 'package:flutter/material.dart';

abstract class AddStudentsEvent {}

class AddStudentsInitialEvent extends AddStudentsEvent {}

class AddStudentsUploadDataEvent extends AddStudentsEvent {
  String filename;
  AddStudentsUploadDataEvent({required this.filename});
}

class AddStudentUploadDataIntoFirebaseEvent extends AddStudentsEvent {
  final BuildContext context;
  AddStudentUploadDataIntoFirebaseEvent({required this.context});
}
