import 'package:flutter/widgets.dart';
import 'package:nricse123/bussiness/entites/period_detail_entity.dart';
 

abstract class TodayAttendanceBusinessRepository {
  Future<List<PeriodDetailEntity>> getAttendance(
        String date, String rollNumber, BuildContext context);
}
