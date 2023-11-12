import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey_dashboard/models/gender.dart';

// class MyPieChart extends StatelessWidget {
//   final List<GenderRespondents> genderRespondents;

//   const MyPieChart({Key? key, required this.genderRespondents})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.3,
//       child: TweenAnimationBuilder(
//         duration: const Duration(milliseconds: 500),
//         tween: Tween<double>(begin: 270, end: 360),
//         builder: (context, double value, child) {
//           return Transform.rotate(
//             angle: -value * pi / 180,
//             child: PieChart(
//               PieChartData(
//                 startDegreeOffset: value,
//                 sections: genderRespondents
//                     .map((item) => PieChartSectionData(
//                           value: item.count.toDouble(),
//                           color: item.gender == 'M'
//                               ? const Color(0xff0293ee)
//                               : const Color(0xfff8b250),
//                           title:
//                               '${((item.count.toDouble()) / (genderRespondents.fold(0, (previousValue, element) => previousValue + element.count)) * 100).toStringAsFixed(2)}%',
//                           radius: 75,
//                         ))
//                     .toList(),
//                 sectionsSpace: 0,
//                 centerSpaceRadius: 0,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class MyPieChart extends StatefulWidget {
  final List<GenderRespondents> genderRespondents;

  const MyPieChart({Key? key, required this.genderRespondents})
      : super(key: key);

  @override
  State<MyPieChart> createState() {
    return _MyPieChartState();
  }
}

class _MyPieChartState extends State<MyPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 500),
        tween: Tween<double>(begin: 270, end: 360),
        builder: (context, double value, child) {
          return Transform.rotate(
            angle: -value * pi / 180,
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
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                startDegreeOffset: value,
                sections: showingSections(),
                sectionsSpace: 3,
                centerSpaceRadius: 0,
              ),
            ),
          );
        },
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.genderRespondents.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 85.0 : 75.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      final item = widget.genderRespondents[i];
      return PieChartSectionData(
        color: item.gender == 'M' ? Colors.blueAccent : Colors.pinkAccent,
        value: item.count.toDouble(),
        title:
            '${((item.count.toDouble()) / (widget.genderRespondents.fold(0, (previousValue, element) => previousValue + element.count)) * 100).toStringAsFixed(2)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
          shadows: shadows,
        ),
        badgePositionPercentageOffset: .98,
      );
    });
  }
}
