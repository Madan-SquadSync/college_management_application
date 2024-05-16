import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/bussiness/usecase/add_faculty_usecase.dart';
import 'package:nricse123/data/data_source/firebase_api_for_add_faculty.dart';
import 'package:nricse123/data/repository/faculty_data_repository.dart';
import 'package:nricse123/presentation/bloc/add_faculty_bloc/add_faculty_bloc.dart';
import 'package:nricse123/presentation/pages/add_faculty.dart';
import 'package:nricse123/presentation/widgets/Navigating_one_place_to_another_place.dart';

class FloatingBottomButtonFacultyList extends StatelessWidget {
  const FloatingBottomButtonFacultyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      bottom: 0,
      end: 0,
      child: Padding(
        padding: const EdgeInsets.only(right: 10, bottom: 10),
        child: Hero(
          tag: "fillbutton",
          child: TextButton.icon(
            onPressed: () {
              NavigatingOnePlaceToAnotherPlace().navigatePage(
                  context,
                  BlocProvider(
                    create: (context) => AddFacultyBloc(
                        addFacultyUsecase: AddFacultyUsecase(
                            repository: FacultyRepository(
                                dataSource: FirebaseApiForAddFaculty()))),
                    child: AddFaculty(),
                  ));
            },
            label: const Text("Faculty"),
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
