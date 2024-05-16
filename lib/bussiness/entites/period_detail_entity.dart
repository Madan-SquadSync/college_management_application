 class PeriodDetailEntity {
  String period;
  String teacher;
  String subject;
  bool attendance;

  PeriodDetailEntity({
    required this.period,
    required this.teacher,
    required this.subject,
    required this.attendance,
  });

  factory PeriodDetailEntity.fromJson(Map<String, dynamic> json) {
    return PeriodDetailEntity(
      period: json['period'],
      teacher: json['teacher'],
      subject: json['subject'],
      attendance: json['attendance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'period': period,
      'teacher': teacher,
      'subject': subject,
      'attendance': attendance,
    };
  }

  @override
  String toString() {
    return 'PeriodDetailEntity{period: $period, teacher: $teacher, subject: $subject, attendance: $attendance}';
  }
}
