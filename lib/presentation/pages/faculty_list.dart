import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/bussiness/usecase/add_faculty_usecase.dart';
import 'package:nricse123/bussiness/usecase/retrieve_faculty_details_usecase.dart';
import 'package:nricse123/common/list_of_faculty_details.dart';
import 'package:nricse123/data/data_source/firebase_api_for_add_faculty.dart';

import 'package:nricse123/data/data_source/firebase_api_service_for_retrieve_List_of_faculty_Model.dart';
import 'package:nricse123/data/repository/faculty_data_repository.dart';
import 'package:nricse123/data/repository/retrieve_faculty_data_repository.dart';
import 'package:nricse123/presentation/bloc/edit_faculty_bloc/edit_faculty_bloc.dart';
import 'package:nricse123/presentation/bloc/faculty_list_bloc/faculty_list_bloc.dart';
import 'package:nricse123/presentation/bloc/faculty_list_bloc/faculty_list_event.dart';
import 'package:nricse123/presentation/bloc/faculty_list_bloc/faculty_list_state.dart';
import 'package:nricse123/presentation/pages/edit_faculty.dart';
import 'package:nricse123/presentation/widgets/Navigating_one_place_to_another_place.dart';
import 'package:nricse123/presentation/widgets/floating_bottom_button_add_students.dart';
import 'package:nricse123/presentation/widgets/floating_bottom_button_faculty_list.dart';

class FacultyList extends StatefulWidget {
  const FacultyList({Key? key}) : super(key: key);

  @override
  State<FacultyList> createState() => _FacultyListState();
}

class _FacultyListState extends State<FacultyList> {
  final FacultyListBloc facultyListBloc = FacultyListBloc(
    retrieveFacultyDetailsUsecase: RetrieveFacultyDetailsUsecase(
      retrieveFacultyDataBussinessRepository: RetrieveFacultyDataRepository(
        firebaseApiServiceForRetrieveListOfFacultyModel:
            FirebaseApiServiceForRetrieveListOfFacultyModel(),
      ),
    ),
  );

  @override
  void initState() {
    facultyListBloc.add(LoadFacultyListEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: BlocConsumer<FacultyListBloc, FacultyListState>(
        bloc: facultyListBloc,
        listener: (context, state) {},
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              if (state is FacultyListLoadedState)
                Column(
                  children: [
                    if (listOfFacultyEtity.length != 0)
                      ...listOfFacultyEtity.map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTile(
                              leading: ElevatedButton(
                                onPressed: () {
                                  NavigatingOnePlaceToAnotherPlace()
                                      .navigatePage(
                                          context,
                                          BlocProvider(
                                            create: (context) => EditFacultyBloc(
                                                addFacultyUsecase: AddFacultyUsecase(
                                                    repository: FacultyRepository(
                                                        dataSource:
                                                            FirebaseApiForAddFaculty()))),
                                            child: EditFaculty(
                                                facultyName: e.name,
                                                facultyEmail: e.mailId,
                                                facultyNUmber: e.mobileNumber,
                                                previoueExperience: e
                                                    .previousExperience
                                                    .toString(),
                                                subjects: e.subjects),
                                          ));
                                },
                                child: const Text("Edit"),
                              ),
                              title: Text(
                                e.name.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.black),
                              ),
                              backgroundColor:
                                  Color.fromARGB(255, 183, 214, 217),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Email :" + e.mailId,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Phone Number :" + e.mobileNumber,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(color: Colors.black),
                                    ),
                                    Text(
                                      "Subjects: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(color: Colors.black),
                                    ),
                                    ...e.subjects.map((e) => Text(
                                          e.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(color: Colors.black),
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ))
                  ],
                ),
              const FloatingBottomButtonFacultyList(),
              const FloatingBottomButtonAddStudents(),
              if (state is FacultyListLoadingState)
                const CircularProgressIndicator()
            ],
          );
        },
      ),
    );
  }
}
