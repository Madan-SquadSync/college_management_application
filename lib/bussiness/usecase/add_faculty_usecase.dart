import 'package:flutter/material.dart';
import 'package:nricse123/bussiness/entites/faculty_data_entity.dart';
import 'package:nricse123/bussiness/repository/faculty_bussiness_repository.dart';

class AddFacultyUsecase {
  final AddFacultyBussinessRepository repository;

  AddFacultyUsecase({required this.repository});

  Future<void> execute(FacultyEntity faculty, BuildContext context) async {
    final facultyData = {
      'name': faculty.name,
      'previousExperience': faculty.previousExperience,
      'mobileNumber': faculty.mobileNumber,
      'mailId': faculty.mailId,
      'subjects': faculty.subjects,
    };
    await repository.addFaculty(facultyData, context);
  }
}
