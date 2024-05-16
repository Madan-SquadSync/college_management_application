import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nricse123/common/custom_snack_bar.dart';
import 'package:nricse123/common/data.dart';
import 'package:nricse123/data/model/period_detail_model.dart';

class FirebaseApiForDailyAttendance {
  Future<List<PeriodDetailModel>> getDailyAttendance(
      String date, String rollNumber, BuildContext context) async {
    try {
      print(date);
      print(rollNumber);
      DatabaseEvent event = await database
          .child("Daily attendance")
          .child(date)
          .child(rollNumber)
          .once();

      Map<dynamic, dynamic>? data = event.snapshot.value as Map;

      // ignore: unnecessary_null_comparison
      if (data != null) {
        List<PeriodDetailModel> periodDetails = [];
        var sortedAttendanceData = SplayTreeMap<String, dynamic>.from(
          data,
          (a, b) => a.compareTo(b),
        );

        sortedAttendanceData.forEach((key, value) {
          periodDetails.add(PeriodDetailModel(
              attendance: value['attendance'],
              subject: value['subject'],
              teacher: value['teacher'],
              period: key.toString()));
        });

        return periodDetails;
      } else {
        CustomSnackBar().show(context, "No Data Found");
        return [];
      }
    } catch (e) {
      print(e);
      CustomSnackBar().show(context, "No Data Found");
      return [];
    }
  }
}
