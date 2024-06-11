import 'package:flutter/material.dart';
class TeachersDetail extends StatefulWidget {
  const TeachersDetail({super.key});

  @override
  State<TeachersDetail> createState() => _TeachersDetailState();
}

class _TeachersDetailState extends State<TeachersDetail> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Teachers Detail', style: TextStyle(fontSize: 24)));
  }
}
