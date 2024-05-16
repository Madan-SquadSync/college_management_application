import 'package:flutter/material.dart';
import 'package:nricse123/bussiness/entites/student.dart';
import 'package:nricse123/bussiness/entites/student_result_entity.dart';

abstract class StudentBussinessRepository {
  Future<StudentResultEntity> getStudentResultEntity(
      BuildContext context, String rollnumber);
  Future<void> uploadStudentResults(BuildContext context, String semester,
      String subject, String status, String rollNumber);
}

abstract class StudentRepository {
  Future<void> setStudentDetails(Student student, BuildContext context);
}
