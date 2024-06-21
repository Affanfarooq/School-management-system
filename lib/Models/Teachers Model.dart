class Teachers {
  final String firstName;
  final String lastName;
  final String dob;
  final String IdNo;
  final String email;
  final String cellNo;
  final String address;
  final String imagePath;
  final String gender;
  final String classes;
  final String subjects;

  Teachers({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.IdNo,
    required this.email,
    required this.cellNo,
    required this.address,
    required this.imagePath,
    required this.gender,
    required this.classes,
    required this.subjects,

  });

  factory Teachers.fromJson(Map<String, dynamic> json) {
    return Teachers(
      firstName: json['first_name'],
      lastName: json['last_name'],
      dob: json['dob'],
      email: json['email'],
      address: json['address'],
      imagePath: json['image_path'],
      gender: json['gender'],
      IdNo: json['id_no'],
      cellNo: json['gender'],
      classes: json['classes'],
      subjects: json['subjects'],
    );
  }
}
