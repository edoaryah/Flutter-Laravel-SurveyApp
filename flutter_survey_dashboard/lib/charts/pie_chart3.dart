// ignore_for_file: unused_local_variable, prefer_const_constructors, use_key_in_widget_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_survey_dashboard/pages/homepage.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String urlPieChart3 = urlDomain + 'api/respondents-by-nationality';

class NationalityPieChart extends StatefulWidget {
  @override
  State<NationalityPieChart> createState() => _NationalityPieChartState();
}

class _NationalityPieChartState extends State<NationalityPieChart> {
  List? country;
  String? error;
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    fetchData6();
  }

  Future<void> fetchData6() async {
    try {
      final response = await http.get(Uri.parse(urlPieChart3));

      if (response.statusCode == 200) {
        setState(() {
          country = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nationality Pie Chart'),
        backgroundColor: Color.fromARGB(255, 205, 0, 0),
      ),
      body: Center(
        child: country != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 1.3,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 85,
                        sections: showingSections(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Wrap(
                    spacing: 16.0,
                    runSpacing: 8.0,
                    children: country!.asMap().entries.map((entry) {
                      final index = entry.key;
                      final nationality = entry.value['Nationality'];
                      final color = getColor(index);

                      return Indicator(
                        color: color,
                        text: nationality,
                        isSquare: true,
                      );
                    }).toList(),
                  ),
                ],
              )
            : Center(
                child: error != null
                    ? Text('Error: $error')
                    : CircularProgressIndicator(),
              ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    double total = 0;
    if (country != null) {
      for (var item in country!) {
        total += item['count'];
      }
    }

    return List.generate(country!.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 80.0 : 70.0;
      final nationality = country![i]['Nationality'];
      final count = country![i]['count'];
      final percentage = (count / total) * 100;

      return PieChartSectionData(
        color: getColor(i),
        value: percentage,
        title: '${percentage.toStringAsFixed(2)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      );
    });
  }

  Color getColor(int index) {
    List<Color> colors = [
      Color(0xFFE57373),
      Color(0xFFFFD54F),
      Color(0xFF64B5F6),
      Color(0xFF81C784),
      Color(0xFFFFB74D),
      Color(0xFF9575CD),
    ];

    return colors[index % colors.length];
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator(
      {Key? key,
      required this.color,
      required this.text,
      this.isSquare = false,
      this.size = 16,
      this.textColor = const Color(0xff505050)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: Row(
        children: <Widget>[
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          )
        ],
      ),
    );
  }
}
