import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_survey_dashboard/charts/bar_chart2/bar_data.dart';
import 'package:flutter_survey_dashboard/charts/bar_chart2/individual_bar.dart';

class MyBarGraph2 extends StatefulWidget {
  final List<GenreTotal> genreData;
  final int totalRespondents;
  const MyBarGraph2(
      {super.key, required this.genreData, required this.totalRespondents});

  @override
  State<MyBarGraph2> createState() {
    return _MyBarGraph2State();
  }
}

class _MyBarGraph2State extends State<MyBarGraph2>
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
    final uniqueIDs = assignUniqueIDs(widget.genreData);
    final List<IndividualBar> bars = widget.genreData
        .map((data) =>
            IndividualBar(x: uniqueIDs[data.genre] ?? 0, y: data.count))
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
              final data = widget.genreData[groupIndex];
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
                    width: 15,
                    borderRadius: BorderRadius.circular(4),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: maxDataValue,
                      color: Colors.grey[200],
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

Map<String, int> assignUniqueIDs(List<GenreTotal> genreData) {
  final uniqueIDs = <String, int>{};
  for (int i = 0; i < genreData.length; i++) {
    uniqueIDs[genreData[i].genre] = i;
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
      text = const Text('1', style: style);
      break;
    case 1:
      text = const Text('2', style: style);
      break;
    case 2:
      text = const Text('3', style: style);
      break;
    case 3:
      text = const Text('4', style: style);
      break;
    case 4:
      text = const Text('5', style: style);
      break;
    case 5:
      text = const Text('6', style: style);
      break;
    case 6:
      text = const Text('7', style: style);
      break;
    case 7:
      text = const Text('8', style: style);
      break;
    case 8:
      text = const Text('9', style: style);
      break;
    case 9:
      text = const Text('10', style: style);
      break;
    case 10:
      text = const Text('11', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
