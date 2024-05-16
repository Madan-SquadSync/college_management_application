import 'package:flutter/material.dart';

abstract class UploadResultEvent {}

class UploadResultStartEvent extends UploadResultEvent {
  BuildContext context;
  String semester;

  UploadResultStartEvent({required this.context, required this.semester});
}

class UploadResultInitialEvent extends UploadResultEvent {}
