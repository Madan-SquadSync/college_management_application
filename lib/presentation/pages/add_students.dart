import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/data/data_source/working_excel.dart';
import 'package:nricse123/presentation/bloc/add_students_bloc/add_students_bloc.dart';
import 'package:nricse123/presentation/bloc/add_students_bloc/add_students_event.dart';
import 'package:nricse123/presentation/bloc/add_students_bloc/add_students_state.dart';

class AddStudents extends StatelessWidget {
  const AddStudents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WorkingExcel workingExcel = WorkingExcel();

    const sizeBoxHeight = SizedBox(
      height: 10,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add  Students"),
      ),
      body: Center(
        child: BlocConsumer<AddStudentsBloc, AddStudentsState>(
          bloc: context.read<AddStudentsBloc>(),
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () async {
                    await workingExcel.pickFile(context).then((value) {
                      context
                          .read<AddStudentsBloc>()
                          .add(AddStudentsUploadDataEvent(filename: value));
                    });
                  },
                  child: Text(
                    context.read<AddStudentsBloc>().state.filename,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Hero(
                    tag: "fillbutton",
                    child: FilledButton(
                        onPressed: () {
                          context
                              .read<AddStudentsBloc>()
                              .add(AddStudentUploadDataIntoFirebaseEvent(context: context));
                        }, child: const Text("Enter"))),
                sizeBoxHeight,
              ],
            );
          },
        ),
      ),
    );
  }
}
