import 'package:flutter/material.dart';

abstract class FacultyListEvent {}

class LoadFacultyListEvent extends FacultyListEvent {
  final BuildContext context;
  LoadFacultyListEvent({required this.context});
}