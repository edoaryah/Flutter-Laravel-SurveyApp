import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey_dashboard/models/gender.dart';

class MyPieChart extends StatelessWidget {
  final List<GenderRespondents> genderRespondents;

  const MyPieChart({Key? key, required this.genderRespondents})
      : super(key: key);

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
                startDegreeOffset: value,
                sections: genderRespondents
                    .map((item) => PieChartSectionData(
                          value: item.count.toDouble(),
                          color: item.gender == 'M'
                              ? const Color(0xff0293ee)
                              : const Color(0xfff8b250),
                          title:
                              '${((item.count.toDouble()) / (genderRespondents.fold(0, (previousValue, element) => previousValue + element.count)) * 100).toStringAsFixed(2)}%',
                          radius: 75,
                        ))
                    .toList(),
                sectionsSpace: 0,
                centerSpaceRadius: 0,
              ),
            ),
          );
        },
      ),
    );
  }
}

// child: AspectRatio(
                                //   aspectRatio: 1.3,
                                //   child: TweenAnimationBuilder(
                                //     duration: const Duration(milliseconds: 500),
                                //     tween: Tween<double>(begin: 270, end: 360),
                                //     builder: (context, double value, child) {
                                //       return Transform.rotate(
                                //         angle: -value * pi / 180,
                                //         child: PieChart(
                                //           PieChartData(
                                //             startDegreeOffset: value,
                                //             sections: genderRespondents!
                                //                 .map((item) =>
                                //                     PieChartSectionData(
                                //                       value:
                                //                           item.count.toDouble(),
                                //                       color: item.gender == 'M'
                                //                           ? const Color(
                                //                               0xff0293ee)
                                //                           : const Color(
                                //                               0xfff8b250),
                                //                       title:
                                //                           '${((item.count.toDouble()) / (genderRespondents!.fold(0, (previousValue, element) => previousValue + element.count)) * 100).toStringAsFixed(2)}%',
                                //                       radius: 75,
                                //                     ))
                                //                 .toList(),
                                //             sectionsSpace: 0,
                                //             centerSpaceRadius: 0,
                                //           ),
                                //         ),
                                //       );
                                //     },
                                //   ),
                                // ),