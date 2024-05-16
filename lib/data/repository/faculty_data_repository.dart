import 'package:flutter/material.dart';
import 'package:nricse123/data/data_source/firebase_api_for_add_faculty.dart';

import '../../bussiness/repository/faculty_bussiness_repository.dart';

class FacultyRepository implements AddFacultyBussinessRepository {
  final FirebaseApiForAddFaculty dataSource;

  FacultyRepository({required this.dataSource});

  @override
  Future<void> addFaculty(
      Map<String, dynamic> facultyData, BuildContext context) async {
    await dataSource.addFaculty(facultyData, context);
  }
}
