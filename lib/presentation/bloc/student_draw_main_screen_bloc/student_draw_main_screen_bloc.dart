import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/common/data.dart';
import 'package:nricse123/common/data_for_student_draw_main_screen.dart';
import 'package:nricse123/data/data_source/firebase_api_for_get_student_by_email.dart';
import 'package:nricse123/presentation/bloc/student_draw_main_screen_bloc/student_draw_main_screen_event.dart';
import 'package:nricse123/presentation/bloc/student_draw_main_screen_bloc/student_draw_main_screen_state.dart';

class StudentDrawMainScreenBloc
    extends Bloc<StudentDrawMainScreenEvent, StudentDrawMainScreenState> {
  StudentDrawMainScreenBloc() : super(StudentDrawMainScreenInitialState()) {
    on<StudentDrawMainScreenInitialEvent>(studentDrawMainScreenInitialEvent);
  }

  FutureOr<void> studentDrawMainScreenInitialEvent(
      StudentDrawMainScreenInitialEvent event,
      Emitter<StudentDrawMainScreenState> emit) async {
    studentModel = await FirebaseApiForGetStudentByEmail()
        .getStudentByEmail(firebaseAuth.currentUser!.email!, event.context);
    emit(StudentDrawMainScreenUpdateUiState());
  }
}
