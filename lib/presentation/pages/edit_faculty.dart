import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:nricse123/common/data_for_add_faculty.dart';
import 'package:nricse123/data/data_source/add_subjects_to_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nricse123/bussiness/entites/faculty_data_entity.dart';
import 'package:nricse123/common/custom_snack_bar.dart';
import 'package:nricse123/presentation/bloc/edit_faculty_bloc/edit_faculty_bloc.dart';
import 'package:nricse123/presentation/bloc/edit_faculty_bloc/edit_faculty_event.dart';
import 'package:nricse123/presentation/bloc/edit_faculty_bloc/edit_faculty_state.dart';

import 'package:nricse123/presentation/widgets/add_faculty_widgets/add_subject_dialog.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:nricse123/presentation/widgets/text_field_for_add_faculty_list.dart';

class EditFaculty extends StatefulWidget {
  const EditFaculty(
      {Key? key,
      required this.facultyName,
      required this.facultyEmail,
      required this.facultyNUmber,
      required this.previoueExperience,
      required this.subjects})
      : super(key: key);
  final String facultyName;
  final String facultyEmail;
  final String facultyNUmber;
  final String previoueExperience;
  final List<String> subjects;

  @override
  State<EditFaculty> createState() => _EditFacultyState();
}

class _EditFacultyState extends State<EditFaculty> {
  TextEditingController facultyNameController = TextEditingController();
  TextEditingController facultyEmailController = TextEditingController();
  TextEditingController facultyNumberController = TextEditingController();
  TextEditingController previousExperienceController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  List<String> allSubjects = [];

  @override
  void initState() {
    super.initState();
    facultyNameController = TextEditingController(text: widget.facultyName);
    facultyEmailController = TextEditingController(text: widget.facultyEmail);
    facultyNumberController = TextEditingController(text: widget.facultyNUmber);
    previousExperienceController =
        TextEditingController(text: widget.previoueExperience);
    allSubjects.clear();
    _loadSubjects();
  }

  void _loadSubjects() async {
    List<String> subjects = await AddSubjectsToFirebase().retrieveSubjects();
    setState(() {
      allSubjects = subjects;
      selectedSubjects = widget.subjects; 
    });
  }

  @override
  void dispose() {
    subjectController.dispose();
    facultyEmailController.dispose();
    facultyNameController.dispose();
    facultyNumberController.dispose();
    previousExperienceController.dispose();
    selectedSubjects = [];
    allSubjects = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Faculty "),
      ),
      body: RefreshIndicator(
        color: Colors.blue,
        onRefresh: () async {
          _loadSubjects();
          return Future<void>.delayed(const Duration(seconds: 3));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: BlocConsumer<EditFacultyBloc, EditFacultyState>(
              bloc: context.read<EditFacultyBloc>(),
              listener: (context, state) {},
              builder: (context, state) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    if (state == EditFacultyLoading)
                      const CircularProgressIndicator(),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFieldForAddFacultyList(
                          label: "Faculty Name",
                          textEditingController: facultyNameController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldForAddFacultyList(
                          label: "Faculty Email",
                          textEditingController: facultyEmailController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldForAddFacultyList(
                          label: "Faculty Phone Number",
                          textEditingController: facultyNumberController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldForAddFacultyList(
                          label: "Faculty Previous Experience",
                          textEditingController: previousExperienceController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (allSubjects.isNotEmpty)
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Expanded(
                                  child: MultiSelectDialogField(
                                    items: allSubjects
                                        .map((subject) =>
                                            MultiSelectItem<String>(
                                                subject, subject))
                                        .toList(),
                                    initialValue: selectedSubjects,
                                    listType: MultiSelectListType.CHIP,
                                    onConfirm: (values) {
                                      context.read<EditFacultyBloc>().add(
                                          EditFacultySelectedSubjectsEvent(
                                              subjects:
                                                  List<String>.from(values)));
                                    },
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      AddSubjectDialog().showAddSubjectDialog(
                                          context,
                                          subjectController,
                                          () => context
                                              .read<EditFacultyBloc>()
                                              .add(EditFacultyAddSubjectEvent(
                                                  subject:
                                                      subjectController.text,
                                                  context: context)));
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ))
                              ],
                            ),
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                final isFacultyNameNotNull =
                                    facultyNameController.text.isNotEmpty;
                                final isFacultyEmailNotNull =
                                    facultyEmailController.text.isNotEmpty;
                                final isFacultyNumberMustBeTenCharacters =
                                    facultyNumberController.text.length == 10;
                                final isPreviousExperienceNotNull =
                                    previousExperienceController
                                        .text.isNotEmpty;

                                if (isFacultyNameNotNull &&
                                    isFacultyEmailNotNull &&
                                    isFacultyNumberMustBeTenCharacters &&
                                    isPreviousExperienceNotNull) {
                                  context.read<EditFacultyBloc>().add(
                                        EditFacultyButtonPressed(
                                          context,
                                          facultyEntity: FacultyEntity(
                                            name: facultyNameController.text,
                                            previousExperience: int.parse(
                                                previousExperienceController
                                                    .text),
                                            mobileNumber:
                                                facultyNumberController.text,
                                            mailId: facultyEmailController.text,
                                            subjects: selectedSubjects,
                                          ),
                                        ),
                                      );

                                  facultyEmailController.clear();
                                  facultyNameController.clear();
                                  facultyNumberController.clear();
                                  previousExperienceController.clear();
                                } else {
                                  CustomSnackBar()
                                      .show(context, "Invalid Input");
                                }
                              },
                              child: const Text("Add"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
