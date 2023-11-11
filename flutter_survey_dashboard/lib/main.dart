import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_survey_dashboard/pages/layout_navbar.dart';
import 'package:overlay_support/overlay_support.dart';

void main() {
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
          body: LayoutNavigationBar(),
        ),
      ),
    );
  }
}
