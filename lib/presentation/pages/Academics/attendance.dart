import 'package:flutter/material.dart';
import 'package:nricse123/presentation/pages/take_attendance.dart';

class Attendance extends StatelessWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to TakeAttendancePage when the button is pressed
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const TakeAttendance(), // Your TakeAttendancePage widget
              ),
            );
          },
          child: Text("Take Attendance"),
        ),
      ),
    );
  }
}
