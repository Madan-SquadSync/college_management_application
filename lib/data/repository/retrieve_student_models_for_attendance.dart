import 'package:flutter/src/widgets/framework.dart';
import 'package:nricse123/bussiness/entites/student.dart';
import 'package:nricse123/bussiness/repository/attendance_business_repository.dart';
import 'package:nricse123/data/data_source/firebase_api_retrieve_students_for_attendance.dart';

class RetrieveStudentModelsForAttendance
    implements AttendanceBusinessRepository {
  final FirebaseApiRetrieveStudentsForAttendance
      firebaseApiRetrieveStudentsForAttendance;

  RetrieveStudentModelsForAttendance(
      {required this.firebaseApiRetrieveStudentsForAttendance});
  @override
  Future<List<Student>> getStudents(
      BuildContext context, String batch, String section) async {
    List<Student> listOfStudents = [];

    await firebaseApiRetrieveStudentsForAttendance
        .getStudents( context, batch, section)
        .then((value) {
      for (var e in value) {
        listOfStudents.add(Student(
            name: e.name,
            rollNumber: e.rollNumber,
            section: e.section,
            gender: e.gender,
            batch: e.batch,
            department: e.department,
            emailAddress: e.emailAddress,
            phoneNumber: e.phoneNumber,
            address: e.address,
            parentPhoneNumber: e.parentPhoneNumber));
      }
    });
    return listOfStudents;
  }
}
