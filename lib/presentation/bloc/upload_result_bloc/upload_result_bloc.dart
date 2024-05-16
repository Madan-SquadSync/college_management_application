import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/bussiness/usecase/upload_student_results_usecase.dart';
import 'package:nricse123/common/custom_snack_bar.dart';
import 'package:nricse123/data/data_source/working_excel.dart';
import 'package:nricse123/presentation/bloc/upload_result_bloc/upload_result_event.dart';
import 'package:nricse123/presentation/bloc/upload_result_bloc/upload_result_state.dart';

class UploadResultBloc extends Bloc<UploadResultEvent, UploadResultState> {
  final UploadStudentResultsUseCase uploadStudentResultsUseCase;
  UploadResultBloc({required this.uploadStudentResultsUseCase})
      : super(UploadResultInitialState(count: 0)) {
    on<UploadResultStartEvent>(uploadResultStartEvent);
    on<UploadResultInitialEvent>(uploadResultInitialEvent);
  }

  FutureOr<void> uploadResultStartEvent(
      UploadResultStartEvent event, Emitter<UploadResultState> emit) {
    emit(UploadResultLoadingState(count: state.count));
    try {
      for (List<String> result in ListOfOutput) {
        if (result.length != 3) {
          throw Exception();
        }
        uploadStudentResultsUseCase.uploadStudentResults(
            event.context, event.semester, result[1], result[2], result[0]);
      }
    } catch (e) {
      CustomSnackBar().show(event.context, "Got the error Please try again");
    }
    emit(UploadResultLoadedState(count: state.count));
    CustomSnackBar().show(event.context, "Upload Is Completed");
  }

  FutureOr<void> uploadResultInitialEvent(
      UploadResultInitialEvent event, Emitter<UploadResultState> emit) {
    emit(UploadResultInitialState(count: 0));
  }
}
