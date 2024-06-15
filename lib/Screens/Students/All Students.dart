import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_management_system/Models/Student%20Model.dart';
import 'package:school_management_system/Widgets/text.dart';
import 'package:http/http.dart' as http;

class AllStudents extends StatefulWidget {
  const AllStudents({super.key});

  @override
  State<AllStudents> createState() => _AllStudentsState();
}

class _AllStudentsState extends State<AllStudents> {
  late Future<List<Student>> futureStudents;
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();

  @override
  void initState() {
    super.initState();
    futureStudents = fetchStudents();
  }

  Future<List<Student>> fetchStudents() async {
    final response = await http.get(Uri.parse('http://localhost:3000/students'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((student) => Student.fromJson(student)).toList();
    } else {
      throw Exception('Failed to load students');
    }
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    _verticalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          text("  ALL STUDENTS", 15, FontWeight.w600, Colors.black54),
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
                child: FutureBuilder<List<Student>>(
                  future: futureStudents,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No students found.'));
                    } else {
                      return Scrollbar(
                        controller: _horizontalController,
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          controller: _horizontalController,
                          child: Scrollbar(
                            controller: _verticalController,
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              controller: _verticalController,
                              child: DataTable(
                                showBottomBorder: false,
                                dataRowColor: MaterialStateProperty.resolveWith(
                                        (states) => Colors.white),
                                headingRowColor: MaterialStateProperty.resolveWith(
                                        (states) => Colors.grey.shade200),

                                headingRowHeight: 50,
                                dividerThickness: 0,
                                columnSpacing: 46,
                                columns: [
                                  DataColumn(label: Text('  Image', style: TextStyle(fontSize: 12))),
                                  DataColumn(label: Text('First Name',style: TextStyle(fontSize: 12),)),
                                  DataColumn(label: Text('Last Name',style: TextStyle(fontSize: 12),)),
                                  DataColumn(label: Text('Class',style: TextStyle(fontSize: 12),)),
                                  DataColumn(label: Text('Section',style: TextStyle(fontSize: 12),)),
                                  DataColumn(label: Text('DOB',style: TextStyle(fontSize: 12),)),
                                  DataColumn(label: Text('Roll No',style: TextStyle(fontSize: 12),)),
                                  DataColumn(label: Text('Admission No',style: TextStyle(fontSize: 12),)),
                                  DataColumn(label: Text('Email',style: TextStyle(fontSize: 12),)),
                                  DataColumn(label: Text('Father Name',style: TextStyle(fontSize: 12),)),
                                  DataColumn(label: Text('Mother Name',style: TextStyle(fontSize: 12),)),
                                  DataColumn(label: Text('Father Occupation',style: TextStyle(fontSize: 12),)),
                                  DataColumn(label: Text('Mother Occupation',style: TextStyle(fontSize: 12),)),
                                  DataColumn(label: Text('Father Cell No',style: TextStyle(fontSize: 12),)),
                                  DataColumn(label: Text('Mother Cell No',style: TextStyle(fontSize: 12),)),
                                  DataColumn(label: Text('Address',style: TextStyle(fontSize: 12),)),
                                  DataColumn(label: Text('Gender',style: TextStyle(fontSize: 12),)),
                                ],
                                rows: snapshot.data!.map((student) {
                                  return DataRow(cells: [
                                    DataCell(
                                      student.imagePath.isNotEmpty
                                          ? Row(
                                        children: [
                                          Image.file(
                                            File(student.imagePath),
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                          ),

                                        ],
                                      ) : Container(),
                                    ),
                                    DataCell(Text(student.firstName,style: TextStyle(fontSize: 12),)),
                                    DataCell(Text(student.lastName,style: TextStyle(fontSize: 12),)),
                                    DataCell(Text(student.studentClass,style: TextStyle(fontSize: 12),)),
                                    DataCell(Text(student.section,style: TextStyle(fontSize: 12),)),
                                    DataCell(Text(student.dob,style: TextStyle(fontSize: 12),)),
                                    DataCell(Text(student.rollNo,style: TextStyle(fontSize: 12),)),
                                    DataCell(Text(student.admissionNo,style: TextStyle(fontSize: 12),)),
                                    DataCell(Text(student.email,style: TextStyle(fontSize: 12),)),
                                    DataCell(Text(student.fatherName,style: TextStyle(fontSize: 12),)),
                                    DataCell(Text(student.motherName,style: TextStyle(fontSize: 12),)),
                                    DataCell(Text(student.fatherOccupation,style: TextStyle(fontSize: 12),)),
                                    DataCell(Text(student.motherOccupation,style: TextStyle(fontSize: 12),)),
                                    DataCell(Text(student.fatherCellNo,style: TextStyle(fontSize: 12),)),
                                    DataCell(Text(student.motherCellNo,style: TextStyle(fontSize: 12),)),
                                    DataCell(Text(student.address,style: TextStyle(fontSize: 12),)),
                                    DataCell(Text(student.gender,style: TextStyle(fontSize: 12),)),
                                  ]);
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
