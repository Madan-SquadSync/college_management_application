import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/bussiness/usecase/set_student_details_usecase.dart';
import 'package:nricse123/data/data_source/firebase_api_for_student_details.dart';
import 'package:nricse123/data/repository/student_details_upload_repository.dart';
import 'package:nricse123/presentation/bloc/add_students_bloc/add_students_bloc.dart';
import 'package:nricse123/presentation/pages/add_students.dart';
import 'package:nricse123/presentation/widgets/Navigating_one_place_to_another_place.dart';

class FloatingBottomButtonAddStudents extends StatelessWidget {
  const FloatingBottomButtonAddStudents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      bottom: 50,
      end: 0,
      child: Padding(
        padding: const EdgeInsets.only(right: 10, bottom: 10),
        child: Hero(
          tag: "fillbutton2",
          child: TextButton.icon(
            onPressed: () {
              NavigatingOnePlaceToAnotherPlace().navigatePage(
                  context,
                  BlocProvider(
                    create: (context) => AddStudentsBloc(
                        setStudentDetailsUseCase: SetStudentDetailsUseCase(
                            StudentDetailsUploadRepository(
                                firebaseApi: FirebaseApiForStudentDetails()))),
                    child: const AddStudents(),
                  ));
            },
            label: const Text("Student"),
            icon: const Icon(Icons.add),
            style: ButtonStyle(
              elevation: const MaterialStatePropertyAll(4),
              backgroundColor:
                  const MaterialStatePropertyAll(Colors.deepPurpleAccent),
              foregroundColor: const MaterialStatePropertyAll(Colors.white),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
