import 'package:flutter/widgets.dart';
import 'package:nricse123/bussiness/entites/student.dart';
import 'package:nricse123/common/custom_snack_bar.dart';
import 'package:nricse123/common/data.dart';

class FirebaseApiForUploadAttendance {
  Future<bool> uploadAttendanceForStudent(
      BuildContext context,
      String date,
      String period,
      String subject,
      String teacherName,
      List<Student> absentStudents,
      List<Student> presentStudents) async {
    try {
      final attendanceDatabase = database.child('/Daily attendance/$date');

      for (var student in presentStudents) {
        final studentAttendanceDatabase =
            attendanceDatabase.child('${student.rollNumber}');
        final attendancePeriodDatabase =
            studentAttendanceDatabase.child(period);

        attendancePeriodDatabase.set({
          'subject': subject,
          'teacher': teacherName,
          'attendance': true,
        });
      }

      for (var student in absentStudents) {
        final studentAttendanceDatabase =
            attendanceDatabase.child('${student.rollNumber}');
        final attendancePeriodDatabase =
            studentAttendanceDatabase.child(period);

        attendancePeriodDatabase.set({
          'subject': subject,
          'teacher': teacherName,
          'attendance': false,
        });
      }
      return true;
    } catch (e) {
      CustomSnackBar().show(context, e.toString());
      return false;
    }
  }
}
