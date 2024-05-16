import 'package:flutter/material.dart';
import 'package:nricse123/bussiness/entites/faculty_data_entity.dart';
import 'package:nricse123/bussiness/repository/faculty_bussiness_repository.dart';

class RetrieveFacultyDetailsUsecase {
  final RetrieveFacultyDataBussinessRepository
      retrieveFacultyDataBussinessRepository;

  RetrieveFacultyDetailsUsecase(
      {required this.retrieveFacultyDataBussinessRepository});

  Future<List<FacultyEntity>> retrieve(BuildContext context) async {
    return await retrieveFacultyDataBussinessRepository
        .retrieveFacultyDetails(context);
  }
}
