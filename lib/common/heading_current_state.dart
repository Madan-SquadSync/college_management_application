import 'package:flutter/material.dart';

class HeadingCurrentState {
  Widget getHeadingBasedOnCurrentForAdmin(int value) {
    switch (value) {
      case 0:
        return const Text("About Department");
      case 1:
        return const Text("Time Tables");
      case 2:
        return const Text("Results.");
      case 3:
        return const Text("Faculty List");
      case 4:
        return const Text("Labs");
      case 5:
        return const Text("Time Tables");
      case 6:
        return const Text("Academic Calendars");
      case 7:
        return const Text("Syllabus Copy");
      default:
        return const Text("Attendance");
    }
  }

  Widget getHeadingBasedOnCurrentForFaculty(int value) {
    switch (value) {
      case 0:
        return const Text("About Department");
      case 1:
        return const Text("Time Tables");
      case 2:
        return const Text("Results");
      case 3:
        return const Text("Take Attendance");
      case 4:
        return const Text("Attendance Status");
      case 5:
        return const Text("Labs");
      case 6:
        return const Text("Time Tables");
      case 7:
        return const Text("Academic Calendars");
      case 8:
        return const Text("Syllabus Copy");
      default:
        return const Text("Attendance");
    }
  }
}
