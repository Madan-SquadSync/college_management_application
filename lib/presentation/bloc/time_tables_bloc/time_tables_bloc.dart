import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/presentation/bloc/time_tables_bloc/time_tables_event.dart';
import 'package:nricse123/presentation/bloc/time_tables_bloc/time_tables_state.dart';

class TimeTablesBloc extends Bloc<TimeTablesEvent, TimeTablesState> {
  TimeTablesBloc() : super(TimeTablesInsitialState(value: 0)) {
    on<TimeTableChangeNumberEvent>(timeTableChangeNumberEvent);
  }

  FutureOr<void> timeTableChangeNumberEvent(
      TimeTableChangeNumberEvent event, Emitter<TimeTablesState> emit) {
    emit(TimeTablesUpdateValueState(value: state.value+1));
  }
}
