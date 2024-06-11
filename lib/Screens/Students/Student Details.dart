import 'package:flutter/material.dart';
class StudentDetails extends StatefulWidget {
  const StudentDetails({super.key});

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Students Detail', style: TextStyle(fontSize: 24)));
  }
}
