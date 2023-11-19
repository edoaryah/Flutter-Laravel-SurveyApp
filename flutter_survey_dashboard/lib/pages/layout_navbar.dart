import 'package:flutter/material.dart';
import 'package:flutter_survey_dashboard/pages/homepage.dart';
import 'package:flutter_survey_dashboard/pages/listpage.dart';
import 'package:flutter_survey_dashboard/pages/form.dart';
import 'package:flutter_survey_dashboard/pages/formreport.dart';
import 'package:flutter_survey_dashboard/pages/listpagereport.dart';

class LayoutNavigationBar extends StatefulWidget {
  const LayoutNavigationBar({super.key});

  @override
  State<LayoutNavigationBar> createState() => _LayoutNavigationBar();
}

class _LayoutNavigationBar extends State<LayoutNavigationBar> {
  int _currentIndex = 2;
  final List<Widget> _children = [
    const ListPageReport(),
    const Listpage(),
    const Homepage(),
    const FormPage(),
    const FormReportPage(),
  ];

  final List<String> _titles = [
    'List Reports',
    'List Survey',
    'Dashboard',
    'Add Survey',
    'Add Reports',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        backgroundColor: const Color.fromARGB(255, 205, 0, 0),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
        backgroundColor: const Color.fromARGB(255, 205, 0, 0),
        type: BottomNavigationBarType.fixed, // Change to fixed
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted_add),
            label: 'Add Survey',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_add),
            label: 'Add Report',
          ),
        ],
      ),
    );
  }
}
