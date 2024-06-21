import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_management_system/Models/Student%20Model.dart';
import 'package:school_management_system/Models/Teachers%20Model.dart';
import 'package:school_management_system/Widgets/text.dart';
import 'package:http/http.dart' as http;

class AllTeachers extends StatefulWidget {
  const AllTeachers({super.key});

  @override
  State<AllTeachers> createState() => _AllTeachersState();
}

class _AllTeachersState extends State<AllTeachers> {
  late Future<List<Teachers>> teachers;
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();

  @override
  void initState() {
    super.initState();
    teachers = fetchTeachers();
  }

  Future<List<Teachers>> fetchTeachers() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/teachers'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print(response.body);
      return jsonResponse.map((teachers) => Teachers.fromJson(teachers)).toList();
    } else {
      print('FAILED');
      throw Exception('Failed to load teachers detail');
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
          text("  ALL Teachers", 15, FontWeight.w600, Colors.black54),
          SizedBox(
            height: 8,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: FutureBuilder<List<Teachers>>(
                  future: teachers,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No teachers found.'));
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
                                headingRowColor:
                                    MaterialStateProperty.resolveWith(
                                        (states) => Colors.grey.shade200),
                                headingRowHeight: 50,
                                dividerThickness: 0,
                                columnSpacing: 46,
                                columns: [
                                  DataColumn(
                                      label: Text('  Image',
                                          style: TextStyle(fontSize: 12))),
                                  DataColumn(
                                      label: Text(
                                    'Teacher Name',
                                    style: TextStyle(fontSize: 12),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Classes',
                                    style: TextStyle(fontSize: 12),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Subjects',
                                    style: TextStyle(fontSize: 12),
                                  )),
                                  DataColumn(
                                      label: Text(
                                        'Gender',
                                        style: TextStyle(fontSize: 12),
                                      )),
                                  DataColumn(
                                      label: Text(
                                    'DOB',
                                    style: TextStyle(fontSize: 12),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'ID No',
                                    style: TextStyle(fontSize: 12),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Email',
                                    style: TextStyle(fontSize: 12),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Cell No',
                                    style: TextStyle(fontSize: 12),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Address',
                                    style: TextStyle(fontSize: 12),
                                  )),
                                ],
                                rows: snapshot.data!.map((teachers) {
                                  return DataRow(cells: [
                                    // DataCell(
                                    //   student.imagePath.isNotEmpty
                                    //       ? Row(
                                    //           children: [
                                    //             Image.file(
                                    //               File(student.imagePath),
                                    //               width: 50,
                                    //               height: 50,
                                    //               fit: BoxFit.cover,
                                    //             ),
                                    //           ],
                                    //         )
                                    //       : Container(),
                                    // ),
                                    DataCell(Text(
                                      teachers.firstName,
                                      style: TextStyle(fontSize: 12),
                                    )),

                                    DataCell(Text(
                                      teachers.firstName,
                                      style: TextStyle(fontSize: 12),
                                    )),
                                    DataCell(Text(
                                      teachers.firstName,
                                      style: TextStyle(fontSize: 12),
                                    )),
                                    DataCell(Text(
                                      teachers.firstName,
                                      style: TextStyle(fontSize: 12),
                                    )),
                                    DataCell(Text(
                                      teachers.dob,
                                      style: TextStyle(fontSize: 12),
                                    )),
                                    DataCell(Text(
                                      teachers.firstName,
                                      style: TextStyle(fontSize: 12),
                                    )),
                                    DataCell(Text(
                                      teachers.firstName,
                                      style: TextStyle(fontSize: 12),
                                    )),
                                    DataCell(Text(
                                      teachers.email,
                                      style: TextStyle(fontSize: 12),
                                    )),
                                    DataCell(Text(
                                      teachers.firstName,
                                      style: TextStyle(fontSize: 12),
                                    )),
                                    DataCell(Text(
                                      teachers.firstName,
                                      style: TextStyle(fontSize: 12),
                                    )),
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
