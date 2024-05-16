import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/common/attendance_student_list.dart';
import 'package:nricse123/common/data_for_attendance_status.dart';
import 'package:nricse123/common/data_for_take_attendance.dart';
import 'package:nricse123/common/phone_call.dart';
import 'package:nricse123/data/data_source/firebase_api_for_check_attendance.dart';
import 'package:nricse123/presentation/bloc/attendance_status_bloc/attendance_status_bloc.dart';
import 'package:nricse123/presentation/bloc/attendance_status_bloc/attendance_status_event.dart';
import 'package:nricse123/presentation/bloc/attendance_status_bloc/attendance_status_state.dart';
import 'package:nricse123/presentation/widgets/drop_button_for_take_attendance.dart';

class AttendanceStatus extends StatelessWidget {
  const AttendanceStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AttendanceStatusBloc>(context)
        .add(AttendanceStatusInitialEvent(context: context));
    return BlocConsumer<AttendanceStatusBloc, AttendanceStatusState>(
      bloc: context.read<AttendanceStatusBloc>(),
      listener: (context, state) {},
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
                                .read<AttendanceStatusBloc>()
                                .add(AttendanceStatusUpdateUiEvent());
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
                                .read<AttendanceStatusBloc>()
                                .add(AttendanceStatusUpdateUiEvent());
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
                                context.read<AttendanceStatusBloc>().add(
                                    AttendanceStatusRetrieveStudentEvent(
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
                  ElevatedButton(
                      onPressed: () async {
                        await showDatePicker(
                                context: context,
                                firstDate: DateTime(2000),
                                initialDate: DateTime.now(),
                                currentDate: selectedDateTime,
                                lastDate: DateTime(2025))
                            .then((dateTime) {
                          context.read<AttendanceStatusBloc>().add(
                                AttendanceStatusPickDateTimeEvent(
                                  dateTime: dateTime!,
                                ),
                              );
                        });
                      },
                      child: Text(
                          '${selectedDateTime.day}-${selectedDateTime.month}-${selectedDateTime.year}')),
                  const SizedBox(
                    height: 10,
                  ),
                  ...listOfStudents.map((e) => FutureBuilder(
                        future: FirebaseApiForCheckAttendance().checkAttendance(
                            context,
                            e.rollNumber,
                            '${selectedDateTime.day}-${selectedDateTime.month}-${selectedDateTime.year}'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                ExpansionTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(e.rollNumber),
                                      snapshot.data == true
                                          ? Container(
                                              decoration: ShapeDecoration(
                                                  color: Colors.lightBlue,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20))),
                                              child: const Text("Present"))
                                          : Container(
                                              decoration: ShapeDecoration(
                                                  color: Color.fromARGB(
                                                      255, 223, 173, 151),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20))),
                                              child: const Text("Absent"))
                                    ],
                                  ),
                                  children: [
                                    Text(
                                      e.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(color: Colors.black),
                                    ),
                                    Text(e.parentPhoneNumber),
                                    ElevatedButton.icon(
                                        onPressed: () async {
                                          final result = await PhoneCall()
                                              .call(e.parentPhoneNumber);
                                          print(result);
                                        },
                                        icon: const Icon(
                                          Icons.call,
                                          color: Colors.green,
                                        ),
                                        label: Text("Call"))
                                  ],
                                )
                              ],
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ))
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
