import 'package:flutter/material.dart';
import 'package:school_management_system/Widgets/text.dart';
import 'package:school_management_system/Widgets/textField.dart';
class AdmitStudent extends StatefulWidget {
  const AdmitStudent({super.key});

  @override
  State<AdmitStudent> createState() => _AdmitStudentState();
}

class _AdmitStudentState extends State<AdmitStudent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text("  STUDENT ADMIT FORM", 15, FontWeight.w600, Colors.black54),
          SizedBox(height: 8,),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text("Student Information", 16, FontWeight.w600, Colors.black),
                        SizedBox(height: 18,),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text("First Name", 11, FontWeight.w600, Colors.black45),
                                  SizedBox(height: 6,),
                                  textField(),
                                ],
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text("Last Name", 11, FontWeight.w600, Colors.black45),
                                  SizedBox(height: 6,),
                                  textField(),
                                ],
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text("Class", 11, FontWeight.w600, Colors.black45),
                                  SizedBox(height: 6,),
                                  textField(),
                                ],
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text("Section", 11, FontWeight.w600, Colors.black45),
                                  SizedBox(height: 6,),
                                  textField(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text("Gender", 11, FontWeight.w600, Colors.black45),
                                  SizedBox(height: 6,),
                                  textField(),
                                ],
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text("Date of birth", 11, FontWeight.w600, Colors.black45),
                                  SizedBox(height: 6,),
                                  textField(),
                                ],
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text("Roll no", 11, FontWeight.w600, Colors.black45),
                                  SizedBox(height: 6,),
                                  textField(),
                                ],
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text("Admission no", 11, FontWeight.w600, Colors.black45),
                                  SizedBox(height: 6,),
                                  textField(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text("Email", 11, FontWeight.w600, Colors.black45),
                                  SizedBox(height: 6,),
                                  textField(),
                                ],
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text("Upload student image", 11, FontWeight.w600, Colors.black45),
                                  SizedBox(height: 6,),
                                  textField(),
                                ],
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Container()
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Container()
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text("Parents Information", 16, FontWeight.w600, Colors.black),
                        SizedBox(height: 18,),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text("Father Name", 11, FontWeight.w600, Colors.black45),
                                  SizedBox(height: 6,),
                                  textField(),
                                ],
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text("Mother Name", 11, FontWeight.w600, Colors.black45),
                                  SizedBox(height: 6,),
                                  textField(),
                                ],
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text("Father Occupation", 11, FontWeight.w600, Colors.black45),
                                  SizedBox(height: 6,),
                                  textField(),
                                ],
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text("Mother Occupation", 11, FontWeight.w600, Colors.black45),
                                  SizedBox(height: 6,),
                                  textField(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text("Father cell no", 11, FontWeight.w600, Colors.black45),
                                  SizedBox(height: 6,),
                                  textField(),
                                ],
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text("Mother cell no", 11, FontWeight.w600, Colors.black45),
                                  SizedBox(height: 6,),
                                  textField(),
                                ],
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text("Address", 11, FontWeight.w600, Colors.black45),
                                  SizedBox(height: 6,),
                                  textField(),
                                ],
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Container()
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10,)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
