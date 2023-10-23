// ignore_for_file: prefer_const_constructors, no_logic_in_create_state, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartPage extends StatefulWidget {
  final double maleCount;
  final double femaleCount;

  const PieChartPage({
    Key? key,
    required this.maleCount,
    required this.femaleCount,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChart2State(maleCount, femaleCount);
}

class PieChart2State extends State<PieChartPage> {
  double maleCount;
  double femaleCount;
  int touchedIndex = -1;

  PieChart2State(this.maleCount, this.femaleCount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pie Chart Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 1.3,
              child: Container(
                decoration: BoxDecoration(),
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
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
                    centerSpaceRadius: 80,
                    sections: showingSections(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Indicator(
                    color: Colors.blue,
                    text: 'Male',
                    isSquare: true,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Indicator(
                    color: Colors.pink,
                    text: 'Female',
                    isSquare: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    final malePercentage = (maleCount / (maleCount + femaleCount)) * 100;
    final femalePercentage = (femaleCount / (maleCount + femaleCount)) * 100;

    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 80.0 : 70.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      if (i == 0) {
        return PieChartSectionData(
          color: Colors.blue,
          value: malePercentage,
          title: '${malePercentage.toStringAsFixed(2)}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      } else {
        return PieChartSectionData(
          color: Colors.pink,
          value: femalePercentage,
          title: '${femalePercentage.toStringAsFixed(2)}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      }
    });
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
    return Row(
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
    );
  }
}
