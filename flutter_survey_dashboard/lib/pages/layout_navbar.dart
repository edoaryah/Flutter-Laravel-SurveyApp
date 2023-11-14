import 'package:flutter/material.dart';
import 'package:flutter_survey_dashboard/pages/homepage.dart';
import 'package:flutter_survey_dashboard/pages/listpage.dart';
import 'package:flutter_survey_dashboard/pages/form.dart';

class LayoutNavigationBar extends StatefulWidget {
  const LayoutNavigationBar({super.key});

  @override
  State<LayoutNavigationBar> createState() => _LayoutNavigationBar();
}

class _LayoutNavigationBar extends State<LayoutNavigationBar> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    const Listpage(),
    const Homepage(),
    const FormPage(),
  ];

  final List<String> _titles = [
    'List Survey',
    'Dashboard',
    'Add Response',
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
        // type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            backgroundColor: Color.fromARGB(255, 205, 0, 0),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Color.fromARGB(255, 205, 0, 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted_add),
            backgroundColor: Color.fromARGB(255, 205, 0, 0),
            label: 'Add Survey',
          ),
        ],
      ),
    );
  }
}
