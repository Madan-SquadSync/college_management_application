import 'package:flutter/widgets.dart';

abstract class FacultyDrawMainScreenEvent {}

class FacultyDrawMainScreenInitialEvent extends FacultyDrawMainScreenEvent {}

class FacultyDrawMainScreenUpdateEvent extends FacultyDrawMainScreenEvent {
  int value;
  BuildContext context;
  FacultyDrawMainScreenUpdateEvent({required this.value , required this.context});
}
