import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/bussiness/usecase/retrieve_faculty_details_usecase.dart';
import 'package:nricse123/common/list_of_faculty_details.dart';
import 'package:nricse123/presentation/bloc/faculty_list_bloc/faculty_list_event.dart';
import 'package:nricse123/presentation/bloc/faculty_list_bloc/faculty_list_state.dart';

// class FacultyListBloc extends Bloc<FacultyListEvent, FacultyListState> {
//   final RetrieveFacultyDetailsUsecase retrieveFacultyDetailsUsecase;

//   FacultyListBloc({required this.retrieveFacultyDetailsUsecase})
//       : super(FacultyListInitialState());

// }

class FacultyListBloc extends Bloc<FacultyListEvent, FacultyListState> {
  final RetrieveFacultyDetailsUsecase retrieveFacultyDetailsUsecase;
  FacultyListBloc({required this.retrieveFacultyDetailsUsecase})
      : super(FacultyListInitialState()) {
    on<LoadFacultyListEvent>(loadFacultyListEvent);
  }

  FutureOr<void> loadFacultyListEvent(
      LoadFacultyListEvent event, Emitter<FacultyListState> emit) async {
    emit(FacultyListLoadingState());

    listOfFacultyEtity =
        await retrieveFacultyDetailsUsecase.retrieve(event.context);
    emit(FacultyListLoadedState());
  }
}
