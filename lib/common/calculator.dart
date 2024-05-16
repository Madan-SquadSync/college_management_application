class Calculator {
  int failed(dynamic value) {
    int failCount = 0;
    int absentCount = 0;
    value.values.forEach((subjects) {
      subjects.forEach((subject, grade) {
        if (grade == "F") {
          failCount++;
        } else if (grade.toUpperCase() == "ABSENT") {
          absentCount++;
        }
      });
    });
    return (failCount + absentCount);
  }
}
