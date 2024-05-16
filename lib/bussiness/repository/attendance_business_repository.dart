import 'package:flutter/widgets.dart';
import 'package:nricse123/bussiness/entites/student.dart';

abstract class AttendanceBusinessRepository {
  Future<List<Student>> getStudents(
      BuildContext context, String batch, String section);
}
