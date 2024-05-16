import 'package:flutter/material.dart';

class AddSubjectDialog  {
  Future<void> showAddSubjectDialog(BuildContext context , TextEditingController subjectController , Function() addMethod)async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Subject"),
        content: TextField(
          controller: subjectController,
          decoration: InputDecoration(
            hintText: "Subject",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        actions: [
          FilledButton.icon(
            onPressed: addMethod,
            label: const Text("Add"),
            icon: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}