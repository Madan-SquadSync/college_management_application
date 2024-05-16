import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/bussiness/repository/student_bussiness_repository.dart';
import 'package:nricse123/data/data_source/data.dart';
import 'package:nricse123/presentation/bloc/result_bloc/result_event.dart';
import 'package:nricse123/presentation/bloc/result_bloc/result_state.dart';
import 'package:nricse123/presentation/widgets/functions_for_sheets_snackbar_banners.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  ResultBloc({required this.studentBussinessRepository})
      : super(ResultStateInitial()) {
    on<ResultIntializedEvent>(resultIntializedEvent);

    on<ResultFetchingEvent>(resultFetchingEvent);
  }
  final StudentBussinessRepository studentBussinessRepository;

  FutureOr<void> resultIntializedEvent(
      ResultIntializedEvent event, Emitter<ResultState> emit) {}

  FutureOr<void> resultFetchingEvent(
      ResultFetchingEvent event, Emitter<ResultState> emit) async {
    emit(ResultFetchingState());
    try {
      studentResultEntity =
          await studentBussinessRepository.getStudentResultEntity(
        event.context,
        event.rollnumber,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackbarScreen(event.context, e.toString());
      emit(ResultFetchErrorState());
    }

    emit(ResultFetchedState());
  }
}
