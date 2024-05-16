import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/bussiness/usecase/retrieve_students_for_attendance_usecase.dart';
import 'package:nricse123/common/attendance_student_list.dart';
import 'package:nricse123/common/data.dart';
import 'package:nricse123/common/data_for_take_attendance.dart';
import 'package:nricse123/data/data_source/retrieve_batch_data.dart';
import 'package:nricse123/data/data_source/retrieve_section_data.dart';
import 'package:nricse123/data/data_source/retrive_faculty_subjects.dart';
import 'package:nricse123/presentation/bloc/faculty_result_bloc/faculty_result_event.dart';
import 'package:nricse123/presentation/bloc/faculty_result_bloc/faculty_result_state.dart';

class FacultyResultBloc extends Bloc<FacultyResultEvent, FacultyResultState> {
  final RetrieveStudentsForAttendanceUsecase
      retrieveStudentsForAttendanceUsecase;
  FacultyResultBloc({required this.retrieveStudentsForAttendanceUsecase})
      : super(FacultyResultInitialState()) {
    on<FacultyResultInitialEvent>(facultyResultInitialEvent);
    on<FacultyResultUpdateUiEvent>(facultyResultUpdateUiEvent);
    on<FacultyResultRetrieveStudentEvent>(facultyResultRetrieveStudentEvent);
  }

  FutureOr<void> facultyResultInitialEvent(
      FacultyResultInitialEvent event, Emitter<FacultyResultState> emit) async {
    seletedBatch = "";
    seletedSection = "";
    listOfStudents = [];
    emit(FacultyResultRetrieveingStudentLoadingState());
    if (listOfBatch.isEmpty && listOfSections.isEmpty) {
      listOfBatch = await RetrieveBatchData().retrieveBatch(event.context);
      listOfSections =
          await RetrieveSectionData().retrieveSection(event.context);
      listOfSubjects = await RetrieveFacultySubjects().getSubjectsForFaculty(
          firebaseAuth.currentUser!.email!, event.context);
    }
    emit(FacultyResultRetrieveingStudentLoadedState());
    emit(FacultyResultUpdateUIState());
  }

  FutureOr<void> facultyResultUpdateUiEvent(
      FacultyResultUpdateUiEvent event, Emitter<FacultyResultState> emit) {
         emit(FacultyResultUpdateUIState());
      }

  FutureOr<void> facultyResultRetrieveStudentEvent(
      FacultyResultRetrieveStudentEvent event,
      Emitter<FacultyResultState> emit) async{
        emit(FacultyResultRetrieveingStudentLoadingState());
    listOfStudents = await retrieveStudentsForAttendanceUsecase.retrieve(
      event.context,
      event.batch,
      event.section,
    );
    emit(FacultyResultRetrieveingStudentLoadedState());
      }
}
