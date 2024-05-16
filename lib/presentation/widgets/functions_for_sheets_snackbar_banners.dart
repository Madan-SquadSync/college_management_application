import 'package:flutter/material.dart';

void showSnackbarScreen(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message.toString(),
      ),
    ),
  );
}
