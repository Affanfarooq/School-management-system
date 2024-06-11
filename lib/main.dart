import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_management_system/Screens/Dashboard.dart';
import 'package:school_management_system/Screens/Parents.dart';
import 'package:school_management_system/Screens/Students/Admit%20Student.dart';
import 'package:school_management_system/Screens/Students/All%20Students.dart';
import 'package:school_management_system/Screens/Students/Student%20Details.dart';
import 'package:school_management_system/Screens/Teachers/Add%20Teacher.dart';
import 'package:school_management_system/Screens/Teachers/All%20Teachers.dart';
import 'package:school_management_system/Screens/Teachers/Teachers%20Detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'School Management System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'School Management System'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    AllStudents(),
    StudentDetails(),
    AdmitStudent(),
    AllTeachers(),
    TeachersDetail(),
    AddTeachers(),
    Parents(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.blueGrey.shade200,
        title: Text(
          widget.title,
          style: TextStyle(
              color: Colors.blueGrey.shade800, fontWeight: FontWeight.w800),
        ),
      ),
      body: Row(
        children: <Widget>[
          Container(
            width: 250,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      SidebarTile(
                        icon: Icons.dashboard,
                        title: 'Dashboard',
                        isSelected: _selectedIndex == 0,
                        onTap: () => _onItemTapped(0),
                      ),
                      SidebarExpansionTile(
                        icon: CupertinoIcons.person_3_fill,
                        title: 'Students',
                        children: <SidebarTile>[
                          SidebarTile(
                            icon: Icons.menu,
                            title: 'All Students',
                            isSelected: _selectedIndex == 1,
                            onTap: () => _onItemTapped(1),
                          ),
                          SidebarTile(
                            icon: Icons.menu,
                            title: 'Student Details',
                            isSelected: _selectedIndex == 2,
                            onTap: () => _onItemTapped(2),
                          ),
                          SidebarTile(
                            icon: Icons.menu,
                            title: 'Admit Form',
                            isSelected: _selectedIndex == 3,
                            onTap: () => _onItemTapped(3),
                          ),
                        ],
                      ),
                      SidebarExpansionTile(
                        icon: CupertinoIcons.person_2_fill,
                        title: 'Teachers',
                        children: <SidebarTile>[
                          SidebarTile(
                            icon: Icons.menu,
                            title: 'All Teacher',
                            isSelected: _selectedIndex == 4,
                            onTap: () => _onItemTapped(4),
                          ),
                          SidebarTile(
                            icon: Icons.menu,
                            title: 'Teacher Details',
                            isSelected: _selectedIndex == 5,
                            onTap: () => _onItemTapped(5),
                          ),
                          SidebarTile(
                            icon: Icons.menu,
                            title: 'Add Teacher',
                            isSelected: _selectedIndex == 6,
                            onTap: () => _onItemTapped(6),
                          ),
                        ],
                      ),
                      SidebarTile(
                        icon: CupertinoIcons.rectangle_stack_person_crop_fill,
                        title: 'Parents',
                        isSelected: _selectedIndex == 7,
                        onTap: () => _onItemTapped(7),
                      ),
                      SidebarTile(
                        icon: Icons.settings,
                        title: 'Library',
                        isSelected: _selectedIndex == 4,
                        onTap: () => _onItemTapped(4),
                      ),
                      SidebarTile(
                        icon: Icons.settings,
                        title: 'Account',
                        isSelected: _selectedIndex == 5,
                        onTap: () => _onItemTapped(5),
                      ),
                      SidebarTile(
                        icon: Icons.settings,
                        title: 'Class',
                        isSelected: _selectedIndex == 6,
                        onTap: () => _onItemTapped(6),
                      ),
                      SidebarTile(
                        icon: Icons.settings,
                        title: 'Subject',
                        isSelected: _selectedIndex == 7,
                        onTap: () => _onItemTapped(7),
                      ),
                      SidebarTile(
                        icon: Icons.settings,
                        title: 'Class Routine',
                        isSelected: _selectedIndex == 8,
                        onTap: () => _onItemTapped(8),
                      ),
                      SidebarTile(
                        icon: Icons.settings,
                        title: 'Attendence',
                        isSelected: _selectedIndex == 9,
                        onTap: () => _onItemTapped(9),
                      ),
                      SidebarTile(
                        icon: Icons.settings,
                        title: 'Exams',
                        isSelected: _selectedIndex == 10,
                        onTap: () => _onItemTapped(10),
                      ),
                      SidebarTile(
                        icon: Icons.settings,
                        title: 'Transport',
                        isSelected: _selectedIndex == 11,
                        onTap: () => _onItemTapped(11),
                      ),
                      SidebarTile(
                        icon: Icons.settings,
                        title: 'Notice',
                        isSelected: _selectedIndex == 12,
                        onTap: () => _onItemTapped(12),
                      ),
                      SidebarTile(
                        icon: Icons.settings,
                        title: 'Account',
                        isSelected: _selectedIndex == 13,
                        onTap: () => _onItemTapped(13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
    );
  }
}

class SidebarTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const SidebarTile({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey.shade300),
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 14)),
      selected: isSelected,
      selectedTileColor: Colors.blueGrey.shade700,
      tileColor: Colors.blueGrey.shade900,
      onTap: onTap,
    );
  }
}

class SidebarExpansionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<SidebarTile> children;

  const SidebarExpansionTile({
    required this.icon,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.shade900,
      child: ExpansionTile(
        backgroundColor: Colors.blueGrey.shade700,
        leading: Icon(icon, color: Colors.blueGrey.shade300),
        title: Text(title, style: TextStyle(color: Colors.white, fontSize: 14)),
        children: children,
      ),
    );
  }
}
