import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/bussiness/repository/student_bussiness_repository.dart';
import 'package:nricse123/bussiness/usecase/retrieve_student_daily_attendance_repository.dart';
import 'package:nricse123/common/data.dart';
import 'package:nricse123/common/data_for_student_draw_main_screen.dart';
import 'package:nricse123/data/data_source/data.dart';
import 'package:nricse123/data/data_source/firebase_api_service_for_student_result.dart';
import 'package:nricse123/data/repository/student_result_repository.dart';
import 'package:nricse123/data/repository/student_today_attendance_data_repository.dart';
import 'package:nricse123/presentation/bloc/student_draw_main_screen_bloc/student_draw_main_screen_bloc.dart';
import 'package:nricse123/presentation/bloc/student_draw_main_screen_bloc/student_draw_main_screen_event.dart';
import 'package:nricse123/presentation/bloc/student_draw_main_screen_bloc/student_draw_main_screen_state.dart';
import 'package:nricse123/presentation/bloc/student_result_bloc/student_result_bloc.dart';
import 'package:nricse123/presentation/bloc/today_attendance_bloc/today_attendance_bloc.dart';
import 'package:nricse123/presentation/pages/login_screens_of_teacher_student_parent.dart';
import 'package:nricse123/presentation/pages/student_pages/student_result.dart';
import 'package:nricse123/presentation/pages/student_pages/today_attendance.dart';
import 'package:nricse123/presentation/widgets/Navigating_one_place_to_another_place.dart';
import 'package:nricse123/presentation/widgets/functions_for_sheets_snackbar_banners.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentDrawMainScreen extends StatefulWidget {
  const StudentDrawMainScreen({Key? key}) : super(key: key);

  @override
  State<StudentDrawMainScreen> createState() => _StudentDrawMainScreenState();
}

class _StudentDrawMainScreenState extends State<StudentDrawMainScreen> {
  StudentDrawMainScreenBloc studentDrawMainScreenBloc =
      StudentDrawMainScreenBloc();

  @override
  void initState() {
    studentDrawMainScreenBloc
        .add(StudentDrawMainScreenInitialEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentDrawMainScreenBloc, StudentDrawMainScreenState>(
      bloc: studentDrawMainScreenBloc,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            drawer: Drawer(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: mainThemeColor),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: SafeArea(
                child: AnimatedSize(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const CircleAvatar(
                            foregroundImage:
                                AssetImage("asserts/images/admin.png"),
                            radius: 50),
                        Text(
                          studentModel.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          studentModel.rollNumber,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            appBar: AppBar(
              title: Text(studentModel.rollNumber),
              actions: [
                TextButton(
                    onPressed: () async {
                      await firebaseAuth.signOut();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool('isStudent', false);
                      // ignore: use_build_context_synchronously
                      showSnackbarScreen(context, "Sign Out Successfully");
                      // ignore: use_build_context_synchronously
                      NavigatingOnePlaceToAnotherPlace()
                          .navigatePageDeletePervious(context,
                              const LoginScreensOfTeacherStudentParent());
                    },
                    child: const Text("Log out"))
              ],
            ),
            body: ListView(
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      NavigatingOnePlaceToAnotherPlace().navigatePage(
                          context,
                          BlocProvider(
                            create: (context) => TodayAttendanceBloc(
                                retrieveStudentDailyAttendanceRepository:
                                    RetrieveStudentDailyAttendanceRepository(
                                        todayAttendanceBusinessRepository:
                                            StudentTodayAttendanceDataRepository())),
                            child: const TodayAttendance(),
                          ));
                    },
                    icon: const Icon(Icons.co_present_sharp),
                    label: const Text("Today Attendance")),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      NavigatingOnePlaceToAnotherPlace().navigatePage(
                          context,
                          BlocProvider(
                            create: (context) => StudentResultBloc(
                                studentBussinessRepository:
                                    StudentResultRepository(
                                        firebaseApiServiceForStudentResult:
                                            FirebaseApiServiceForStudentResult())),
                            child: const StudentResult(),
                          ));
                    },
                    icon: const Icon(Icons.real_estate_agent_outlined),
                    label: const Text("Result")),
                const SizedBox(
                  height: 20,
                ),
              ],
            ));
      },
    );
  }
}
