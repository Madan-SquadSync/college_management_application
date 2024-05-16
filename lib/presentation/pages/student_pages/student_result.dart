import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/common/data_for_student_draw_main_screen.dart';
import 'package:nricse123/data/data_source/data.dart';
import 'package:nricse123/presentation/bloc/student_result_bloc/student_result_bloc.dart';
import 'package:nricse123/presentation/bloc/student_result_bloc/student_result_event.dart';
import 'package:nricse123/presentation/bloc/student_result_bloc/student_result_state.dart';

class StudentResult extends StatelessWidget {
  const StudentResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<StudentResultBloc>(context).add(StudentResultInitialEvent(
      context: context,
      rollNumber: studentModel.rollNumber,
    ));
    final widthScreen = MediaQuery.of(context).size.width;
    return BlocConsumer<StudentResultBloc, StudentResultState>(
      bloc: context.read<StudentResultBloc>(),
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('${studentModel.rollNumber} results'),),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: ListView(
              children: [
                if (studentResultEntity.semstersResult.length != 0)
                  ...studentResultEntity.semstersResult.entries.map((e) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ExpansionTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        collapsedBackgroundColor: Colors.black12,
                        title: Text(
                          e.key,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        children: [
                          Card(
                            color: Color.fromARGB(173, 181, 225, 227),
                            surfaceTintColor: const Color.fromARGB(255, 213, 191, 191),
                            child: SizedBox(
                              width: widthScreen - 50,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
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
                          ),
                        ],
                      ),
                    );
                  }),
              ],
            ),
          ),
        );
      },
    );
  }
}
