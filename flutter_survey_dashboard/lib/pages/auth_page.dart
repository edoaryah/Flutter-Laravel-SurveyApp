import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_survey_dashboard/pages/layout_navbar.dart';
import 'package:flutter_survey_dashboard/pages/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged in
          if (snapshot.hasData) {
            return const LayoutNavigationBar();
          } else {
            //user is not logged in
            return LoginPage();
          }
        },
      ),
    );
  }
}
