import 'package:flutter/material.dart';

Widget textField({String? Function(String?)? validator,TextEditingController? controller}) {
  return Container(
    child: TextFormField(
      controller: controller,
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
        labelStyle: TextStyle(color: Colors.black54, fontSize: 13),
        fillColor: Colors.black.withOpacity(0.08),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide:
          BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
              color: Colors.red.shade800,
              width: 1.5),
        ),
      ),
      validator: validator,
      keyboardType: TextInputType.emailAddress,
      style: new TextStyle(
        fontFamily: "Poppins",
      ),
    ),
  );
}


