import 'package:flutter/material.dart';
import 'package:nricse123/bussiness/entites/student.dart';
import 'package:nricse123/bussiness/repository/student_bussiness_repository.dart';
import 'package:nricse123/common/custom_snack_bar.dart';
import 'package:nricse123/data/data_source/firebase_api_for_student_details.dart';
import 'package:nricse123/data/model/student_model.dart';

class StudentDetailsUploadRepository implements StudentRepository {
  final FirebaseApiForStudentDetails firebaseApi;
  StudentDetailsUploadRepository({required this.firebaseApi});
  @override
  Future<void> setStudentDetails(Student student, BuildContext context) async {
    try {
      await firebaseApi.setStudentDetailsToFirebase(
          StudentModel(
              name: student.name,
              rollNumber: student.rollNumber,
              batch: student.batch,
              department: student.department,
              emailAddress: student.emailAddress,
              phoneNumber: student.phoneNumber,
              address: student.address,
              parentPhoneNumber: student.parentPhoneNumber,
              section: student.section,
              gender: student.gender),
          context);
    } catch (error) {
      CustomSnackBar().show(context, 'Error uploading student details: $error');
    }
  }
}
