import 'package:flutter/material.dart';

class ListPageReport extends StatefulWidget {
  const ListPageReport({Key? key}) : super(key: key);

  @override
  _ListPageReportState createState() => _ListPageReportState();
}

class _ListPageReportState extends State<ListPageReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('Samain aja stylenya kaya list report'),
    ));
  }
}
