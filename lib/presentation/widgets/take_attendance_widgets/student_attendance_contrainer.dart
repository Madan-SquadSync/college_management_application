import 'package:flutter/material.dart';

class StudentAttendanceContainer extends StatelessWidget {
  const StudentAttendanceContainer(
      {Key? key,
      required this.rollNumber,
      required this.name,
      required this.phoneNumber,
      required this.isAbsent,
      required this.absentMethod})
      : super(key: key);
  final String rollNumber;
  final String name;
  final String phoneNumber;
  final bool isAbsent;
  final Function() absentMethod;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: absentMethod,
      child: AnimatedContainer(
        margin: EdgeInsets.all(5),
        decoration: ShapeDecoration(
          color: isAbsent
              ? const Color.fromARGB(255, 193, 175, 168)
              : const Color.fromARGB(255, 50, 172, 228),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        duration: const Duration(seconds: 1),
        curve: Curves.fastLinearToSlowEaseIn,
        child: Column(
          children: [
            Text(
              rollNumber,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              "$name ~ $phoneNumber",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: const Color.fromARGB(150, 55, 53, 53),
                    fontWeight: FontWeight.bold,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
