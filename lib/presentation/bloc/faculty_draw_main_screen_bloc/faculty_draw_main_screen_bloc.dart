import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/presentation/bloc/faculty_draw_main_screen_bloc/faculty_draw_main_screen_event.dart';
import 'package:nricse123/presentation/bloc/faculty_draw_main_screen_bloc/faculty_draw_main_screen_state.dart';

class FacultyDrawMainScreenBloc
    extends Bloc<FacultyDrawMainScreenEvent, FacultyDrawMainScreenState> {
  FacultyDrawMainScreenBloc()
      : super(FacultyDrawMainScreenInitializationState(currentScreen: 4)) {
    on<FacultyDrawMainScreenInitialEvent>(facultyDrawMainScreenInitialEvent);

    on<FacultyDrawMainScreenUpdateEvent>(facultyDrawMainScreenUpdateEvent);
  }

  FutureOr<void> facultyDrawMainScreenInitialEvent(
      FacultyDrawMainScreenInitialEvent event,
      Emitter<FacultyDrawMainScreenState> emit) {}

  FutureOr<void> facultyDrawMainScreenUpdateEvent(
      FacultyDrawMainScreenUpdateEvent event,
      Emitter<FacultyDrawMainScreenState> emit) async{
    emit(FacultyDrawMainScreenUpdateState(changeCurrentScreen: event.value));
  }
}
