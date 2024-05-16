import 'package:flutter/material.dart';

abstract class ResultEvent {}

class ResultIntializedEvent extends ResultEvent {}

class ResultFetchingEvent extends ResultEvent {
  final BuildContext context;
  final String rollnumber;

  ResultFetchingEvent({required this.context, required this.rollnumber, });
}
