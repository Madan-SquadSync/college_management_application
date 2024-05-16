import 'package:flutter/material.dart';

abstract class AdminDrawMainScreenEvent {}

class AdminDrawMainScreenInitialEvent extends AdminDrawMainScreenEvent {}

class AdminDrawMainScreenUpdateEvent extends AdminDrawMainScreenEvent {
  int value;
  BuildContext context;
  AdminDrawMainScreenUpdateEvent({required this.value , required this.context});
}
