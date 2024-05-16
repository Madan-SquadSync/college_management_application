 
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/bussiness/usecase/retrieve_students_for_attendance_usecase.dart';
import 'package:nricse123/bussiness/usecase/upload_attendance_usecase.dart';
import 'package:nricse123/common/attendance_student_list.dart';
import 'package:nricse123/common/custom_snack_bar.dart';
import 'package:nricse123/common/data.dart';
import 'package:nricse123/common/data_for_take_attendance.dart';
import 'package:nricse123/data/data_source/retrieve_batch_data.dart';
import 'package:nricse123/data/data_source/retrieve_section_data.dart';
import 'package:nricse123/data/data_source/retrive_faculty_subjects.dart';
import 'package:nricse123/presentation/bloc/take_attendance_bloc/take_attendance_event.dart';
import 'package:nricse123/presentation/bloc/take_attendance_bloc/take_attendance_state.dart';

class TakeAttendanceBloc
    extends Bloc<TakeAttendanceEvent, TakeAttendanceState> {
  final UploadAttendanceUsecase uploadAttendanceUsecase;
  final RetrieveStudentsForAttendanceUsecase
      retrieveStudentsForAttendanceUsecase;
  TakeAttendanceBloc(
      {required this.retrieveStudentsForAttendanceUsecase,
      required this.uploadAttendanceUsecase})
      : super(TakeAttendanceInitialState()) {
    on<TakeAttendanceInitialEvent>(takeAttendanceInitialEvent);
    on<TakeAttendanceUpdateUiEvent>(takeAttendanceUpdateUiEvent);
    on<TakeAttendanceRetrieveStudentEvent>(takeAttendanceRetrieveStudentEvent);
    on<TakeAttendanceAddAbsentStudentEvent>(
        takeAttendanceAddAbsentStudentEvent);
    on<TakeAttendanceUploadTheAttendaceEvent>(
        takeAttendanceUploadTheAttendaceEvent);
  }

  FutureOr<void> takeAttendanceInitialEvent(TakeAttendanceInitialEvent event,
      Emitter<TakeAttendanceState> emit) async {

    seletedBatch = "";
    seletedSection = "";
    listOfStudents = [];
    emit(TakeAttendanceRetrieveingStudentLoadingState());
    if (listOfBatch.isEmpty && listOfSections.isEmpty) {
      listOfBatch = await RetrieveBatchData().retrieveBatch(event.context);
      listOfSections =
          await RetrieveSectionData().retrieveSection(event.context);
      listOfSubjects = await RetrieveFacultySubjects().getSubjectsForFaculty(
          firebaseAuth.currentUser!.email!, event.context);
    }
    emit(TakeAttendanceRetrieveingStudentLoadedState());
    emit(TakeAttendanceUpdateUIState());
  }

  FutureOr<void> takeAttendanceUpdateUiEvent(
      TakeAttendanceUpdateUiEvent event, Emitter<TakeAttendanceState> emit) {
    emit(TakeAttendanceUpdateUIState());
  }

  FutureOr<void> takeAttendanceRetrieveStudentEvent(
      TakeAttendanceRetrieveStudentEvent event,
      Emitter<TakeAttendanceState> emit) async {
    emit(TakeAttendanceRetrieveingStudentLoadingState());
    listOfStudents = await retrieveStudentsForAttendanceUsecase.retrieve(
      event.context,
      event.batch,
      event.section,
    );
    emit(TakeAttendanceRetrieveingStudentLoadedState());
  }

  FutureOr<void> takeAttendanceAddAbsentStudentEvent(
      TakeAttendanceAddAbsentStudentEvent event,
      Emitter<TakeAttendanceState> emit) {
    if (listOfAbsentStudents.contains(event.student)) {
      listOfAbsentStudents.remove(event.student);
    } else {
      listOfAbsentStudents.add(event.student);
    }
  }

  FutureOr<void> takeAttendanceUploadTheAttendaceEvent(
      TakeAttendanceUploadTheAttendaceEvent event,
      Emitter<TakeAttendanceState> emit) async {
    emit(TakeAttendanceRetrieveingStudentLoadingState());
    for (String period in event.periods) {
      final result = await uploadAttendanceUsecase.uploadAttendance(
          event.context,
          event.date,
          period,
          event.subject,
          event.teacherName,
          event.absentStudents,
          event.presentStudents);
      if (result) {
        CustomSnackBar().show(event.context, "$period uploaded");
      } else {
        CustomSnackBar().show(event.context, "$period Failed");
      }
    }
    emit(TakeAttendanceRetrieveingStudentLoadedState());
  }
}
