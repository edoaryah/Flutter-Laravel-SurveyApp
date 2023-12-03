import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_survey_dashboard/pages/auth_page.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return const OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: AuthPage(),
        ),
      ),
    );
  }
}
