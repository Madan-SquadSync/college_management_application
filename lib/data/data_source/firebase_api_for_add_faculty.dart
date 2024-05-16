import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nricse123/common/custom_snack_bar.dart';
import 'package:nricse123/common/data.dart';

class FirebaseApiForAddFaculty {
  final DatabaseReference _facultyRef = database.child('facultyDetails');

  Future<void> addFaculty(
      Map<String, dynamic> facultyData, BuildContext context) async {
    try {
      final mobileNumber = facultyData['mobileNumber'];
      if (mobileNumber == null) {
        CustomSnackBar().show(context, 'Mobile number is required.');
      }

      await _facultyRef.child(mobileNumber).set(facultyData);
      // ignore: use_build_context_synchronously
      CustomSnackBar().show(context, 'Faculty added successfully');
    } catch (error) {
      // ignore: use_build_context_synchronously
      CustomSnackBar().show(context, 'Failed to add faculty: $error');
    }
  }
}
