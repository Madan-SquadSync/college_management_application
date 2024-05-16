import 'package:flutter/material.dart';

import 'package:nricse123/bussiness/entites/student_result_entity.dart';
import 'package:nricse123/bussiness/repository/student_bussiness_repository.dart';
import 'package:nricse123/data/data_source/firebase_api_service_for_student_result.dart';
import 'package:nricse123/data/model/student_result_model.dart';

class StudentResultRepository implements StudentBussinessRepository {
  final FirebaseApiServiceForStudentResult firebaseApiServiceForStudentResult;
  StudentResultRepository({required this.firebaseApiServiceForStudentResult});
  @override
  Future<StudentResultEntity> getStudentResultEntity(
      BuildContext context, String rollnumber) async {
    StudentResultModel studentResultModel =
        await firebaseApiServiceForStudentResult.retrieveStudentResults(
            context, rollnumber);
    return StudentResultEntity(
        name: studentResultModel.name,
        semstersResult: studentResultModel.semstersResult);
  }

  @override
  Future<void> uploadStudentResults(BuildContext context, String semester,
      String subject, String status, String rollNumber) async {
    await firebaseApiServiceForStudentResult.uploadTheResultOfTheStudents(
        context, semester, subject, status, rollNumber);
  }
}
