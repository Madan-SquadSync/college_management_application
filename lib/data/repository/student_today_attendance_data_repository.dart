import 'package:flutter/src/widgets/framework.dart';
import 'package:nricse123/bussiness/entites/period_detail_entity.dart';
import 'package:nricse123/bussiness/repository/today_attendance_bussiness_repository.dart';
import 'package:nricse123/data/data_source/firebase_api_for_daily_attendance.dart';

class StudentTodayAttendanceDataRepository
    extends TodayAttendanceBusinessRepository {
  @override
  Future<List<PeriodDetailEntity>> getAttendance(
      String date, String rollNumber, BuildContext context) async {
    return await FirebaseApiForDailyAttendance()
        .getDailyAttendance(date, rollNumber, context)
        .then((value) => value
            .map((e) => PeriodDetailEntity(
                teacher: e.teacher,
                subject: e.subject,
                attendance: e.attendance, period: e.period))
            .toList());
  }
}
