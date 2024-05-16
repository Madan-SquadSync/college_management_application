import 'package:flutter/material.dart';
import 'package:nricse123/bussiness/entites/faculty_data_entity.dart';

abstract class AddFacultyEvent {
  const AddFacultyEvent();
}

class AddFacultyButtonPressed extends AddFacultyEvent {
  final FacultyEntity facultyEntity;
  final BuildContext context;

  const AddFacultyButtonPressed(this.context, {required this.facultyEntity});
}

class AddFacultySelectedSubjectsEvent extends AddFacultyEvent {
  final List<String> subjects;
  AddFacultySelectedSubjectsEvent({required this.subjects});
}

class AddFacultyAddSubjectEvent extends AddFacultyEvent {
  final String subject;
   final BuildContext context;
  AddFacultyAddSubjectEvent({required this.subject , required this.context});
}
