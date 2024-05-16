import 'package:flutter/widgets.dart';

abstract class StudentDrawMainScreenEvent {}

class StudentDrawMainScreenInitialEvent extends StudentDrawMainScreenEvent {
  BuildContext context;
  StudentDrawMainScreenInitialEvent({required this.context});
}
