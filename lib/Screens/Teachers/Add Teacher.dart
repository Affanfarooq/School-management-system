import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
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
  String? _selectedGender;
  final TextEditingController _dobController = TextEditingController();
  List<String> _selectedClasses = [];
  List<String> _selectedSubjects = [];
  final TextEditingController _rollNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fatherCellNoController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  File? _image;


  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        _image = File(result.files.single.path!);
      });
    }
  }


  Future<void> saveTeacherData(BuildContext context) async {
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
              Text('Saving Teacher data...'),
            ],
          ),
        );
      },
    );

    const String url = 'http://localhost:3000/teachers';
    Map<String, dynamic> teacherData = {
      'first_name': _firstNameController.text,
      'last_name': _lastNameController.text,
      'dob': _dobController.text,
      'ID_no': _rollNoController.text,
      'email': _emailController.text,
      'Cell_no': _fatherCellNoController.text,
      'address': _addressController.text,
      'gender': _selectedGender ?? '',
      'classes': _selectedClasses.join(','), // Convert list to comma-separated string
      'subjects': _selectedSubjects.join(','), // Convert list to comma-separated string
    };

    var request = http.MultipartRequest('POST', Uri.parse(url));
    teacherData.forEach((key, value) {
      request.fields[key] = value;
    });

    if (_image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', _image!.path));
    }

    try {
      var response = await request.send();
      Navigator.pop(context); // Close the dialog

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Teacher data saved successfully.'),
              backgroundColor: Colors.green),
        );
        print('Teacher data saved successfully.');
        _clearForm();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to save data. Status code: ${response.statusCode}'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 4)),
        );
        print('Failed to save data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      Navigator.pop(context); // Close the dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Error sending teacher data: $e'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 4)),
      );
      print('Error sending teacher data: $e');
    }
  }


  void _clearForm() {
    _firstNameController.clear();
    _lastNameController.clear();
    _dobController.clear();
    _rollNoController.clear();
    _emailController.clear();
    _fatherCellNoController.clear();
    _addressController.clear();
    _selectedClasses.clear();
    _selectedSubjects.clear();
    _image = null;
    _selectedGender = null;
    setState(() {});
  }

  final List<String> _classes = [
    'Class 1',
    'Class 2',
    'Class 3',
    'Class 4',
    'Class 5',
    'Class 6',
    'Class 7',
    'Class 8',
    'Class 9',
    'Class 10',
  ];
  final List<String> _subjects = [
    'English',
    'Urdu',
    'Mathematics',
    'Science',
    'Physics',
    'Chemistry',
    'Computer Science',
    'Social Studies',
    'Biology',
    'History',
    'Geography',
    'Economics',
    'Art',
    'Music',
    'Literature',
    'Languages',
    'Health Education',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.02),
                                        borderRadius:
                                        BorderRadius.circular(6),
                                        border: Border.all(
                                            color: Colors.transparent),
                                      ),
                                      child: MultiSelectDialogField(buttonIcon: Icon(Icons.arrow_drop_down_outlined,color: Colors.black87,),
                                        items: _classes
                                            .map((e) =>
                                            MultiSelectItem<String>(e, e))
                                            .toList(),
                                        title: Text("Select Classes"),
                                        selectedColor: Colors.blue,
                                        decoration: BoxDecoration(
                                          color:
                                          Colors.black.withOpacity(0.08),
                                          borderRadius:
                                          BorderRadius.circular(6),
                                          border: Border.all(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        buttonText: Text(
                                          "",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                          ),
                                        ),
                                        onConfirm: (results) {
                                          setState(() {
                                            _selectedClasses =
                                                results.cast<String>();
                                          });
                                        },
                                        chipDisplay: MultiSelectChipDisplay(
                                          items: _selectedClasses
                                              .map((e) =>
                                              MultiSelectItem<String>(
                                                  e, e))
                                              .toList(),
                                          chipColor:
                                          Colors.blue.withOpacity(0.5),
                                          textStyle:
                                          TextStyle(color: Colors.white),
                                          onTap: (item) {
                                            setState(() {
                                              _selectedClasses.remove(item);
                                            });
                                          },
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
                                    text("Subjects", 11, FontWeight.w600,
                                        Colors.black45),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.02),
                                        borderRadius:
                                        BorderRadius.circular(6),
                                        border: Border.all(
                                            color: Colors.transparent),
                                      ),
                                      child: MultiSelectDialogField(buttonIcon: Icon(Icons.arrow_drop_down_outlined,color: Colors.black87,),
                                        items: _subjects
                                            .map((e) =>
                                            MultiSelectItem<String>(e, e))
                                            .toList(),
                                        title: Text("Select Subjects"),
                                        selectedColor: Colors.blue,
                                        decoration: BoxDecoration(
                                          color:
                                          Colors.black.withOpacity(0.08),
                                          borderRadius:
                                          BorderRadius.circular(6),
                                          border: Border.all(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        buttonText: Text(
                                          "",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                          ),
                                        ),
                                        onConfirm: (results) {
                                          setState(() {
                                            _selectedSubjects =
                                                results.cast<String>();
                                          });
                                        },
                                        chipDisplay: MultiSelectChipDisplay(
                                          items: _selectedSubjects
                                              .map((e) =>
                                              MultiSelectItem<String>(
                                                  e, e))
                                              .toList(),
                                          chipColor:
                                          Colors.blue.withOpacity(0.5),
                                          textStyle:
                                          TextStyle(color: Colors.white),
                                          onTap: (item) {
                                            setState(() {
                                              _selectedSubjects.remove(item);
                                            });
                                          },
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
                                    text("ID no", 11, FontWeight.w600,
                                        Colors.black45),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    textField(
                                        controller: _rollNoController,
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty) {
                                            return 'Please enter ID number';
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
                                    text("Email", 11, FontWeight.w600,
                                        Colors.black45),
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
                                    text("Cell no", 11,
                                        FontWeight.w600, Colors.black45),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    textField(
                                        controller: _fatherCellNoController,
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty) {
                                            return 'Please enter cell number';
                                          }
                                          if (!RegExp(r'^[0-9]+$')
                                              .hasMatch(value)) {
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
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    text("Upload teacher image", 11,
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
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
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
                      _clearForm();
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
                        saveTeacherData(context);
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
    );
  }
}
