import 'package:flutter/material.dart';
class AllTeachers extends StatefulWidget {
  const AllTeachers({super.key});

  @override
  State<AllTeachers> createState() => _AllTeachersState();
}

class _AllTeachersState extends State<AllTeachers> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('All Teachers', style: TextStyle(fontSize: 24)));
  }
}
