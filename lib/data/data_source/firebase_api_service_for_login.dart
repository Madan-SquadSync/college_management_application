import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nricse123/common/data.dart';
import 'package:nricse123/presentation/pages/admin_drawer_main_screen.dart';
import 'package:nricse123/presentation/pages/faculty_drawer_main_screen.dart';
import 'package:nricse123/presentation/pages/parent_draw_main_screen.dart';
import 'package:nricse123/presentation/pages/student_draw_main_screen.dart';
import 'package:nricse123/presentation/widgets/Navigating_one_place_to_another_place.dart';
import 'package:nricse123/presentation/widgets/functions_for_sheets_snackbar_banners.dart';
import 'package:shared_preferences/shared_preferences.dart';



class FirebaseApiServiceForLogin {
  Future<bool> login_email_password(BuildContext context, String emailAddress,
      String password, String whoAreYou) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(whoAreYou, true);
      // ignore: use_build_context_synchronously
      showSnackbarScreen(context, "Successfully login into the Login");
      bool isAdmin = whoAreYou == 'isAdmin';
      bool isFaculty = whoAreYou == 'isFaculty';
      bool isStudent = whoAreYou == 'isStudent';
      var selectDestination = isAdmin
          ? const AdminDrawerMainScreen()
          : isFaculty
              ? const FacultyDrawerMainScreen()
              : isStudent
                  ? const StudentDrawMainScreen()
                  : const ParentDrawMainScreen();

      // ignore: use_build_context_synchronously
      NavigatingOnePlaceToAnotherPlace()
          .navigatePageDeletePervious(context, selectDestination);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        (context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print(emailAddress);
        print(password);
        // ignore: use_build_context_synchronously
        showSnackbarScreen(context, 'Wrong password provided for that user.');
      } else {
        // ignore: use_build_context_synchronously
        showSnackbarScreen(context, e.toString());
      }
    }
    return false;
  }

  Future<int> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isAdmin') ?? false) {
      return 0;
    } else if (prefs.getBool('isFaculty') ?? false) {
      return 1;
    } else if (prefs.getBool('isStudent') ?? false) {
      return 2;
    } else if (prefs.getBool('isParent') ?? false) {
      return 3;
    }
    return 4;
  }
}


