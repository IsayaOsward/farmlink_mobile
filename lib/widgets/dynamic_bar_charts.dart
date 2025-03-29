import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DynamicBarChart extends StatelessWidget {
  final String verticalAxisTitle; // Y-axis title
  final String horizontalAxisTitle; // X-axis title
  final Map<String, num> data; // Single key-value pair: category -> value
  final Map<String, Color>? colorMapping; // Optional custom color mapping
  final int
      maxLabelLength; // Maximum length for X-axis labels before truncation

  const DynamicBarChart({
    super.key,
    required this.verticalAxisTitle,
    required this.horizontalAxisTitle,
    required this.data,
    this.colorMapping,
    this.maxLabelLength = 10, // Default truncation length
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 300,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(
              title: AxisTitle(text: horizontalAxisTitle),
              labelRotation: 45,
              majorGridLines: const MajorGridLines(width: 0),
              labelStyle: const TextStyle(fontSize: 12),
              axisLabelFormatter: (AxisLabelRenderDetails details) {
                String label = details.text;
                if (label.length > maxLabelLength) {
                  return ChartAxisLabel(
                    '${label.substring(0, maxLabelLength - 3)}...',
                    details.textStyle,
                  );
                }
                return ChartAxisLabel(label, details.textStyle);
              },
            ),
            primaryYAxis: NumericAxis(
              title: AxisTitle(text: verticalAxisTitle),
              majorGridLines: const MajorGridLines(width: 0.5),
            ),
            tooltipBehavior: TooltipBehavior(
              enable: true,
              header: '', // Remove header for cleaner tooltip
              format: 'point.x: point.y', // Show full category and value
            ),
            series: _buildSeries(),
            plotAreaBorderWidth: 0, // Cleaner look
          ),
        ),
        const SizedBox(height: 16),
        buildCustomLegend(context),
      ],
    );
  }

  List<CartesianSeries<MapEntry<String, num>, String>> _buildSeries() {
    final defaultColors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.cyan,
      Colors.yellow,
      Colors.lime,
    ];

    // Use provided colorMapping or generate default colors
    final effectiveColorMapping = colorMapping ??
        Map.fromEntries(
          data.keys.toList().asMap().entries.map(
                (entry) => MapEntry(
                  entry.value,
                  defaultColors[entry.key % defaultColors.length],
                ),
              ),
        );

    return [
      ColumnSeries<MapEntry<String, num>, String>(
        dataSource: data.entries.toList(),
        xValueMapper: (MapEntry<String, num> entry, _) => entry.key,
        yValueMapper: (MapEntry<String, num> entry, _) =>
            entry.value.toDouble(),
        pointColorMapper: (MapEntry<String, num> entry, _) =>
            effectiveColorMapping[entry.key] ?? Colors.grey,
        width:
            data.length > 10 ? 0.6 : 0.8, // Narrower bars for many categories
        spacing:
            data.length > 10 ? 0.1 : 0.2, // Tighter spacing for many categories
      ),
    ];
  }

  Widget buildCustomLegend(BuildContext context) {
    final effectiveColorMapping = colorMapping ??
        Map.fromEntries(
          data.keys.toList().asMap().entries.map(
                (entry) => MapEntry(
                  entry.value,
                  [
                    Colors.blue,
                    Colors.green,
                    Colors.orange,
                    Colors.red,
                    Colors.purple,
                    Colors.teal,
                    Colors.pink,
                    Colors.cyan,
                    Colors.yellow,
                    Colors.lime,
                  ][entry.key % 10],
                ),
              ),
        );

    return Wrap(
      spacing: 12.0,
      runSpacing: 8.0,
      children: effectiveColorMapping.entries.map((entry) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: entry.value,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 6),
            SizedBox(
              width: 150, // Limit width to prevent overflow
              child: Text(
                entry.key,
                style: const TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis, // Ellipsis for very long text
                maxLines: 2, // Allow wrapping to 2 lines if needed
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
