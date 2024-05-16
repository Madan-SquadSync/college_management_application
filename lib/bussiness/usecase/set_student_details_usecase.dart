import 'package:flutter/material.dart';
import 'package:nricse123/bussiness/entites/student.dart';
import 'package:nricse123/bussiness/repository/student_bussiness_repository.dart';
import 'package:nricse123/common/custom_snack_bar.dart';

class SetStudentDetailsUseCase {
  final StudentRepository _repository;

  SetStudentDetailsUseCase(this._repository);

  Future<void> execute(Student student, BuildContext context) async {
    try {
      await _repository.setStudentDetails(student, context);
       
    } catch (error) {
      CustomSnackBar().show(context, 'Error setting student details: $error');
    }
  }
}
