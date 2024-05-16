import 'package:flutter/material.dart';

import 'package:nricse123/bussiness/entites/student_result_entity.dart';
import 'package:nricse123/bussiness/repository/student_bussiness_repository.dart';

class FetchStudentResult {
  final StudentBussinessRepository studentBussinessRepository;
  FetchStudentResult(this.studentBussinessRepository);
  Future<StudentResultEntity> startFetching(
      BuildContext context, String rollnumber) async {
    return await studentBussinessRepository.getStudentResultEntity(
        context, rollnumber);
  }
}
