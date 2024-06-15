import 'dart:async';
import 'dart:convert';
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
  late Future<List<Student>> _futureStudents;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _futureStudents = fetchStudents();
  }

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

  void _onSearchTextChanged(String text) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _futureStudents = fetchStudents(searchQuery: text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text("  STUDENT DETAIL", 15, FontWeight.w600, Colors.black54),
          SizedBox(height: 8,),
          Container(
            height: 500,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      onChanged: _onSearchTextChanged,
                      decoration: InputDecoration(
                        hintText: 'Search student by name...',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0), // Optional: Adjust padding
                      ),
                    ),
                    FutureBuilder<List<Student>>(
                      future: _futureStudents,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text('No students found.'));
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Student student = snapshot.data![index];
                              return ListTile(
                                title: Text('${student.firstName} ${student.lastName}'),
                                subtitle: Text('Class: ${student.studentClass}, Section: ${student.section}'),
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
          ),
        ],
      ),
    );
  }
}
