import 'package:flutter/material.dart';

abstract class StudentResultEvent {}

class StudentResultInitialEvent extends StudentResultEvent {
  final BuildContext context;
  final String rollNumber;
  StudentResultInitialEvent({
    required this.context,
    required this.rollNumber,
  });
}

 