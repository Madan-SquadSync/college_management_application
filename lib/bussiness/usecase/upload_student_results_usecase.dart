import 'package:flutter/material.dart';
import 'package:nricse123/bussiness/repository/student_bussiness_repository.dart';

class UploadStudentResultsUseCase {
  StudentBussinessRepository studentBussinessRepository;
  UploadStudentResultsUseCase({required this.studentBussinessRepository});

  Future<void> uploadStudentResults(BuildContext context, String semester,
      String subject, String status, String rollNumber) async {
    studentBussinessRepository.uploadStudentResults(
        context, semester, subject, status, rollNumber);
  }
}
