class StudentModel {
  final String name;
  final String rollNumber;
  final String section;
  final String gender;
  final String batch;
  final String department;
  final String emailAddress;
  final String phoneNumber;
  final String address;
  final String parentPhoneNumber;

  StudentModel({
    required this.name,
    required this.rollNumber,
    required this.section,
    required this.gender,
    required this.batch,
    required this.department,
    required this.emailAddress,
    required this.phoneNumber,
    required this.address,
    required this.parentPhoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Roll Number': rollNumber,
      'Section': section,
      'Gender': gender,
      'Batch': batch,
      'Department': department,
      'Email Address': emailAddress,
      'Phone Number': phoneNumber,
      'Address': address,
      'Parent Phone Number': parentPhoneNumber,
    };
  }

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
        name: json['Name'],
        rollNumber: json['Roll Number'],
        batch: json['Batch'],
        department: json['Department'],
        emailAddress: json['Email Address'],
        phoneNumber: json['Phone Number'],
        address: json['Address'],
        parentPhoneNumber: json['Parent Phone Number'],
        section: json['Section'],
        gender: json['Gender']);
  }
}
