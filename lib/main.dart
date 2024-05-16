import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/data/data_source/firebase_api_service_for_login.dart';
import 'package:nricse123/firebase_options.dart';
import 'package:nricse123/presentation/bloc/admin_draw_main_screen_bloc/admin_draw_main_screen_bloc.dart';
import 'package:nricse123/presentation/bloc/faculty_draw_main_screen_bloc/faculty_draw_main_screen_bloc.dart';
import 'package:nricse123/presentation/bloc/student_draw_main_screen_bloc/student_draw_main_screen_bloc.dart';
import 'package:nricse123/presentation/pages/admin_drawer_main_screen.dart';
import 'package:nricse123/presentation/pages/faculty_drawer_main_screen.dart';
import 'package:nricse123/presentation/pages/login_screens_of_teacher_student_parent.dart';
import 'package:nricse123/presentation/pages/parent_draw_main_screen.dart';
import 'package:nricse123/presentation/pages/student_draw_main_screen.dart';
import 'package:nricse123/presentation/pages/waiting_screen.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    scrollBehavior: const MaterialScrollBehavior()
        .copyWith(dragDevices: PointerDeviceKind.values.toSet()),
    theme: ThemeData(
      useMaterial3: true,
    ),
    home: FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return FutureBuilder(
              future: FirebaseApiServiceForLogin().isLoggedIn(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const WaitingScreen();
                } else {
                  var result = snapshot.data;
                  Widget screen = const LoginScreensOfTeacherStudentParent();
                  if (result == 0) {
                    screen = BlocProvider(
                      create: (context) => AdminDrawMainScreenBloc(),
                      child: const AdminDrawerMainScreen(),
                    );
                  } else if (result == 1) {
                    screen = BlocProvider(
                      create: (context) => FacultyDrawMainScreenBloc(),
                      child: const FacultyDrawerMainScreen(),
                    );
                  } else if (result == 2) {
                    screen = BlocProvider(
                      create: (context) => StudentDrawMainScreenBloc(),
                      child: const StudentDrawMainScreen(),
                    );
                  } else if (result == 3) {
                    screen = const ParentDrawMainScreen();
                  } else if (result == 4) {
                    screen = const LoginScreensOfTeacherStudentParent();
                  }
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    switchInCurve: Curves.easeInOut,
                    switchOutCurve: Curves.easeInOut,
                    transitionBuilder: (child, animation) {
                      return DecoratedBoxTransition(
                        decoration: animation.drive(
                          DecorationTween(
                            begin: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.blue, Colors.green],
                              ),
                            ),
                            end: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.green, Colors.red],
                              ),
                            ),
                          ),
                        ),
                        child: child,
                      );
                    },
                    child: screen,
                  );
                }
              },
            );
          case ConnectionState.waiting:
            return const WaitingScreen();
          default:
            return const WaitingScreen();
        }
      },
    ),
  ));
}


 