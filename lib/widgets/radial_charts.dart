import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RadialChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const RadialChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      legend: const Legend(
        isVisible: true,
        position: LegendPosition.bottom,
        overflowMode: LegendItemOverflowMode.wrap,
        alignment: ChartAlignment.near,
        padding: 20,
      ),
      series: <RadialBarSeries<Map<String, dynamic>, String>>[
        RadialBarSeries<Map<String, dynamic>, String>(
          dataSource: data,
          xValueMapper: (Map<String, dynamic> data, _) => data['name'],
          yValueMapper: (Map<String, dynamic> data, _) =>
              data['count'].toDouble(),
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
          ),
          pointColorMapper: (Map<String, dynamic> data, int index) =>
              _getUniqueColor(index),
          maximumValue: _getMaxValue(),
          radius: '100%',
          innerRadius: '50%',
          trackColor: Colors.grey.shade300,
        ),
      ],
    );
  }

  Color _getUniqueColor(int index) {
    const List<Color> uniqueColors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.teal,
      Colors.black,
      Colors.pink,
      Colors.yellow,
      Colors.cyan,
    ];


    if (index < uniqueColors.length) {
      return uniqueColors[index];
    } else {
      // This generates a unique color incase the list of data exceed the available number of colors
      return HSLColor.fromAHSL(
        1.0,
        (index * 360 / uniqueColors.length) %
            360,
        0.7,
        0.5,
      ).toColor();
    }
  }

  double _getMaxValue() {
    return data
            .map((e) => e['count'] as int)
            .reduce((a, b) => a > b ? a : b)
            .toDouble() *
        1.2;
  }
}
