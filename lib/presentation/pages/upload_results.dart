import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/common/custom_snack_bar.dart';
import 'package:nricse123/data/data_source/data.dart';
import 'package:nricse123/data/data_source/working_excel.dart';
import 'package:nricse123/presentation/bloc/upload_result_bloc/upload_result_bloc.dart';
import 'package:nricse123/presentation/bloc/upload_result_bloc/upload_result_event.dart';
import 'package:nricse123/presentation/bloc/upload_result_bloc/upload_result_state.dart';

class UploadResults extends StatefulWidget {
  const UploadResults({Key? key}) : super(key: key);

  @override
  _UploadResultsState createState() => _UploadResultsState();
}

class _UploadResultsState extends State<UploadResults> {
  String? sem;
  String filePath = "";
  String fileName = '';
  WorkingExcel workingExcel = WorkingExcel();

  @override
  void dispose() {
    ListOfOutput.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Result"),
      ),
      body: BlocConsumer<UploadResultBloc, UploadResultState>(
        bloc: context.read<UploadResultBloc>(),
        listener: (context, state) {},
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Note: The Excel Sheet Columns Formate must be Roll numbers , Subjects , Grades",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            child: Text(fileName.length == 0
                                ? "Enter Excel File"
                                : fileName.toString()),
                            onPressed: () async {
                              await workingExcel
                                  .pickFile(context)
                                  .then((value) async {
                                setState(() {
                                  fileName = workingExcel
                                      .resultPicker.files.first.name;
                                });
                                await workingExcel.readExcelDataConvertIntoList(
                                    context, filePath);
                                context
                                    .read<UploadResultBloc>()
                                    .add(UploadResultInitialEvent());
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 200,
                          child: DropdownButton(
                            dropdownColor: mainThemeColor.withOpacity(0.5),
                            isExpanded: true,
                            hint: const Text("Select the Semester"),
                            value: sem,
                            borderRadius: BorderRadius.circular(10),
                            items: [
                              "I-I",
                              "I-II",
                              "II-I",
                              "II-II",
                              "III-I",
                              "III-II",
                              "IV-I",
                              "IV-II"
                            ]
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e.toString(),
                                    child: Text(
                                      e.toString(),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                sem = value.toString();
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FilledButton(
                          onPressed: () async {
                            if (ListOfOutput.length != 0 && sem!.length != 0) {
                              context.read<UploadResultBloc>().add(
                                  UploadResultStartEvent(
                                      context: context, semester: sem!));
                            } else {
                              CustomSnackBar().show(context, "Invaild Inputs");
                            }
                          },
                          child: const Text("Enter"),
                        ),
                        if (context.read<UploadResultBloc>().state.count != 0)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: LinearProgressIndicator(
                              value:
                                  context.read<UploadResultBloc>().state.count /
                                      100,
                              color: mainThemeColor,
                              backgroundColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        // ignore: prefer_interpolation_to_compose_strings
                        if (context.read<UploadResultBloc>().state.count != 0)
                          Text(
                              "${context.read<UploadResultBloc>().state.count.toString()}%")
                      ],
                    ),
                  ),
                ),
              ),
              if (state is UploadResultLoadingState)
                const CircularProgressIndicator(
                  color: Colors.blue,
                )
            ],
          );
        },
      ),
    );
  }
}
