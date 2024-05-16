import 'package:flutter/widgets.dart';
import 'package:nricse123/bussiness/entites/student.dart';
import 'package:nricse123/bussiness/repository/upload_attendance_business_repository.dart';
import 'package:nricse123/data/data_source/firebase_api_for_upload_attendance.dart';

class StudentAttandenceUploadDataRepository
    extends UploadAttendanceBusinessRepository {
  final FirebaseApiForUploadAttendance firebaseApiForUploadAttendance;
  StudentAttandenceUploadDataRepository(
      {required this.firebaseApiForUploadAttendance});
  @override
  Future<bool> uploadTheAttendance(
      BuildContext context,
      String date,
      String period,
      String subject,
      String teacherName,
      List<Student> absentStudents,
      List<Student> presentStudents) async {
    final result =
        await firebaseApiForUploadAttendance.uploadAttendanceForStudent(
            context,
            date,
            period,
            subject,
            teacherName,
            absentStudents,
            presentStudents);
    return result;
  }
}
