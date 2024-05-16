import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:nricse123/bussiness/usecase/add_faculty_usecase.dart';
import 'package:nricse123/common/custom_snack_bar.dart';
import 'package:nricse123/common/data_for_add_faculty.dart';
import 'package:nricse123/data/data_source/add_subjects_to_firebase.dart';
import 'package:nricse123/presentation/bloc/add_faculty_bloc/add_faculty_event.dart';
import 'package:nricse123/presentation/bloc/add_faculty_bloc/add_faculty_state.dart';

class AddFacultyBloc extends Bloc<AddFacultyEvent, AddFacultyState> {
  final AddFacultyUsecase addFacultyUsecase;

  AddFacultyBloc({required this.addFacultyUsecase})
      : super(AddFacultyInitial()) {
    on<AddFacultyButtonPressed>(addAddFacultyButtonPressed);
    on<AddFacultySelectedSubjectsEvent>(addFacultySelectedSubjectsEvent);
    on<AddFacultyAddSubjectEvent>(addFacultyAddSubjectEvent);
  }

  FutureOr<void> addAddFacultyButtonPressed(
      AddFacultyButtonPressed event, Emitter<AddFacultyState> emit) async {
    emit(AddFacultyLoading());
    try {
      await addFacultyUsecase.execute(event.facultyEntity, event.context);
      emit(AddFacultyAddedSuccessfully());
    } catch (e) {
      // ignore: prefer_const_constructors
      emit(AddFacultyError(errorMessage: 'Failed to add AddFaculty'));
    }
  }

  FutureOr<void> addFacultySelectedSubjectsEvent(
      AddFacultySelectedSubjectsEvent event, Emitter<AddFacultyState> emit) {
    selectedSubjects = event.subjects;
  }

  FutureOr<void> addFacultyAddSubjectEvent(
      AddFacultyAddSubjectEvent event, Emitter<AddFacultyState> emit) async {
    final result =
        await AddSubjectsToFirebase().addSubject(event.subject, event.context);
    if (result) {
      CustomSnackBar().show(event.context, "Successfully upload");
    } else {
      CustomSnackBar().show(event.context, "Upload Failed");
    }
  }
}
