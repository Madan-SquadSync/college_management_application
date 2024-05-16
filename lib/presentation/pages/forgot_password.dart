import 'package:flutter/material.dart';
import 'package:nricse123/common/custom_snack_bar.dart';
import 'package:nricse123/common/data.dart';
import 'package:nricse123/presentation/widgets/text_field_for_add_faculty_list.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFieldForAddFacultyList(
              textEditingController: emailController,
              label: "Email",
            ),
            FilledButton(
              onPressed: () async {
                if (emailController.text.isNotEmpty) {
                  await firebaseAuth.sendPasswordResetEmail(
                      email: emailController.text);
                  CustomSnackBar().show(context,
                      "Please check!, Reset email sended for your Mail ");
                }
              },
              child: const Text("Send"),
            )
          ],
        ),
      ),
    );
  }
}
