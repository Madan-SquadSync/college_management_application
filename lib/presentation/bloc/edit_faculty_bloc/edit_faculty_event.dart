import 'package:flutter/material.dart';
import 'package:nricse123/bussiness/entites/faculty_data_entity.dart';

abstract class EditFacultyEvent {
  const EditFacultyEvent();
}

class EditFacultyButtonPressed extends EditFacultyEvent {
  final FacultyEntity facultyEntity;
  final BuildContext context;

  const EditFacultyButtonPressed(this.context, {required this.facultyEntity});
}

class EditFacultySelectedSubjectsEvent extends EditFacultyEvent {
  final List<String> subjects;
  EditFacultySelectedSubjectsEvent({required this.subjects});
}

class EditFacultyAddSubjectEvent extends EditFacultyEvent {
  final String subject;
  final BuildContext context;
  EditFacultyAddSubjectEvent({required this.subject, required this.context});
}
