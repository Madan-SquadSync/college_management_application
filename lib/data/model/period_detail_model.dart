class PeriodDetailModel {
  String period;
  String teacher;
  String subject;
  bool attendance;

  PeriodDetailModel({
    required this.period,
    required this.teacher,
    required this.subject,
    required this.attendance,
  });

  factory PeriodDetailModel.fromJson(Map<String, dynamic> json) {
    return PeriodDetailModel(
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
    return 'PeriodDetailModel{period: $period, teacher: $teacher, subject: $subject, attendance: $attendance}';
  }
}
