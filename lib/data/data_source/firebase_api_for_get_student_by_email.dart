import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:nricse123/common/custom_snack_bar.dart';
import 'package:nricse123/common/data.dart';
import 'package:nricse123/data/model/student_model.dart';

class FirebaseApiForGetStudentByEmail {
  Future<StudentModel> getStudentByEmail(
      String email, BuildContext context) async {
    DatabaseEvent databaseEvent;

    try {
      databaseEvent = await database.child("StudentDetails").once();

      final data = databaseEvent.snapshot.value as Map;
      final studentEntry = data.entries.firstWhere(
        (entry) => entry.value['Email Address'] == email,
        orElse: () => MapEntry('', null),
      );
      if (studentEntry.value != null) {
         
 
        return StudentModel.fromJson(
            studentEntry.value.cast<String, dynamic>());
      }
    } catch (e) {
      print(e.toString());
      CustomSnackBar().show(context, "No Found Details From this Email");
    }
    return StudentModel(
        name: '',
        rollNumber: '',
        section: '',
        gender: '',
        batch: '',
        department: '',
        emailAddress: '',
        phoneNumber: '',
        address: '',
        parentPhoneNumber: '');
  }
}
