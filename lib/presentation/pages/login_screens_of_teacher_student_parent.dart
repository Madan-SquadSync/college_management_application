import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nricse123/common/check_the_login_user.dart';
import 'package:nricse123/data/data_source/data.dart';
import 'package:nricse123/data/data_source/firebase_api_service_for_login.dart';
import 'package:nricse123/data/data_source/firebase_api_service_for_signup.dart';
import 'package:nricse123/presentation/pages/forgot_password.dart';
import 'package:nricse123/presentation/pages/login_admin_screen.dart';
import 'package:nricse123/presentation/widgets/Navigating_one_place_to_another_place.dart';
import 'package:nricse123/presentation/widgets/functions_for_sheets_snackbar_banners.dart';

class LoginScreensOfTeacherStudentParent extends StatefulWidget {
  const LoginScreensOfTeacherStudentParent({Key? key}) : super(key: key);

  @override
  _LoginScreensOfTeacherStudentParentState createState() =>
      _LoginScreensOfTeacherStudentParentState();
}

class _LoginScreensOfTeacherStudentParentState
    extends State<LoginScreensOfTeacherStudentParent> {
  var currentRole;
  var sizeOfIcons = 60.0;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isSignUp = false;
  var isPasswordHidded = true;
  var currentUser = "";
  @override
  void initState() {
    currentRole = 0;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const AdminLoginScreen(),
                  ),
                );
              },
              child: const Text("Admin"))
        ],
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SafeArea(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          Text(
                            "Welcome...!",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    color: const Color.fromARGB(
                                        255, 134, 123, 206),
                                    fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...listOFUsers.map((e) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          currentRole = listOFUsers.indexOf(e);
                        });
                      },
                      child: Container(
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                side: BorderSide(
                                    width: 3,
                                    style: BorderStyle.solid,
                                    strokeAlign: 10,
                                    color: currentRole == listOFUsers.indexOf(e)
                                        ? const Color.fromARGB(
                                            255, 134, 123, 206)
                                        : Colors.white))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (e.toString() == 'Teacher')
                                Image.asset(
                                  "asserts/images/teacher.png",
                                  width: sizeOfIcons,
                                  height: sizeOfIcons,
                                ),
                              if (e.toString() == 'Student')
                                Image.asset(
                                  "asserts/images/graduated.png",
                                  width: sizeOfIcons,
                                  height: sizeOfIcons,
                                ),
                              if (e.toString() == 'Parent')
                                Image.asset(
                                  "asserts/images/parents.png",
                                  width: sizeOfIcons,
                                  height: sizeOfIcons,
                                ),
                              Text(
                                e.toString(),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      side: BorderSide(color: Colors.black),
                    ),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            label: Text("E-mail"),
                            suffixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: isPasswordHidded,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            label: const Text("Password"),
                            labelStyle: const TextStyle(
                                overflow: TextOverflow.ellipsis),
                            suffixIcon: isPasswordHidded
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isPasswordHidded = false;
                                      });
                                    },
                                    child: const Icon(Icons.remove_red_eye))
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isPasswordHidded = true;
                                      });
                                    },
                                    child: const Icon(
                                        Icons.remove_red_eye_outlined)),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () async {
                              print(currentRole);
                              print(CheckTheUser().checkUser(currentRole));
                              bool result = isSignUp
                                  // ignore: use_build_context_synchronously
                                  ? currentRole == 0
                                      // ignore: use_build_context_synchronously
                                      ? await FirebaseApiServiceForLogin()
                                          .login_email_password(
                                              context,
                                              emailController.text,
                                              passwordController.text,
                                              CheckTheUser()
                                                  .checkUser(currentRole))
                                      // ignore: use_build_context_synchronously
                                      : await FirebaseApiServiceForSignup()
                                          .register_email_password(
                                              context,
                                              emailController.text,
                                              passwordController.text,
                                              CheckTheUser()
                                                  .checkUser(currentRole))
                                  // ignore: use_build_context_synchronously
                                  : await FirebaseApiServiceForLogin()
                                      .login_email_password(
                                          context,
                                          emailController.text,
                                          passwordController.text,
                                          CheckTheUser()
                                              .checkUser(currentRole));
                              if (result) {
                                isSignUp && currentRole != 0
                                    // ignore: use_build_context_synchronously
                                    ? showSnackbarScreen(context,
                                        "Account create Successfully Completed")
                                    // ignore: use_build_context_synchronously
                                    : showSnackbarScreen(context,
                                        "Login Successfully Completed");
                              }
                            },
                            child: isSignUp && currentRole != 0
                                ? const Text("SignUp")
                                : const Text("Login"),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AnimatedSize(
                          duration: const Duration(seconds: 1),
                          child: currentRole == 0
                              ? TextButton(
                                  onPressed: () {
                                    NavigatingOnePlaceToAnotherPlace()
                                        .navigatePage(
                                            context, const ForgotPassword());
                                  },
                                  child: const Text("Forgot Password"))
                              : isSignUp
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              isSignUp = false;
                                            });
                                          },
                                          child: const Text(
                                              "Already I have a account"),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              NavigatingOnePlaceToAnotherPlace()
                                                  .navigatePage(context,
                                                      const ForgotPassword());
                                            },
                                            child:
                                                const Text("Forgot Password")),
                                        TextButton(
                                          onPressed: () {
                                            setState(
                                              () {
                                                isSignUp = true;
                                              },
                                            );
                                          },
                                          child: const Text("Sign Up"),
                                        ),
                                      ],
                                    ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
