import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/data/data_source/data.dart';
import 'package:nricse123/presentation/bloc/result_bloc/result_bloc.dart';
import 'package:nricse123/presentation/bloc/result_bloc/result_event.dart';
import 'package:nricse123/presentation/bloc/result_bloc/result_state.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  final rollnumberController = TextEditingController();
  String selectedSemester = "I-I"; // Initialize with a default value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results Page"),
      ),
      body: BlocProvider(
        create: (context) => ResultBloc(
          studentBussinessRepository:
              ConcreteStudentBusinessRepository(), // Provide an instance of the concrete repository implementation
        ),
        child: BlocConsumer<ResultBloc, ResultState>(
          listener: (context, state) {
            // Handle state changes if needed
          },
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: rollnumberController,
                    decoration: InputDecoration(
                      labelText: "Enter Roll Number",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                DropdownButton<String>(
                  value: selectedSemester,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSemester = newValue!;
                    });
                    // Dispatch the ResultFetchingEvent with the selected semester
                    context.read<ResultBloc>().add(ResultFetchingEvent(
                          context: context,
                          rollnumber: rollnumberController.text,
                        ));
                  },
                  items: [
                    "I-I",
                    "I-II",
                    "II-I",
                    "II-II",
                    "III-I",
                    "III-II",
                    "IV-I",
                    "IV-II"
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Expanded(
                  child: BlocBuilder<ResultBloc, ResultState>(
                    builder: (context, state) {
                      if (state is ResultFetchingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ResultFetchErrorState) {
                        return Center(
                          child: Text("Error fetching data"),
                        );
                      } else if (state is ResultFetchedState) {
                        // Show the fetched result
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              studentResultEntity.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      }
                      // Show initial state or other states if needed
                      return Container();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  ConcreteStudentBusinessRepository() {}
}

void main() {
  runApp(MaterialApp(
    home: ResultsPage(),
  ));
}
