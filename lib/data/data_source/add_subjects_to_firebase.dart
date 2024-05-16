import 'package:flutter/material.dart';
import 'package:nricse123/common/custom_snack_bar.dart';
import 'package:nricse123/common/data.dart';

class AddSubjectsToFirebase {
  Future<void> uploadSubjectsInDatabase() async {
    final subjectsDatabase = database.child('Subjects');
    List<String> listOFSubjects = [
      'Applied Chemistry',
      'Applied Chemistry Lab',
      'Applied Physics',
      'Applied Physics Lab',
      'Big Data Analytics',
      'Big Data Analytics Lab',
      'Communicative English',
      'Computer Engineering Workshop',
      'Computer Networks',
      'Computer Networks Lab',
      'Computer Organization',
      'Data Mining using Python Lab',
      'Data Structures',
      'Data Structures Lab',
      'Data Warehousing and Mining',
      'Database Management Systems',
      'Database Management Systems Lab',
      'Deep Learning with TensorFlow',
      'Design and Analysis of Algorithms',
      'Digital Logic Design',
      'English Communication Skills Laboratory',
      'Essence of Indian Traditional Knowledge',
      'Formal Languages and Automata Theory',
      'Fundamentals of Data Science',
      'Fundamentals of Data Science Lab',
      'HTML ',
      'Major Project Work, Seminar Internship',
      'Managerial Economics and Financial Accountancy',
      'Mathematical Foundations of Computer Science',
      'Mathematics III',
      'Mathematics – I',
      'Mathematics – II',
      'Mobile App Development',
      'MongoDB',
      'Object Oriented Programming with Java',
      'Object Oriented Programming with Java Lab',
      'Open Elective-II',
      'Open Elective-III',
      'Probability and Statistics',
      'Professional Elective-II',
      'Professional Elective-III',
      'Professional Elective-IV',
      'Professional Elective-V',
      'Programming for Problem Solving using C',
      'Programming for Problem Solving using C Lab',
      'Python Programming',
      'Python Programming Lab',
      'R Programming Lab',
      'Skill Oriented Course - IV',
      'Universal Human Values 2: Understanding Harmony',
      'Web Application Development Lab',
      'c'
    ];

    for (var i = 0; i < listOFSubjects.length; i++) {
      await subjectsDatabase
          .child(listOFSubjects[i].toString())
          .child("name")
          .set(listOFSubjects[i].toString());
    }
  }

  Future<bool> addSubject(String subjectName, BuildContext context) async {
    final subjectsDatabase = database.child('Subjects');
    try {
      await subjectsDatabase.child(subjectName).child("name").set(subjectName);
      return true;
    } catch (e) {
      CustomSnackBar().show(context, e.toString());
      return false;
    }
     
  }

  Future<List<String>> retrieveSubjects() async {
    List<String> listofSubjects = [];
    final subjectsDatabase = await database.child('Subjects').once();
    final subjectsMap = await subjectsDatabase.snapshot.value as Map;
    for (var subject in subjectsMap.entries) {
      listofSubjects.add(subject.key);
    }
    listofSubjects.sort();
    return listofSubjects;
  }
}
