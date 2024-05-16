import 'package:flutter/widgets.dart';
import 'package:nricse123/bussiness/entites/student.dart';
import 'package:nricse123/bussiness/repository/attendance_business_repository.dart';
 

class RetrieveStudentsForAttendanceUsecase {
  final AttendanceBusinessRepository attendanceBusinessRepository;
  RetrieveStudentsForAttendanceUsecase(
      {required this.attendanceBusinessRepository});

  Future<List<Student>> retrieve(
      BuildContext context, String batch, String section) async {
    return await attendanceBusinessRepository.getStudents(
        context, batch, section);
  }
}
