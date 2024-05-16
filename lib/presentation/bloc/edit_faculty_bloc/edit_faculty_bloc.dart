import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:nricse123/bussiness/usecase/add_faculty_usecase.dart';
import 'package:nricse123/common/custom_snack_bar.dart';
import 'package:nricse123/common/data_for_add_faculty.dart';
import 'package:nricse123/data/data_source/add_subjects_to_firebase.dart';
import 'package:nricse123/presentation/bloc/edit_faculty_bloc/edit_faculty_event.dart';
import 'package:nricse123/presentation/bloc/edit_faculty_bloc/edit_faculty_state.dart';

class EditFacultyBloc extends Bloc<EditFacultyEvent, EditFacultyState> {
  final AddFacultyUsecase addFacultyUsecase;

  EditFacultyBloc({required this.addFacultyUsecase})
      : super(EditFacultyInitial()) {
    on<EditFacultyButtonPressed>(addAddFacultyButtonPressed);
    on<EditFacultySelectedSubjectsEvent>(addFacultySelectedSubjectsEvent);
    on<EditFacultyAddSubjectEvent>(addFacultyAddSubjectEvent);
  }

  FutureOr<void> addAddFacultyButtonPressed(
      EditFacultyButtonPressed event, Emitter<EditFacultyState> emit) async {
    emit(EditFacultyLoading());
    try {
      await addFacultyUsecase.execute(event.facultyEntity, event.context);
      emit(EditFacultyAddedSuccessfully());
    } catch (e) {
      // ignore: prefer_const_constructors
      emit(EditFacultyError(errorMessage: 'Failed to add AddFaculty'));
    }
  }

  FutureOr<void> addFacultySelectedSubjectsEvent(
      EditFacultySelectedSubjectsEvent event, Emitter<EditFacultyState> emit) {
    selectedSubjects = event.subjects;
  }

  FutureOr<void> addFacultyAddSubjectEvent(
      EditFacultyAddSubjectEvent event, Emitter<EditFacultyState> emit) async {
    final result =
        await AddSubjectsToFirebase().addSubject(event.subject, event.context);
    if (result) {
      CustomSnackBar().show(event.context, "Successfully upload");
    } else {
      CustomSnackBar().show(event.context, "Upload Failed");
    }
  }
}
