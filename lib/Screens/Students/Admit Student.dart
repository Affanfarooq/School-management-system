import 'package:flutter/material.dart';
class AdmitStudent extends StatefulWidget {
  const AdmitStudent({super.key});

  @override
  State<AdmitStudent> createState() => _AdmitStudentState();
}

class _AdmitStudentState extends State<AdmitStudent> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Admit Student', style: TextStyle(fontSize: 24)));
  }
}
