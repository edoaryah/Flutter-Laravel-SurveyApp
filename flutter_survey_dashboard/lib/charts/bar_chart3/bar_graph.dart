import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_survey_dashboard/charts/bar_chart3/bar_data.dart';
import 'package:flutter_survey_dashboard/charts/bar_chart3/individual_bar.dart';

class MyBarGraph3 extends StatefulWidget {
  final List<KelulusanTotal> kelulusanData;
  final int totalRespondents;
  const MyBarGraph3(
      {super.key, required this.kelulusanData, required this.totalRespondents});

  @override
  State<MyBarGraph3> createState() {
    return _MyBarGraph3State();
  }
}

class _MyBarGraph3State extends State<MyBarGraph3>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uniqueIDs = assignUniqueIDs(widget.kelulusanData);
    final List<IndividualBar> bars = widget.kelulusanData
        .map((data) =>
            IndividualBar(x: uniqueIDs[data.tahunlulus] ?? 0, y: data.count))
        .toList();

    double maxDataValue = 0;
    for (var data in bars) {
      if (data.y > maxDataValue) {
        maxDataValue = data.y;
      }
    }

    return BarChart(
      BarChartData(
        maxY: maxDataValue,
        minY: 0,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitles,
            ),
          ),
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final data = widget.kelulusanData[groupIndex];
              final percentage = (data.count / widget.totalRespondents) * 100;
              return BarTooltipItem(
                '${percentage.toStringAsFixed(2)}%',
                const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              );
            },
          ),
          touchCallback:
              (FlTouchEvent event, BarTouchResponse? touchResponse) {},
        ),
        barGroups: bars
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y * _animation.value,
                    color: Colors.grey[800],
                    width: 20,
                    borderRadius: BorderRadius.circular(4),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: maxDataValue,
                      // color: Colors.grey[200],
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

Map<String, int> assignUniqueIDs(List<KelulusanTotal> genreData) {
  final uniqueIDs = <String, int>{};
  for (int i = 0; i < genreData.length; i++) {
    uniqueIDs[genreData[i].tahunlulus] = i;
  }
  return uniqueIDs;
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('2018', style: style);
      break;
    case 1:
      text = const Text('2019', style: style);
      break;
    case 2:
      text = const Text('2020', style: style);
      break;
    case 3:
      text = const Text('2021', style: style);
      break;
    case 4:
      text = const Text('2022', style: style);
      break;
    case 5:
      text = const Text('2023', style: style);
      break;
    case 6:
      text = const Text('2024', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
