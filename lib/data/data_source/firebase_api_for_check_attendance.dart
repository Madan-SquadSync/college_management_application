import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nricse123/common/custom_snack_bar.dart';
import 'package:nricse123/common/data.dart';

class FirebaseApiForCheckAttendance {
   Future<bool> checkAttendance(
      BuildContext context, String rollNumber, String date) async {
    DatabaseReference attendanceRef =
        database.child("Daily attendance").child(date).child(rollNumber);

    DatabaseEvent databaseEvent = await attendanceRef.once();

    if (databaseEvent.snapshot.value != null) {
      Map<dynamic, dynamic> attendanceData =
          databaseEvent.snapshot.value as Map;
      bool allPresent = attendanceData.values
          .every((periodData) => periodData['attendance'] == true);
      return allPresent;
    } else {
      CustomSnackBar()
          .show(context, "No data found for the roll number on the given date");
      return false;
    }
  }
}
