import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/bussiness/usecase/retrieve_student_daily_attendance_repository.dart';
import 'package:nricse123/common/custom_snack_bar.dart';
import 'package:nricse123/common/data_for_today_attendance.dart';
import 'package:nricse123/presentation/bloc/today_attendance_bloc/today_attendance_event.dart';
import 'package:nricse123/presentation/bloc/today_attendance_bloc/today_attendance_state.dart';

class TodayAttendanceBloc
    extends Bloc<TodayAttendanceEvent, TodayAttendanceState> {
  RetrieveStudentDailyAttendanceRepository
      retrieveStudentDailyAttendanceRepository;

  TodayAttendanceBloc({required this.retrieveStudentDailyAttendanceRepository})
      : super(TodayAttendanceInitialState()) {
    on<TodayAttendanceInitialEvent>(todayAttendanceInitialEvent);
  }

  FutureOr<void> todayAttendanceInitialEvent(TodayAttendanceInitialEvent event,
      Emitter<TodayAttendanceState> emit) async {
    emit(TodayAttendanceLoadingState());
    try {
      listOfPeriodDetailEntity =
          await retrieveStudentDailyAttendanceRepository.retrieve(
        event.date,
        event.rollNumber,
        event.context,
      );
    } catch (e) {
      CustomSnackBar().show(event.context, e.toString());
    }
    emit(TodayAttendanceLoadedState());
  }
   
}
