import 'dart:convert';
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
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No students found.');
                    } else {
                      return DataTable(
                        columns: [
                          DataColumn(label: Text('First Name')),
                          DataColumn(label: Text('Last Name')),
                          DataColumn(label: Text('Class')),
                          DataColumn(label: Text('Section')),
                          DataColumn(label: Text('DOB')),
                          DataColumn(label: Text('Roll No')),
                          DataColumn(label: Text('Admission No')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('Father Name')),
                          DataColumn(label: Text('Mother Name')),
                          DataColumn(label: Text('Father Occupation')),
                          DataColumn(label: Text('Mother Occupation')),
                          DataColumn(label: Text('Father Cell No')),
                          DataColumn(label: Text('Mother Cell No')),
                          DataColumn(label: Text('Address')),
                          DataColumn(label: Text('Gender')),
                        ],
                        rows: snapshot.data!.map((student) {
                          return DataRow(cells: [
                            DataCell(Text(student.firstName)),
                            DataCell(Text(student.lastName)),
                            DataCell(Text(student.studentClass)),
                            DataCell(Text(student.section)),
                            DataCell(Text(student.dob)),
                            DataCell(Text(student.rollNo)),
                            DataCell(Text(student.admissionNo)),
                            DataCell(Text(student.email)),
                            DataCell(Text(student.fatherName)),
                            DataCell(Text(student.motherName)),
                            DataCell(Text(student.fatherOccupation)),
                            DataCell(Text(student.motherOccupation)),
                            DataCell(Text(student.fatherCellNo)),
                            DataCell(Text(student.motherCellNo)),
                            DataCell(Text(student.address)),
                            DataCell(Text(student.gender)),
                          ]);
                        }).toList(),
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
