import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:school_management_system/Widgets/text.dart';
import 'package:school_management_system/Widgets/textField.dart';

class AddTeacher extends StatefulWidget {
  const AddTeacher({super.key});

  @override
  State<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();
  final TextEditingController _admissionNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _fatherOccupationController =
  TextEditingController();
  final TextEditingController _motherOccupationController = TextEditingController();
  final TextEditingController _fatherCellNoController = TextEditingController();
  final TextEditingController _motherCellNoController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  File? _image;
  String? _selectedGender;

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        _image = File(result.files.single.path!);
      });
    }
  }

  Future<void> sendStudentData(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Saving Data'),
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text('Saving teacher data...'),
            ],
          ),
        );
      },
    );

    const String url = 'http://localhost:3000/students';
    Map<String, String> studentData = {
      'first_name': _firstNameController.text,
      'last_name': _lastNameController.text,
      'class': _classController.text,
      'section': _sectionController.text,
      'dob': _dobController.text,
      'roll_no': _rollNoController.text,
      'admission_no': _admissionNoController.text,
      'email': _emailController.text,
      'father_name': _fatherNameController.text,
      'mother_name': _motherNameController.text,
      'father_occupation': _fatherOccupationController.text,
      'mother_occupation': _motherOccupationController.text,
      'father_cell_no': _fatherCellNoController.text,
      'mother_cell_no': _motherCellNoController.text,
      'address': _addressController.text,
      'gender': _selectedGender ?? '',
    };

    var request = http.MultipartRequest('POST', Uri.parse(url));
    studentData.forEach((key, value) {
      request.fields[key] = value;
    });

    if (_image != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', _image!.path));
    }

    try {
      var response = await request.send();
      Navigator.pop(context); // Close the dialog

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Student data saved successfully.'),
              backgroundColor: Colors.green),
        );
        print('Student data saved successfully.');
        _clearForm();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to save student data. Status code: ${response.statusCode}'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 4)),
        );
        print(
            'Failed to save student data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      Navigator.pop(context); // Close the dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Error sending student data: $e'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 4)),
      );
      print('Error sending student data: $e');
    }
  }

  void _clearForm() {
    _firstNameController.clear();
    _lastNameController.clear();
    _classController.clear();
    _sectionController.clear();
    _dobController.clear();
    _rollNoController.clear();
    _admissionNoController.clear();
    _emailController.clear();
    _fatherNameController.clear();
    _motherNameController.clear();
    _fatherOccupationController.clear();
    _motherOccupationController.clear();
    _fatherCellNoController.clear();
    _motherCellNoController.clear();
    _addressController.clear();
    _image = null;
    _selectedGender = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text("  TEACHER ADMIT FORM", 15, FontWeight.w600, Colors.black54),
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
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            text("Teacher Information", 16, FontWeight.w600,
                                Colors.black),
                            SizedBox(
                              height: 18,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      text("First Name", 11, FontWeight.w600,
                                          Colors.black45),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      textField(
                                          controller: _firstNameController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter first name';
                                            }
                                            return null;
                                          }),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      text("Last Name", 11, FontWeight.w600,
                                          Colors.black45),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      textField(
                                          controller: _lastNameController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter last name';
                                            }
                                            return null;
                                          }),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      text("Gender", 11, FontWeight.w600,
                                          Colors.black45),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.08),
                                          borderRadius:
                                          BorderRadius.circular(6),
                                          border: Border.all(
                                              color: Colors.transparent),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: _selectedGender,
                                            items: ['Male', 'Female', 'Other']
                                                .map((String value) =>
                                                DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                        12.0),
                                                    child: Text(
                                                      value,
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                ))
                                                .toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                _selectedGender = newValue;
                                              });
                                            },
                                            dropdownColor: Colors.white,
                                            isExpanded: true,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      text("Classes", 11, FontWeight.w600,
                                          Colors.black45),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      textField(
                                          controller: _classController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter class';
                                            }
                                            return null;
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      text("Gender", 11, FontWeight.w600,
                                          Colors.black45),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.08),
                                          borderRadius:
                                          BorderRadius.circular(6),
                                          border: Border.all(
                                              color: Colors.transparent),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: _selectedGender,
                                            items: ['Male', 'Female', 'Other']
                                                .map((String value) =>
                                                DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                        12.0),
                                                    child: Text(
                                                      value,
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                ))
                                                .toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                _selectedGender = newValue;
                                              });
                                            },
                                            dropdownColor: Colors.white,
                                            isExpanded: true,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      text("Date of birth   (dd/mm/yyyy)", 11,
                                          FontWeight.w600, Colors.black45),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      textField(
                                          controller: _dobController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter date of birth';
                                            }
                                            return null;
                                          }),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      text("Roll no", 11, FontWeight.w600,
                                          Colors.black45),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      textField(
                                          controller: _rollNoController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter roll number';
                                            }
                                            return null;
                                          }),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      text("Admission no", 11, FontWeight.w600,
                                          Colors.black45),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      textField(
                                          controller: _admissionNoController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter admission number';
                                            }
                                            return null;
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      text("Email", 11, FontWeight.w600, Colors.black45),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      textField(
                                          controller: _emailController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter email';
                                            }
                                            return null;
                                          }),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      text("Upload student image", 11,
                                          FontWeight.w600, Colors.black45),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      GestureDetector(
                                        onTap: _pickImage,
                                        child: Container(
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color:
                                            Colors.black.withOpacity(0.08),
                                            borderRadius:
                                            BorderRadius.circular(6),
                                            border: Border.all(
                                                color: Colors.transparent),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  _image == null
                                                      ? ''
                                                      : '   Image Selected',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(child: Container()),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(child: Container()),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            text("Parents Information", 16, FontWeight.w600, Colors.black),
                            SizedBox(
                              height: 18,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      text("Father Name", 11, FontWeight.w600,
                                          Colors.black45),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      textField(
                                          controller: _fatherNameController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter father name';
                                            }
                                            return null;
                                          }),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      text("Mother Name", 11, FontWeight.w600,
                                          Colors.black45),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      textField(
                                          controller: _motherNameController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter mother name';
                                            }
                                            return null;
                                          }),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      text("Father Occupation", 11,
                                          FontWeight.w600, Colors.black45),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      textField(
                                          controller:
                                          _fatherOccupationController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter father occupation';
                                            }
                                            return null;
                                          }),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      text("Mother Occupation", 11,
                                          FontWeight.w600, Colors.black45),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      textField(
                                          controller:
                                          _motherOccupationController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter mother occupation';
                                            }
                                            return null;
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      text("Father cell no", 11,
                                          FontWeight.w600, Colors.black45),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      textField(
                                          controller: _fatherCellNoController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter father cell number';
                                            }
                                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                              return 'Please enter a valid phone number';
                                            }
                                            // Check if the entered value has exactly 10 digits
                                            if (value.length != 11) {
                                              return 'Phone number must be exactly 10 digits long';
                                            }
                                            return null;
                                          }),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      text("Mother cell no", 11,
                                          FontWeight.w600, Colors.black45),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      textField(
                                          controller: _motherCellNoController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter mother cell number';
                                            }
                                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                              return 'Please enter a valid phone number';
                                            }
                                            // Check if the entered value has exactly 10 digits
                                            if (value.length != 11) {
                                              return 'Phone number must be exactly 10 digits long';
                                            }
                                            return null;
                                          }),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:

                                    CrossAxisAlignment.start,
                                    children: [
                                      text("Address", 11, FontWeight.w600,
                                          Colors.black45),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      textField(
                                          controller: _addressController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter address';
                                            }
                                            return null;
                                          }),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(child: Container()),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade400,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6))),
                      onPressed: () {
                        setState(() {
                          _formKey.currentState?.reset();
                          _firstNameController.clear();
                          _lastNameController.clear();
                          _classController.clear();
                          _sectionController.clear();
                          _dobController.clear();
                          _rollNoController.clear();
                          _admissionNoController.clear();
                          _emailController.clear();
                          _fatherNameController.clear();
                          _motherNameController.clear();
                          _fatherOccupationController.clear();
                          _motherOccupationController.clear();
                          _fatherCellNoController.clear();
                          _motherCellNoController.clear();
                          _addressController.clear();
                          _image = null;
                          _selectedGender = null;
                        });
                      },
                      child: text("Reset", 14, FontWeight.w500, Colors.white),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6))),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          sendStudentData(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                Text('Please fill all required fields')),
                          );
                        }
                      },
                      child: text("Save", 14, FontWeight.w500, Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
