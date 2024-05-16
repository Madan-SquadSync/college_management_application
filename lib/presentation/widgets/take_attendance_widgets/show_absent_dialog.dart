import 'package:flutter/material.dart';
import 'package:nricse123/bussiness/entites/student.dart';

class ShowAbsentDialog  {
  void show(
    BuildContext context,
    List<Student> listOfAbsentStudents,
    Function() acceptMethod
  ){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Absenties",
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...listOfAbsentStudents.map((student) => Container(
                  child: Text(student.rollNumber),
                ))
          ],
        ),
        actions: [
          FilledButton.icon(
              onPressed: acceptMethod,
              icon: const Icon(Icons.upload_outlined),
              label: const Text("Accept"))
        ],
      ),
    );
  }
}