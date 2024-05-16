import 'package:flutter/widgets.dart';
import 'package:nricse123/bussiness/entites/student.dart';
import 'package:nricse123/bussiness/repository/upload_attendance_business_repository.dart';

class UploadAttendanceUsecase {
  UploadAttendanceBusinessRepository uploadAttendanceBusinessRepository;
  UploadAttendanceUsecase({required this.uploadAttendanceBusinessRepository});

  Future<bool> uploadAttendance(
      BuildContext context,
      String date,
      String period,
      String subject,
      String teacherName,
      List<Student> absentStudents,
      List<Student> presentStudents) async {
    return await uploadAttendanceBusinessRepository.uploadTheAttendance(context,
        date, period, subject, teacherName, absentStudents, presentStudents);
  }
}


