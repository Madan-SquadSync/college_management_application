import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/common/attendance_student_list.dart';
import 'package:nricse123/common/calculator.dart';
import 'package:nricse123/common/data_for_take_attendance.dart';
import 'package:nricse123/data/data_source/data.dart';
import 'package:nricse123/data/data_source/firebase_api_service_for_student_result.dart';
import 'package:nricse123/presentation/bloc/faculty_list_bloc/faculty_list_state.dart';
import 'package:nricse123/presentation/bloc/faculty_result_bloc/faculty_result_bloc.dart';
import 'package:nricse123/presentation/bloc/faculty_result_bloc/faculty_result_event.dart';
import 'package:nricse123/presentation/bloc/faculty_result_bloc/faculty_result_state.dart';
import 'package:nricse123/presentation/widgets/drop_button_for_take_attendance.dart';

class FacultyResult extends StatelessWidget {
  const FacultyResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    BlocProvider.of<FacultyResultBloc>(context)
        .add(FacultyResultInitialEvent(context: context));
    return BlocConsumer<FacultyResultBloc, FacultyResultState>(
      bloc: context.read<FacultyResultBloc>(),
      listener: (context, state) {},
      builder: (context, state) {
        return Stack(alignment: Alignment.center, children: [
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
                              .read<FacultyResultBloc>()
                              .add(FacultyResultUpdateUiEvent());
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
                              .read<FacultyResultBloc>()
                              .add(FacultyResultUpdateUiEvent());
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
                              context.read<FacultyResultBloc>().add(
                                  FacultyResultRetrieveStudentEvent(
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
                if (listOfStudents.isNotEmpty)
                  ...listOfStudents.map(
                    (e) => ExpansionTile(
                      title: FutureBuilder(
                          future: FirebaseApiServiceForStudentResult()
                              .retrieveStudentResults(context, e.rollNumber),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    children: [
                                      Text(
                                        e.rollNumber,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Calculator().failed(
                                              snapshot.data!.semstersResult) ==
                                          0
                                      ? Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: ShapeDecoration(
                                            color: const Color.fromARGB(
                                                255, 146, 236, 235),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          child: const Text("All Pass"),
                                        )
                                      : Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: ShapeDecoration(
                                            color: const Color.fromARGB(
                                                255, 243, 151, 118),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          child: Text(
                                              "Failed ${Calculator().failed(snapshot.data!.semstersResult)} subjects"),
                                        )
                                ],
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }),
                      children: [
                        FutureBuilder(
                          future: FirebaseApiServiceForStudentResult()
                              .retrieveStudentResults(context, e.rollNumber),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                   Text(
                                    e.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  ...snapshot.data!.semstersResult.entries
                                      .map((e) {
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ExpansionTile(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        collapsedBackgroundColor:
                                            Colors.black12,
                                        title: Row(
                                          children: [
                                            Text(
                                              e.key,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        children: [
                                          Card(
                                            color: const Color.fromARGB(
                                                173, 181, 225, 227),
                                            surfaceTintColor:
                                                const Color.fromARGB(
                                                    255, 213, 191, 191),
                                            child: SizedBox(
                                              width: widthScreen - 50,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: DataTable(
                                                        dataTextStyle:
                                                            const TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip),
                                                        decoration: ShapeDecoration(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10))),
                                                        border: TableBorder.all(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            style: BorderStyle
                                                                .solid,
                                                            color:
                                                                mainThemeLightColor),
                                                        columns: const [
                                                          DataColumn(
                                                              label: Text(
                                                                  "Subjects")),
                                                          DataColumn(
                                                              label: Text(
                                                                  "Result"))
                                                        ],
                                                        rows: [
                                                          // ignore: avoid_function_literals_in_foreach_calls
                                                          ...e.value.entries
                                                              .map(
                                                            (result) {
                                                              if (result.value
                                                                          .toString() ==
                                                                      'F' ||
                                                                  result.value
                                                                          .toString() ==
                                                                      'AB') {
                                                                // setState(() {
                                                                //   countOfFailedSubject =
                                                                //       countOfFailedSubject + 1;
                                                                //   print(countOfFailedSubject);
                                                                // });
                                                              }
                                                              return DataRow(
                                                                cells: [
                                                                  DataCell(SingleChildScrollView(
                                                                      scrollDirection:
                                                                          Axis
                                                                              .vertical,
                                                                      child: Text(
                                                                          result
                                                                              .key))),
                                                                  DataCell(Text(
                                                                      result
                                                                          .value))
                                                                ],
                                                              );
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  })
                                ],
                              );
                            } else {
                              return Text("No Data Found");
                            }
                          },
                        )
                      ],
                    ),
                  )
              ],
            ),
          ),
          if (state is FacultyListLoadingState)
            const CircularProgressIndicator()
        ]);
      },
    );
  }
}
