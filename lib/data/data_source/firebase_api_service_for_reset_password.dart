import 'package:flutter/material.dart';
import 'package:nricse123/common/data.dart';
import 'package:nricse123/presentation/widgets/functions_for_sheets_snackbar_banners.dart';

Future<void> resetPassword(BuildContext context, String email) async {
  try {
    await firebaseAuth.sendPasswordResetEmail(email: email);
    // Password reset email sent successfully
    showSnackbarScreen(context, "Password reset email sent to $email");
  } catch (e) {
    // Handle errors here, e.g., email not found, too many requests, etc.
    showSnackbarScreen(context, "Error sending password reset email: $e");
  }
}
