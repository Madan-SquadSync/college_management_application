import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/bussiness/usecase/retrieve_faculty_details_usecase.dart';
import 'package:nricse123/common/data.dart';
import 'package:nricse123/common/heading_current_state.dart';
import 'package:nricse123/data/data_source/firebase_api_service_for_retrieve_List_of_faculty_Model.dart';
import 'package:nricse123/data/data_source/firebase_api_service_for_student_result.dart';
import 'package:nricse123/data/repository/retrieve_faculty_data_repository.dart';
import 'package:nricse123/data/repository/student_result_repository.dart';
import 'package:nricse123/presentation/bloc/admin_draw_main_screen_bloc/admin_draw_main_screen_bloc.dart';
import 'package:nricse123/presentation/bloc/admin_draw_main_screen_bloc/admin_draw_main_screen_event.dart';
import 'package:nricse123/presentation/bloc/admin_draw_main_screen_bloc/admin_draw_main_screen_state.dart';
import 'package:nricse123/presentation/bloc/faculty_list_bloc/faculty_list_bloc.dart';
import 'package:nricse123/presentation/bloc/result_bloc/result_bloc.dart';
import 'package:nricse123/presentation/pages/Academics/academic_calenders.dart';
import 'package:nricse123/presentation/pages/Academics/attendance.dart';
import 'package:nricse123/presentation/pages/Academics/syllabus_copy.dart';
import 'package:nricse123/presentation/pages/Academics/time_tables.dart';
import 'package:nricse123/presentation/pages/about_dept.dart';
import 'package:nricse123/presentation/pages/faculty_list.dart';
import 'package:nricse123/presentation/pages/labs.dart';
import 'package:nricse123/presentation/pages/login_screens_of_teacher_student_parent.dart';
import 'package:nricse123/presentation/pages/results.dart';
import 'package:nricse123/presentation/widgets/drawer_of_the_admin_drawer_main_screen.dart';
import 'package:nricse123/presentation/widgets/functions_for_sheets_snackbar_banners.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDrawerMainScreen extends StatefulWidget {
  const AdminDrawerMainScreen({super.key});

  @override
  State<AdminDrawerMainScreen> createState() => _AdminDrawerMainScreenState();
}

class _AdminDrawerMainScreenState extends State<AdminDrawerMainScreen> {
  final AdminDrawMainScreenBloc adminDrawMainScreenBloc =
      AdminDrawMainScreenBloc();

  List<Widget> listOfScreen = [
    const AboutDept(),
    const TimeTables(),
    BlocProvider(
      create: (context) => ResultBloc(
          studentBussinessRepository: StudentResultRepository(
              firebaseApiServiceForStudentResult:
                  FirebaseApiServiceForStudentResult())),
      child: Results(),
    ),
    BlocProvider(
      create: (context) => FacultyListBloc(
        retrieveFacultyDetailsUsecase: RetrieveFacultyDetailsUsecase(
          retrieveFacultyDataBussinessRepository: RetrieveFacultyDataRepository(
            firebaseApiServiceForRetrieveListOfFacultyModel:
                FirebaseApiServiceForRetrieveListOfFacultyModel(),
          ),
        ),
      ),
      child: const FacultyList(),
    ),
    const Labs(),
    const TimeTables(),
    const AcademicCalenders(),
    const SyllabusCopy(),
    const Attendance()
  ];

  @override
  void initState() {
    adminDrawMainScreenBloc.add(AdminDrawMainScreenInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          title:
              BlocConsumer<AdminDrawMainScreenBloc, AdminDrawMainScreenState>(
            bloc: adminDrawMainScreenBloc,
            listener: (context, state) {},
            builder: (context, state) {
              return HeadingCurrentState().getHeadingBasedOnCurrentForAdmin(
                  adminDrawMainScreenBloc.state.currentScreen);
            },
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  await firebaseAuth.signOut();
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('isAdmin', false);
                  // ignore: use_build_context_synchronously
                  showSnackbarScreen(context, "Sign Out Successfully");
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (ctx) =>
                          const LoginScreensOfTeacherStudentParent()));
                },
                child: const Text("Log out"))
          ],
        ),
        drawer: BlocConsumer<AdminDrawMainScreenBloc, AdminDrawMainScreenState>(
          bloc: adminDrawMainScreenBloc,
          listener: (context, state) {},
          builder: (context, state) {
            return DrawerOfTheAdminDrawerMainScreen(
              currentScreen: adminDrawMainScreenBloc.state.currentScreen,
              changeUpdate: (value) => adminDrawMainScreenBloc.add(
                AdminDrawMainScreenUpdateEvent(value: value , context: context),
              ),
            );
          },
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            // const BackgroundLottieWallpaper(key: ObjectKey("BackGround")),
            BlocConsumer<AdminDrawMainScreenBloc, AdminDrawMainScreenState>(
              bloc: adminDrawMainScreenBloc,
              listener: (context, state) {},
              builder: (context, state) {
                return listOfScreen[
                    adminDrawMainScreenBloc.state.currentScreen];
              },
            ),
          ],
        ));
  }
}
