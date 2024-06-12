class Student {
  final String firstName;
  final String lastName;
  final String studentClass;
  final String section;
  final String dob;
  final String rollNo;
  final String admissionNo;
  final String email;
  final String fatherName;
  final String motherName;
  final String fatherOccupation;
  final String motherOccupation;
  final String fatherCellNo;
  final String motherCellNo;
  final String address;
  final String imagePath;
  final String gender;

  Student({
    required this.firstName,
    required this.lastName,
    required this.studentClass,
    required this.section,
    required this.dob,
    required this.rollNo,
    required this.admissionNo,
    required this.email,
    required this.fatherName,
    required this.motherName,
    required this.fatherOccupation,
    required this.motherOccupation,
    required this.fatherCellNo,
    required this.motherCellNo,
    required this.address,
    required this.imagePath,
    required this.gender,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      firstName: json['first_name'],
      lastName: json['last_name'],
      studentClass: json['class'],
      section: json['section'],
      dob: json['dob'],
      rollNo: json['roll_no'],
      admissionNo: json['admission_no'],
      email: json['email'],
      fatherName: json['father_name'],
      motherName: json['mother_name'],
      fatherOccupation: json['father_occupation'],
      motherOccupation: json['mother_occupation'],
      fatherCellNo: json['father_cell_no'],
      motherCellNo: json['mother_cell_no'],
      address: json['address'],
      imagePath: json['image_path'],
      gender: json['gender'],
    );
  }
}
