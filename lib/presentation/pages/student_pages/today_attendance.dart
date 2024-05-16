import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse123/common/data_for_student_draw_main_screen.dart';
import 'package:nricse123/common/data_for_today_attendance.dart';
import 'package:nricse123/presentation/bloc/today_attendance_bloc/today_attendance_bloc.dart';
import 'package:nricse123/presentation/bloc/today_attendance_bloc/today_attendance_event.dart';
import 'package:nricse123/presentation/bloc/today_attendance_bloc/today_attendance_state.dart';

class TodayAttendance extends StatelessWidget {
  const TodayAttendance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodayAttendanceBloc>(context).add(TodayAttendanceInitialEvent(
        context: context,
        date: '${DateTime.now().day.toString()}-${DateTime.now().month.toString()}-${DateTime.now().year.toString()}',
        // ignore: unnecessary_string_interpolations
        rollNumber: '${studentModel.rollNumber}'));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Today Attendance"),
      ),
      body: BlocConsumer<TodayAttendanceBloc, TodayAttendanceState>(
        bloc: context.read<TodayAttendanceBloc>(),
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.builder(
            itemCount: listOfPeriodDetailEntity.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  backgroundColor: const Color.fromARGB(128, 180, 208, 149),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        listOfPeriodDetailEntity[index].period,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: ShapeDecoration(
                          color: listOfPeriodDetailEntity[index].attendance
                              ? const Color.fromARGB(168, 127, 164, 182)
                              : const Color.fromARGB(169, 207, 141, 163),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: listOfPeriodDetailEntity[index].attendance
                            ? const Text("Present")
                            : const Text("Absent"),
                      )
                    ],
                  ),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listOfPeriodDetailEntity[index].subject,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                color: const Color.fromARGB(255, 131, 128, 128),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          listOfPeriodDetailEntity[index].teacher,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Color.fromARGB(255, 112, 109, 109),
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
