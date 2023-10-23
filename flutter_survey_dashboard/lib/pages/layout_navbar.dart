// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_survey_dashboard/pages/homepage.dart';
import 'package:flutter_survey_dashboard/pages/listpage.dart';

class LayoutNavigationBar extends StatefulWidget {
  const LayoutNavigationBar({super.key});

  @override
  State<LayoutNavigationBar> createState() => _LayoutNavigationBar();
}

class _LayoutNavigationBar extends State<LayoutNavigationBar> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    Listpage(),
    Homepage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
        ],
      ),
    );
  }
}
