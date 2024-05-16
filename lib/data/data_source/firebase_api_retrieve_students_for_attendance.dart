import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:nricse123/common/custom_snack_bar.dart';
import 'package:nricse123/common/data.dart';
import 'package:nricse123/data/model/student_model.dart';

class FirebaseApiRetrieveStudentsForAttendance {
  Future<List<StudentModel>> getStudents(
      BuildContext context, String batch, String section) async {
    List<StudentModel> students = [];

    try {
      DatabaseEvent dataSnapshot =
          await database.child('StudentDetails').once();

      Map<dynamic, dynamic> studentsMap = dataSnapshot.snapshot.value as Map;

      // ignore: unnecessary_null_comparison
      if (studentsMap != null) {
        studentsMap.forEach((key, value) {
          var studentInfo = value as Map;
          var studentBatch = studentInfo['Batch'];
          var studentSection = studentInfo['Section'];
          if (studentBatch == batch && studentSection == section) {
            print(studentInfo);
            students.add(StudentModel(
              name: studentInfo['Name'],
              rollNumber: studentInfo['Roll Number'],
              section: studentInfo['Section'],
              gender: studentInfo['Gender'],
              batch: studentInfo['Batch'],
              department: studentInfo['Department'],
              emailAddress: studentInfo['Email Address'],
              phoneNumber: studentInfo['Phone Number'],
              address: studentInfo['Address'],
              parentPhoneNumber: studentInfo['Parent Phone Number'],
            ));
          }
        });

        return students;
      }
    } catch (error) {
      print(error.toString());
      CustomSnackBar().show(context, 'Error retrieving students: $error');
      return [];
    }
    return students;
  }
}
