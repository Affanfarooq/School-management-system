import 'package:flutter/material.dart';
class AllStudents extends StatefulWidget {
  const AllStudents({super.key});

  @override
  State<AllStudents> createState() => _AllStudentsState();
}

class _AllStudentsState extends State<AllStudents> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('All Students', style: TextStyle(fontSize: 24)));
  }
}
