import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:nricse123/common/data.dart';
import 'package:nricse123/data/model/student_result_model.dart';
import 'package:nricse123/presentation/widgets/functions_for_sheets_snackbar_banners.dart';

class FirebaseApiServiceForStudentResult {
  Future<StudentResultModel> retrieveStudentResults(
      BuildContext context, String rollnumber) async {
    Map rollNUmberStudentResultDetails = {};
    String name = "";

    try {
      final studentResultsRollnumber =
          await database.child("studentResults").child(rollnumber).once();
      final studentRollnumberMap =
          studentResultsRollnumber.snapshot.value as Map;

      studentRollnumberMap.forEach(
        (key, value) {
          if (key == 'semesters') {
            rollNUmberStudentResultDetails.addAll(value);
          } else if (key == 'name') {
            name = value;
          }
        },
      );
      rollNUmberStudentResultDetails = SplayTreeMap<String, dynamic>.from(
        rollNUmberStudentResultDetails,
        (a, b) => a.compareTo(b),
      );
    } catch (e) {
      showSnackbarScreen(context, "Invaild Input");
    }
    return StudentResultModel(
      name: name,
      semstersResult: rollNUmberStudentResultDetails,
    );
  }

  Future<void> uploadTheResultOfTheStudents(BuildContext context,
      String semester, String subject, String status, String rollNumber) async {
    try {
      final studentResults = database.child("studentResults");
      var studentResultsRollnumber = studentResults.child(rollNumber);
      await studentResultsRollnumber.child('name').set('$rollNumber');
      var studentResultsRollnumberSubjects =
          studentResultsRollnumber.child("semesters").child(semester);
      await studentResultsRollnumberSubjects.child('${subject}').set(status);
      showSnackbarScreen(context, "SuccessFully Retrieved"); 
    } catch (e) {
       
      showSnackbarScreen(context, e.toString());
    }
  }
}
