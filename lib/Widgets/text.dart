import 'package:flutter/material.dart';

Widget text (String txt,double fontSize,FontWeight fontWeight, Color color){
  return Text(txt, style: TextStyle(fontSize: fontSize,fontWeight: fontWeight,color: color),);
}