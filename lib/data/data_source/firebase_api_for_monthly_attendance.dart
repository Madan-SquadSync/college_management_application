import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nricse123/common/custom_snack_bar.dart';
import 'package:nricse123/common/data.dart';

class FirebaseApiForMonthlyAttendance {
  Future<Map<int, Map<String, bool>>> getMonthlyAttendance(
      String rollNumber, int year, int month, BuildContext context) async {
    try {
      int daysInMonth = DateTime(year, month + 1, 0).day;

      Map<int, Map<String, bool>> dailyAttendance = {};

      for (int day = 1; day <= daysInMonth; day++) {
        String date =
            '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
        DatabaseEvent event;
        try {
          event = await database
              .child("Daily attendance")
              .child(date)
              .child(rollNumber)
              .once();
        } catch (e) {
          continue;
        }
        Map<dynamic, dynamic>? data = event.snapshot.value as Map;
        // Check if any period attendance is false for the day
        bool isAbsent =
            data.values.any((value) => value['attendance'] == false) ?? true;

        // Store daily attendance in the format {day: {attendance: true/false}}
        dailyAttendance[day] = {'attendance': !isAbsent};
      }

      return dailyAttendance;
    } catch (e) {
      print(e);
      CustomSnackBar().show(context, "Error fetching daily attendance");
      return {};
    }
  }
}
