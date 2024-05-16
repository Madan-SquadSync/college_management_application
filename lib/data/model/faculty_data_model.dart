class FacultyModel {
  final String name;
  final int previousExperience;
  final String mobileNumber;
  final String mailId;
  final List<String> subjects;

  FacultyModel({
    required this.name,
    required this.previousExperience,
    required this.mobileNumber,
    required this.mailId,
    required this.subjects,
  });

  
  factory FacultyModel.fromMap(Map<String, dynamic> map) {
    return FacultyModel(
      name: map['name'] ?? '',
      previousExperience: map['previousExperience'] ?? 0,
      mobileNumber: map['mobileNumber'] ?? '',
      mailId: map['mailId'] ?? '',
      subjects: List<String>.from(map['subjects'] ?? []),
    );
  }
}
