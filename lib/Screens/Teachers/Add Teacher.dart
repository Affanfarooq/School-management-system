import 'package:flutter/material.dart';
class AddTeachers extends StatefulWidget {
  const AddTeachers({super.key});

  @override
  State<AddTeachers> createState() => _AddTeachersState();
}

class _AddTeachersState extends State<AddTeachers> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Add Teachers', style: TextStyle(fontSize: 24)));
  }
}
