import 'package:flutter/material.dart';
class Parents extends StatefulWidget {
  const Parents({super.key});

  @override
  State<Parents> createState() => _ParentsState();
}

class _ParentsState extends State<Parents> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Parents', style: TextStyle(fontSize: 24)));
  }
}
