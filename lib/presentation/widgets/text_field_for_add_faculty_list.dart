import 'package:flutter/material.dart';

class TextFieldForAddFacultyList extends StatelessWidget {
  const TextFieldForAddFacultyList(
      {Key? key, required this.textEditingController, required this.label})
      : super(key: key);
  final TextEditingController textEditingController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
