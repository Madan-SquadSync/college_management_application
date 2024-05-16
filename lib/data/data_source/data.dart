import 'package:flutter/material.dart';
import 'package:nricse123/bussiness/entites/student_result_entity.dart';

var listOFUsers = ["Teacher", "Student", "Parent"];

final mainThemeColor = Color.fromARGB(255, 117, 99, 219);
final mainThemeLightColor = Color.fromARGB(255, 221, 218, 239);

var listContentDrawer = [
  'About Dept',
  'Academics',
  'Results',
  "Faculty list",
  'Labs'
];

var listContentDrawerForFaculty = [
  'About Dept',
  'Academics',
  'Results',
  "Take Attendance",
  "Attendance Status",
  'Labs'
];

var listOfAcademics = [
  "Time-Tables",
  "Academics Calenders",
  "Syllabus Copy",
  "Attendance"
];

var aboutDept = [
  "The Department of Computer Science and Engineering (CSE), NRIIT, GUNTUR, was established in the year 2008 with a modest intake of 60 students. Over the years it has grown by leaps and bounds and presently offers the B.Tech course in Computer Science and Engineering with a sanctioned intake of 150 students. The Department also offers a P.G. course in Computer Science and Engineering with an intake of 18.",
  "Department of CSE has well-qualified and experienced faculty who are specialists in the areas of Databases, Data Mining, Computer Architecture, Operating Systems, Image Processing, Wireless Networks, Artificial Neural Networks, Information Security and Programming Languages. There are around 32 dedicated faculty members with good amount of experience in these different areas. The faculty members are actively involved in research activities in the field of their specialization. They have published number of papers in journals and Conferences of National and International repute. The Department attributes its success to the creative and innovative outlook of its students also. The Department encourages students to participate in numerous symposiums and to present papers in them. Students are also made to undergo in-plant training programs, where they hone their technical skill in the realm of computers."
];

var labimages = [
  "https://nriit.ac.in/public/cse/infrastructure/1.jpeg",
  "https://nriit.ac.in/public/cse/infrastructure/2.jpeg",
  "https://nriit.ac.in/public/cse/infrastructure/3.jpeg",
  "https://nriit.ac.in/public/cse/infrastructure/4.jpeg",
  "https://nriit.ac.in/public/cse/infrastructure/5.jpeg",
  "https://nriit.ac.in/public/cse/infrastructure/6.jpeg",
   
];

StudentResultEntity studentResultEntity =
    StudentResultEntity(name: '', semstersResult: {});
