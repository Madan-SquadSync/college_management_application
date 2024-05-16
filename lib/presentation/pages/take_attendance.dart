import 'package:flutter/widgets.dart';
import 'package:nricse123/common/attendance_student_list.dart';
import 'package:nricse123/common/data_for_take_attendance.dart';
import 'package:nricse123/presentation/bloc/take_attendance_bloc/take_attendance_bloc.dart';
import 'package:nricse123/presentation/bloc/take_attendance_bloc/take_attendance_event.dart';
import 'package:nricse123/presentation/bloc/take_attendance_bloc/take_attendance_state.dart';
import 'package:nricse123/presentation/widgets/drop_button_for_take_attendance.dart';
import 'package:nricse123/presentation/widgets/take_attendance_widgets/show_absent_dialog.dart';
import 'package:nricse123/presentation/widgets/take_attendance_widgets/student_attendance_contrainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class TakeAttendance extends StatelessWidget {
  const TakeAttendance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TakeAttendanceBloc>(context)
        .add(TakeAttendanceInitialEvent(context: context));
    return BlocConsumer<TakeAttendanceBloc, TakeAttendanceState>(
      bloc: context.read<TakeAttendanceBloc>(),
      listener: (context, state) {
        if (state is TakeAttendanceRetrieveingStudentLoadingState) {
          showDialog(
            context: context,
            builder: (context) => const AlertDialog(
              content: CircularProgressIndicator(),
            ),
          );
        }

        if (state is TakeAttendanceRetrieveingStudentLoadedState) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Easing.linear,
              child: ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DropButtonForTakeAttendance(
                          listOfItems: listOfBatch,
                          onChanged: (value) {
                            seletedBatch = value;
                            context
                                .read<TakeAttendanceBloc>()
                                .add(TakeAttendanceUpdateUiEvent());
                          },
                          currentItem: seletedBatch,
                          text: 'Batch',
                        ),
                      ),
                      Expanded(
                        child: DropButtonForTakeAttendance(
                          listOfItems: listOfSections,
                          onChanged: (value) {
                            seletedSection = value;
                            context
                                .read<TakeAttendanceBloc>()
                                .add(TakeAttendanceUpdateUiEvent());
                          },
                          currentItem: seletedSection,
                          text: 'Section',
                        ),
                      ),
                      Expanded(
                          child: IconButton(
                              style: const ButtonStyle(
                                  elevation: MaterialStatePropertyAll(4)),
                              onPressed: () {
                                context.read<TakeAttendanceBloc>().add(
                                    TakeAttendanceRetrieveStudentEvent(
                                        batch: seletedBatch.isEmpty
                                            ? listOfBatch[0]
                                            : seletedBatch,
                                        context: context,
                                        section: seletedSection.isEmpty
                                            ? listOfSections[0]
                                            : seletedSection));
                              },
                              icon: const Icon(Icons.search))),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropButtonForTakeAttendance(
                    listOfItems: listOfSubjects,
                    onChanged: (value) {
                      seletedSubject = value;
                      context
                          .read<TakeAttendanceBloc>()
                          .add(TakeAttendanceUpdateUiEvent());
                    },
                    currentItem: seletedSubject,
                    text: 'Subject',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MultiSelectDialogField(
                    items: listOfPeriods
                        .map((e) => MultiSelectItem(e, e))
                        .toList(),
                    listType: MultiSelectListType.CHIP,
                    onConfirm: (values) {
                      selectedPeriods = values;
                      context
                          .read<TakeAttendanceBloc>()
                          .add(TakeAttendanceUpdateUiEvent());
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (listOfStudents.isNotEmpty)
                    ...listOfStudents
                        .map((student) => StudentAttendanceContainer(
                              rollNumber: student.rollNumber,
                              name: student.name,
                              phoneNumber: student.phoneNumber,
                              key: ObjectKey(student.rollNumber),
                              isAbsent: listOfAbsentStudents.contains(student),
                              absentMethod: () {
                                context.read<TakeAttendanceBloc>().add(
                                    TakeAttendanceAddAbsentStudentEvent(
                                        student: student));
                                context
                                    .read<TakeAttendanceBloc>()
                                    .add(TakeAttendanceUpdateUiEvent());
                              },
                            )),
                  if (listOfStudents.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              ShowAbsentDialog()
                                  .show(context, listOfAbsentStudents, () {
                                context.read<TakeAttendanceBloc>().add(
                                    TakeAttendanceUploadTheAttendaceEvent(
                                        absentStudents: listOfAbsentStudents,
                                        context: context,
                                        date:
                                            '${DateTime.now().day.toString()}-${DateTime.now().month.toString()}-${DateTime.now().year.toString()}',
                                        periods: selectedPeriods,
                                        presentStudents: listOfStudents
                                            .where((element) =>
                                                !listOfAbsentStudents
                                                    .contains(element))
                                            .toList(),
                                        subject: seletedSubject,
                                        teacherName: "Madan"));
                              });
                            },
                            child: const Text("Submit"))
                      ],
                    )
                ],
              ),
            ),
            if (listOfStudents.isEmpty)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: const ShapeDecoration(
                        shape: CircleBorder(),
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://img.freepik.com/free-vector/hand-drawn-no-data-concept_52683-127823.jpg",
                          ),
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.low,
                        )),
                  ),
                  Text(
                    "No Data",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Color.fromARGB(255, 78, 183, 235),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            if (context.read<TakeAttendanceBloc>().state
                is TakeAttendanceRetrieveingStudentLoadingState)
              const CircularProgressIndicator()
          ],
        );
      },
    );
  }
}
