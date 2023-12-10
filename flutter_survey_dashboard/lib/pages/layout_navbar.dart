import 'package:flutter/material.dart';
import 'package:flutter_survey_dashboard/pages/homepage.dart';
import 'package:flutter_survey_dashboard/pages/listpage.dart';
import 'package:flutter_survey_dashboard/pages/form.dart';
import 'package:flutter_survey_dashboard/pages/formreport.dart';
import 'package:flutter_survey_dashboard/pages/listpagereport.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LayoutNavigationBar extends StatefulWidget {
  const LayoutNavigationBar({super.key});

  @override
  State<LayoutNavigationBar> createState() => _LayoutNavigationBar();
}

class _LayoutNavigationBar extends State<LayoutNavigationBar> {
  int _currentIndex = 2;
  int _activePage = 2;
  String _activeTitle = 'Dashboard';

  final List<Widget> _children = [
    const ListPageReport(),
    const Listpage(),
    const Homepage(),
    const FormPage(),
    const FormReportPage(),
  ];

  final List<String> _titles = [
    'Reports',
    'Survey',
    'Dashboard',
    'Form Survey',
    'Form Report',
  ];

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_activeTitle),
        backgroundColor: const Color.fromARGB(255, 205, 0, 0),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          ),
          // IconButton(
          //   onPressed: () {
          //     final user = FirebaseAuth.instance.currentUser;
          //     if (user != null && user.email != null) {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         SnackBar(content: Text('Logged in as: ${user.email}')),
          //       );
          //     } else {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         SnackBar(content: Text('No user is currently logged in.')),
          //       );
          //     }
          //   },
          //   icon: Icon(Icons.account_circle),
          // ),
          IconButton(
            onPressed: () {
              final user = FirebaseAuth.instance.currentUser;
              if (user != null && user.email != null) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: SizedBox(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Logged in as:',
                                style: TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${user.email}',
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const Dialog(
                      child: SizedBox(
                        height: 100, // Ubah tinggi dialog sesuai kebutuhan Anda
                        child: Padding(
                          padding:
                              EdgeInsets.all(16.0), // Tambahkan padding di sini
                          child: Center(
                            child: Text(
                              'No user is currently logged in.',
                              style: TextStyle(
                                  fontSize:
                                      14), // Ubah ukuran font sesuai kebutuhan Anda
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
            icon: const Icon(Icons.account_circle),
          ),
        ],
      ),
      body: _children[_activePage],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
        backgroundColor: const Color.fromARGB(255, 205, 0, 0),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (int index) {
          if (index == 3) {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.format_list_bulleted_add),
                      title: const Text('Survey Form'),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          _activePage = 3;
                          _activeTitle = _titles[3];
                          _currentIndex = 3;
                        });
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.assignment_add),
                      title: const Text('Report Form'),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          _activePage = 4;
                          _activeTitle = _titles[4];
                          _currentIndex = 3;
                        });
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            setState(() {
              _currentIndex = index;
              _activePage = index;
              _activeTitle = _titles[index];
            });
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Survey',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted_add),
            label: 'Form',
          ),
        ],
      ),
    );
  }
}
