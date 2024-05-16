import 'package:flutter/material.dart';
import 'package:nricse123/common/data.dart';
import 'package:nricse123/presentation/pages/login_screens_of_teacher_student_parent.dart';
import 'package:nricse123/presentation/widgets/functions_for_sheets_snackbar_banners.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ParentDrawMainScreen extends StatelessWidget {
  const ParentDrawMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Parent"),
        actions: [
          TextButton(
              onPressed: () async {
                await firebaseAuth.signOut();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isParent', false);
                // ignore: use_build_context_synchronously
                showSnackbarScreen(context, "Sign Out Successfully");
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (ctx) =>
                        const LoginScreensOfTeacherStudentParent()));
              },
              child: const Text("Log out"))
        ],
      ),
    );
  }
}
