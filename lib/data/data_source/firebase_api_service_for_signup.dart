import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nricse123/common/data.dart';
import 'package:nricse123/presentation/widgets/functions_for_sheets_snackbar_banners.dart';

class FirebaseApiServiceForSignup {
  Future<bool> register_email_password(BuildContext context,
      String emailAddress, String password, String whoAreYou) async {
    print("Madan");
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      // ignore: use_build_context_synchronously
      showSnackbarScreen(context, "Successfully Register The User");
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // ignore: use_build_context_synchronously
        showSnackbarScreen(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // ignore: use_build_context_synchronously
        showSnackbarScreen(
            context, "The account already exists for that email.");
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackbarScreen(context, e.toString());
    }
    return false;
  }
}
