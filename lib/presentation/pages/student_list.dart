import 'package:flutter/material.dart';
import 'package:nricse123/presentation/widgets/floating_bottom_button_add_students.dart';
import 'package:nricse123/presentation/widgets/floating_bottom_button_faculty_list.dart';

class StudentList extends StatelessWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Column(
            children: [],
          ),
          FloatingBottomButtonFacultyList(),
          FloatingBottomButtonAddStudents()
        ],
      ),
    );
  }
}
