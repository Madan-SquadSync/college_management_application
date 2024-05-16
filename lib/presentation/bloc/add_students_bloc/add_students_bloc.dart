import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/bussiness/entites/student.dart';
import 'package:nricse123/bussiness/usecase/set_student_details_usecase.dart';
import 'package:nricse123/common/custom_snack_bar.dart';
import 'package:nricse123/data/data_source/working_excel.dart';
import 'package:nricse123/presentation/bloc/add_students_bloc/add_students_event.dart';
import 'package:nricse123/presentation/bloc/add_students_bloc/add_students_state.dart';

class AddStudentsBloc extends Bloc<AddStudentsEvent, AddStudentsState> {
  final SetStudentDetailsUseCase setStudentDetailsUseCase;
  AddStudentsBloc({required this.setStudentDetailsUseCase})
      : super(AddStudentsInitialState(filename: 'No file')) {
    on<AddStudentsUploadDataEvent>(addStudentsUploadDataEvent);
    on<AddStudentUploadDataIntoFirebaseEvent>(
        addStudentUploadDataIntoFirebaseEvent);
  }

  FutureOr<void> addStudentsUploadDataEvent(
      AddStudentsUploadDataEvent event, Emitter<AddStudentsState> emit) {
    emit(AddStudentsUpdateState(event.filename));
  }

  FutureOr<void> addStudentUploadDataIntoFirebaseEvent(
      AddStudentUploadDataIntoFirebaseEvent event,
      Emitter<AddStudentsState> emit) {
    emit(AddStudentsLoadingState(filename: state.filename));
    try {
      for (var student in ListOfOutput) {
        setStudentDetailsUseCase.execute(
            Student(
              name: student[0],
              rollNumber: student[1],
              section: student[2],
              gender: student[3],
              batch: student[4],
              department: student[5],
              emailAddress: student[6],
              phoneNumber: student[7],
              address: student[8],
              parentPhoneNumber: student[9],
            ),
            event.context);
      }
    } catch (e) {
      CustomSnackBar().show(event.context, "Excel File is Invaild");
    }
    emit(AddStudentsLoadedState(filename: state.filename));
    CustomSnackBar().show(event.context, "Upload Is Completed");
  }
}
