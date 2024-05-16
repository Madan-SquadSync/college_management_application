import 'package:flutter/widgets.dart';
import 'package:nricse123/bussiness/entites/student.dart';

abstract class UploadAttendanceBusinessRepository {
  Future<bool> uploadTheAttendance(
    BuildContext context,
      String date,
      String period,
      String subject,
      String teacherName,
      List<Student> absentStudents,
      List<Student> presentStudents);
}
