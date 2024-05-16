import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/bussiness/usecase/retrieve_students_for_attendance_usecase.dart';
import 'package:nricse123/bussiness/usecase/upload_attendance_usecase.dart';
import 'package:nricse123/common/data.dart';
import 'package:nricse123/common/heading_current_state.dart';
import 'package:nricse123/data/data_source/firebase_api_for_upload_attendance.dart';
import 'package:nricse123/data/data_source/firebase_api_retrieve_students_for_attendance.dart';
import 'package:nricse123/data/repository/retrieve_student_models_for_attendance.dart';
import 'package:nricse123/data/repository/student_attandence_upload_data_repository.dart';
import 'package:nricse123/presentation/bloc/attendance_status_bloc/attendance_status_bloc.dart';
import 'package:nricse123/presentation/bloc/faculty_draw_main_screen_bloc/faculty_draw_main_screen_bloc.dart';
import 'package:nricse123/presentation/bloc/faculty_draw_main_screen_bloc/faculty_draw_main_screen_event.dart';
import 'package:nricse123/presentation/bloc/faculty_draw_main_screen_bloc/faculty_draw_main_screen_state.dart';
import 'package:nricse123/presentation/bloc/faculty_result_bloc/faculty_result_bloc.dart';
import 'package:nricse123/presentation/bloc/take_attendance_bloc/take_attendance_bloc.dart';
import 'package:nricse123/presentation/bloc/time_tables_bloc/time_tables_bloc.dart';
import 'package:nricse123/presentation/pages/Academics/academic_calenders.dart';
import 'package:nricse123/presentation/pages/Academics/attendance.dart';
import 'package:nricse123/presentation/pages/Academics/syllabus_copy.dart';
import 'package:nricse123/presentation/pages/Academics/time_tables.dart';
import 'package:nricse123/presentation/pages/about_dept.dart';
import 'package:nricse123/presentation/pages/drawer_of_faculty_draw_main_screen.dart';
import 'package:nricse123/presentation/pages/faculty_pages/attendance_status.dart';
import 'package:nricse123/presentation/pages/faculty_result.dart';
import 'package:nricse123/presentation/pages/labs.dart';
import 'package:nricse123/presentation/pages/login_screens_of_teacher_student_parent.dart';
import 'package:nricse123/presentation/pages/take_attendance.dart';
import 'package:nricse123/presentation/widgets/Navigating_one_place_to_another_place.dart';
import 'package:nricse123/presentation/widgets/functions_for_sheets_snackbar_banners.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FacultyDrawerMainScreen extends StatefulWidget {
  const FacultyDrawerMainScreen({Key? key}) : super(key: key);

  @override
  State<FacultyDrawerMainScreen> createState() =>
      _FacultyDrawerMainScreenState();
}

class _FacultyDrawerMainScreenState extends State<FacultyDrawerMainScreen> {
  final FacultyDrawMainScreenBloc facultyDrawMainScreenBloc =
      FacultyDrawMainScreenBloc();
  List<Widget> listOfScreen = [
    const AboutDept(),
    const TimeTables(),
    BlocProvider(
      create: (context) => FacultyResultBloc(
        retrieveStudentsForAttendanceUsecase:
            RetrieveStudentsForAttendanceUsecase(
          attendanceBusinessRepository: RetrieveStudentModelsForAttendance(
            firebaseApiRetrieveStudentsForAttendance:
                FirebaseApiRetrieveStudentsForAttendance(),
          ),
        ),
      ),
      child: const FacultyResult(),
    ),
    BlocProvider(
      create: (context) => TakeAttendanceBloc(
        retrieveStudentsForAttendanceUsecase:
            RetrieveStudentsForAttendanceUsecase(
                attendanceBusinessRepository:
                    RetrieveStudentModelsForAttendance(
                        firebaseApiRetrieveStudentsForAttendance:
                            FirebaseApiRetrieveStudentsForAttendance())),
        uploadAttendanceUsecase: UploadAttendanceUsecase(
            uploadAttendanceBusinessRepository:
                StudentAttandenceUploadDataRepository(
                    firebaseApiForUploadAttendance:
                        FirebaseApiForUploadAttendance())),
      ),
      child: const TakeAttendance(),
    ),
    BlocProvider(
      create: (context) => AttendanceStatusBloc(retrieveStudentsForAttendanceUsecase: RetrieveStudentsForAttendanceUsecase(
                attendanceBusinessRepository:
                    RetrieveStudentModelsForAttendance(
                        firebaseApiRetrieveStudentsForAttendance:
                            FirebaseApiRetrieveStudentsForAttendance())),
      ),
      child: const AttendanceStatus(),
    ),
    const Labs(),
    BlocProvider(
      create: (context) => TimeTablesBloc(),
      child: const TimeTables(),
    ),
    const AcademicCalenders(),
    const SyllabusCopy(),
    const Attendance()
  ];
  @override
  void initState() {
    facultyDrawMainScreenBloc.add(FacultyDrawMainScreenInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            BlocConsumer<FacultyDrawMainScreenBloc, FacultyDrawMainScreenState>(
          bloc: facultyDrawMainScreenBloc,
          listener: (context, state) {},
          builder: (context, state) {
            return HeadingCurrentState().getHeadingBasedOnCurrentForFaculty(
                facultyDrawMainScreenBloc.state.currentScreen);
          },
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await firebaseAuth.signOut();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isFaculty', false);
                // ignore: use_build_context_synchronously
                showSnackbarScreen(context, "Sign Out Successfully");
                // ignore: use_build_context_synchronously
                NavigatingOnePlaceToAnotherPlace().navigatePageDeletePervious(
                    context, const LoginScreensOfTeacherStudentParent());
              },
              child: const Text("Log out"))
        ],
      ),
      drawer:
          BlocConsumer<FacultyDrawMainScreenBloc, FacultyDrawMainScreenState>(
        bloc: facultyDrawMainScreenBloc,
        listener: (context, state) {},
        builder: (context, state) {
          return DrawerOfFacultyDrawMainScreen(
              changeUpdate: (value) {
                facultyDrawMainScreenBloc.add(FacultyDrawMainScreenUpdateEvent(
                    value: value, context: context));
              },
              currentScreen: facultyDrawMainScreenBloc.state.currentScreen);
        },
      ),
      body: BlocConsumer<FacultyDrawMainScreenBloc, FacultyDrawMainScreenState>(
        bloc: facultyDrawMainScreenBloc,
        listener: (context, state) {},
        builder: (context, state) {
          return listOfScreen[facultyDrawMainScreenBloc.state.currentScreen];
        },
      ),
    );
  }
}
