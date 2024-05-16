import 'package:flutter/material.dart';
import 'package:nricse123/bussiness/entites/period_detail_entity.dart';
import 'package:nricse123/bussiness/repository/today_attendance_bussiness_repository.dart';

class RetrieveStudentDailyAttendanceRepository {
  TodayAttendanceBusinessRepository todayAttendanceBusinessRepository;
  RetrieveStudentDailyAttendanceRepository(
      {required this.todayAttendanceBusinessRepository});
  Future<List<PeriodDetailEntity>> retrieve(
      String date, String rollNumber, BuildContext context) async {
    return await todayAttendanceBusinessRepository.getAttendance(
        date, rollNumber, context);
  }
}
