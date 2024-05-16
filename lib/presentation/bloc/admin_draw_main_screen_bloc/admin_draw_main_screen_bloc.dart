import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:nricse123/presentation/bloc/admin_draw_main_screen_bloc/admin_draw_main_screen_event.dart';
import 'package:nricse123/presentation/bloc/admin_draw_main_screen_bloc/admin_draw_main_screen_state.dart';

class AdminDrawMainScreenBloc
    extends Bloc<AdminDrawMainScreenEvent, AdminDrawMainScreenState> {
  AdminDrawMainScreenBloc()
      : super(AdminDrawMainScreenInitializationState(currentScreen: 0)) {
    on<AdminDrawMainScreenInitialEvent>(adminDrawMainScreenInitialEvent);

    on<AdminDrawMainScreenUpdateEvent>(adminDrawMainScreenUpdateEvent);
  }

  FutureOr<void> adminDrawMainScreenInitialEvent(
      AdminDrawMainScreenInitialEvent event,
      Emitter<AdminDrawMainScreenState> emit) {}

  FutureOr<void> adminDrawMainScreenUpdateEvent(
      AdminDrawMainScreenUpdateEvent event,
      Emitter<AdminDrawMainScreenState> emit) async {
     
    emit(AdminDrawMainScreenUpdateState(changeCurrentScreen: event.value));
  }
}
