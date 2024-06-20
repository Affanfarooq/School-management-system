import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:school_management_system/Models/Student%20Model.dart';
import 'package:school_management_system/Widgets/text.dart';

class StudentSearchScreen extends StatefulWidget {
  const StudentSearchScreen({Key? key}) : super(key: key);

  @override
  _StudentSearchScreenState createState() => _StudentSearchScreenState();
}

class _StudentSearchScreenState extends State<StudentSearchScreen> {
  TextEditingController _searchController = TextEditingController();
  Future<List<Student>>? _futureStudents;
  Timer? _debounce;

  Future<List<Student>> fetchStudents({String? searchQuery}) async {
    String url = 'http://localhost:3000/students';
    if (searchQuery != null && searchQuery.isNotEmpty) {
      url += '?search=$searchQuery';
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((student) => Student.fromJson(student)).toList();
    } else {
      throw Exception('Failed to load students');
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        setState(() {
          _futureStudents = fetchStudents(searchQuery: query);
        });
      } else {
        setState(() {
          _futureStudents = null;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _onSearchChanged(_searchController.text);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text("  STUDENT DETAIL", 15, FontWeight.w600, Colors.black54),
              SizedBox(height: 8),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search student by name or roll number...',
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide.none,
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      _futureStudents == null
                          ? Container()
                          : FutureBuilder<List<Student>>(
                        future: _futureStudents,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Center(child: Text('No students found'));
                          } else {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                Student student = snapshot.data![index];
                                return Padding(
                                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Image.file(
                                          File(student.imagePath),
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.contain,
                                        ),
                                        color: Colors.grey.shade200,
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          text("About ${student.firstName}", 24, FontWeight.w600, Colors.black),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  text("Name", 14, FontWeight.w600, Colors.black54),
                                                  SizedBox(height: 5),
                                                  text("Gender", 14, FontWeight.w600, Colors.black54),
                                                  SizedBox(height: 5),
                                                  text("Father Name", 14, FontWeight.w600, Colors.black54),
                                                  SizedBox(height: 5),
                                                  text("Mother Name", 14, FontWeight.w600, Colors.black54),
                                                  SizedBox(height: 5),
                                                  text("Date Of Birth", 14, FontWeight.w600, Colors.black54),
                                                  SizedBox(height: 5),
                                                  text("Father Occupation", 14, FontWeight.w600, Colors.black54),
                                                  SizedBox(height: 5),
                                                  text("Mother Occupation", 14, FontWeight.w600, Colors.black54),
                                                  SizedBox(height: 5),
                                                  text("Email", 14, FontWeight.w600, Colors.black54),
                                                  SizedBox(height: 5),
                                                  text("Class", 14, FontWeight.w600, Colors.black54),
                                                  SizedBox(height: 5),
                                                  text("Section", 14, FontWeight.w600, Colors.black54),
                                                  SizedBox(height: 5),
                                                  text("Roll No", 14, FontWeight.w600, Colors.black54),
                                                  SizedBox(height: 5),
                                                  text("Admission No", 14, FontWeight.w600, Colors.black54),
                                                  SizedBox(height: 5),
                                                  text("Admission Date", 14, FontWeight.w600, Colors.black54),
                                                  SizedBox(height: 5),
                                                  text("Address", 14, FontWeight.w600, Colors.black54),
                                                  SizedBox(height: 5),
                                                  text("Phone No Father", 14, FontWeight.w600, Colors.black54),
                                                  SizedBox(height: 5),
                                                  text("Phone No Mother", 14, FontWeight.w600, Colors.black54),
                                                ],
                                              ),
                                              SizedBox(width: 100),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  text('${student.firstName} ${student.lastName}', 14, FontWeight.w600, Colors.black87),
                                                  SizedBox(height: 5),
                                                  text(student.gender, 14, FontWeight.w600, Colors.black87),
                                                  SizedBox(height: 5),
                                                  text(student.fatherName, 14, FontWeight.w600, Colors.black87),
                                                  SizedBox(height: 5),
                                                  text(student.motherName, 14, FontWeight.w600, Colors.black87),
                                                  SizedBox(height: 5),
                                                  text(student.dob, 14, FontWeight.w600, Colors.black87),
                                                  SizedBox(height: 5),
                                                  text(student.fatherOccupation, 14, FontWeight.w600, Colors.black87),
                                                  SizedBox(height: 5),
                                                  text(student.motherOccupation, 14, FontWeight.w600, Colors.black87),
                                                  SizedBox(height: 5),
                                                  text(student.email, 14, FontWeight.w600, Colors.black87),
                                                  SizedBox(height: 5),
                                                  text(student.studentClass, 14, FontWeight.w600, Colors.black87),
                                                  SizedBox(height: 5),
                                                  text(student.section, 14, FontWeight.w600, Colors.black87),
                                                  SizedBox(height: 5),
                                                  text(student.rollNo, 14, FontWeight.w600, Colors.black87),
                                                  SizedBox(height: 5),
                                                  text(student.admissionNo, 14, FontWeight.w600, Colors.black87),
                                                  SizedBox(height: 5),
                                                  text('------', 14, FontWeight.w600, Colors.black87),
                                                  SizedBox(height: 5),
                                                  text(student.address, 14, FontWeight.w600, Colors.black87),
                                                  SizedBox(height: 5),
                                                  text(student.fatherCellNo, 14, FontWeight.w600, Colors.black87),
                                                  SizedBox(height: 5),
                                                  text(student.motherCellNo, 14, FontWeight.w600, Colors.black87),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
