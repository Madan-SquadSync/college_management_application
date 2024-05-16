import 'package:flutter/material.dart';
import 'package:nricse123/bussiness/entites/faculty_data_entity.dart';

abstract class AddFacultyBussinessRepository {
  Future<void> addFaculty(
      Map<String, dynamic> facultyData, BuildContext context);
}

abstract class RetrieveFacultyDataBussinessRepository {
  Future<List<FacultyEntity>> retrieveFacultyDetails(BuildContext context);
}
