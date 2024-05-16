import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/bussiness/repository/student_bussiness_repository.dart';
import 'package:nricse123/common/data_for_attendance_status.dart';
import 'package:nricse123/data/data_source/data.dart';

import 'package:nricse123/presentation/bloc/student_result_bloc/student_result_event.dart';
import 'package:nricse123/presentation/bloc/student_result_bloc/student_result_state.dart';
import 'package:nricse123/presentation/widgets/functions_for_sheets_snackbar_banners.dart';

class StudentResultBloc extends Bloc<StudentResultEvent, StudentResultState> {
  StudentBussinessRepository studentBussinessRepository;
  StudentResultBloc({required this.studentBussinessRepository})
      : super(StudentResultInitialState()) {
    on<StudentResultInitialEvent>(studentResultInitialEvent);
     
  }

  FutureOr<void> studentResultInitialEvent(
      StudentResultInitialEvent event, Emitter<StudentResultState> emit) async {
    emit(StudentResultLoadingState());
    try {
      studentResultEntity =
          await studentBussinessRepository.getStudentResultEntity(
        event.context,
        event.rollNumber,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackbarScreen(event.context, e.toString());
    }
  }

  
}
