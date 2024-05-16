import 'package:flutter/material.dart';
import 'package:nricse123/common/custom_snack_bar.dart';
import 'package:nricse123/common/data.dart';
import 'package:nricse123/data/model/student_model.dart';

class FirebaseApiForStudentDetails {
  Future<void> setStudentDetailsToFirebase(
      StudentModel student, BuildContext context) async {
    try {
      await database.child('StudentDetails').child(student.rollNumber).set({
        'Name': student.name,
        'Roll Number': student.rollNumber,
        'Section': student.section,
        'Gender': student.gender,
        'Batch': student.batch,
        'Department': student.department,
        'Email Address': student.emailAddress,
        'Phone Number': student.phoneNumber,
        'Address': student.address,
        'Parent Phone Number': student.parentPhoneNumber,
      });
      database.child("Batch").child(student.batch).set({'name': student.batch});
      database
          .child("Role")
          .child('Student')
          .child(student.rollNumber)
          .set({'email': student.emailAddress});
       
      database
          .child("Section")
          .child(student.section)
          .set({"name": student.section});

      CustomSnackBar().show(context,
          'Student details uploaded to Firebase Realtime Database successfully.');
    } catch (error) {
      CustomSnackBar()
          .show(context, 'Error uploading student details to Firebase: $error');
      // Handle error as per your requirement
    }
  }
}
