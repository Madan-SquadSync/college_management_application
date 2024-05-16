import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/bussiness/usecase/upload_student_results_usecase.dart';
import 'package:nricse123/data/data_source/data.dart';
import 'package:nricse123/data/data_source/firebase_api_service_for_student_result.dart';
import 'package:nricse123/data/repository/student_result_repository.dart';
import 'package:nricse123/presentation/bloc/result_bloc/result_bloc.dart';
import 'package:nricse123/presentation/bloc/result_bloc/result_event.dart';
import 'package:nricse123/presentation/bloc/result_bloc/result_state.dart';
import 'package:nricse123/presentation/bloc/upload_result_bloc/upload_result_bloc.dart';
import 'package:nricse123/presentation/pages/upload_results.dart';

class Results extends StatefulWidget {
  const Results({Key? key}) : super(key: key);

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  final rollnumberController = TextEditingController();
  late final ResultBloc resultBloc;
  late String selectedYear;
  late String selectedSemester;

  @override
  void initState() {
    resultBloc = ResultBloc(
        studentBussinessRepository: StudentResultRepository(
            firebaseApiServiceForStudentResult:
                FirebaseApiServiceForStudentResult()));
    resultBloc.add(ResultIntializedEvent());
    selectedYear = 'I st year';
    selectedSemester = 'I-I';
    super.initState();
  }

  @override
  void dispose() {
    rollnumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: BlocConsumer<ResultBloc, ResultState>(
          bloc: resultBloc,
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: rollnumberController,
                          decoration: InputDecoration(
                              label: const Text("Roll Number"),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: InkWell(
                                    onTap: () {
                                      resultBloc.add(ResultFetchingEvent(
                                        context: context,
                                        rollnumber: rollnumberController.text,
                                      ));
                                    },
                                    child: const Icon(
                                      Icons.search,
                                      size: 30,
                                    )),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide())),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => BlocProvider(
                                    create: (context) => UploadResultBloc(
                                        uploadStudentResultsUseCase:
                                            UploadStudentResultsUseCase(
                                                studentBussinessRepository:
                                                    StudentResultRepository(
                                                        firebaseApiServiceForStudentResult:
                                                            FirebaseApiServiceForStudentResult()))),
                                    child: const UploadResults(),
                                  ),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.add,
                              size: 30,
                            )),
                      )
                    ],
                  ),
                ),

                Text(
                  studentResultEntity.name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (studentResultEntity.semstersResult.length != 0)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...studentResultEntity.semstersResult.entries.map((e) {
                          return Card(
                            color: Colors.white,
                            surfaceTintColor: Colors.white,
                            child: SizedBox(
                              width: widthScreen - 50,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    e.key,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: DataTable(
                                        dataTextStyle: const TextStyle(
                                            overflow: TextOverflow.clip),
                                        decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        border: TableBorder.all(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            style: BorderStyle.solid,
                                            color: mainThemeLightColor),
                                        columns: const [
                                          DataColumn(label: Text("Subjects")),
                                          DataColumn(label: Text("Result"))
                                        ],
                                        rows: [
                                          // ignore: avoid_function_literals_in_foreach_calls
                                          ...e.value.entries.map(
                                            (result) {
                                              if (result.value.toString() ==
                                                      'F' ||
                                                  result.value.toString() ==
                                                      'AB') {
                                                // setState(() {
                                                //   countOfFailedSubject =
                                                //       countOfFailedSubject + 1;
                                                //   print(countOfFailedSubject);
                                                // });
                                              }
                                              return DataRow(
                                                cells: [
                                                  DataCell(
                                                      SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          child: Text(
                                                              result.key))),
                                                  DataCell(Text(result.value))
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
                          );
                        })
                      ],
                    ),
                  ),

                // if (studentResultEntity.semstersResult.length != 0)
                //   Text(
                //     // ignore: prefer_interpolation_to_compose_strings
                //     "Total Number of Fail Subjects is " +
                //         countOfFailedSubject.toString(),
                //     style: Theme.of(context).textTheme.titleSmall,
                //   ),
              ],
            );
          },
        ),
      ),
    );
  }
}
