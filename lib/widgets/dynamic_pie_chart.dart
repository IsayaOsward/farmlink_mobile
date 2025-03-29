import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DynamicPieChart extends StatelessWidget {
  final String title; // Chart title (optional)
  final Map<String, num> data; // Single key-value pair: category -> value
  final Map<String, Color>? colorMapping; // Optional custom color mapping
  final String? explodeCategory; // Category to explode (separate), optional

  const DynamicPieChart({
    super.key,
    this.title = 'Pie', // Default to "Pie" as per your image
    required this.data,
    this.colorMapping,
    this.explodeCategory,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate total for percentage calculation
    final total = data.values.reduce((a, b) => a + b);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        SizedBox(
          height: 300, // Adjust height as needed
          child: SfCircularChart(
            tooltipBehavior: TooltipBehavior(
              enable: true,
              header: '',
              format: 'point.x: point.y', // Show category and value
            ),
            series: _buildSeries(total),
          ),
        ),
        const SizedBox(height: 16),
        buildCustomLegend(context),
      ],
    );
  }

  List<CircularSeries<MapEntry<String, num>, String>> _buildSeries(num total) {
    final defaultColors = [
      Colors.brown.shade300, // Beige for "Others"
      Colors.pink,
      Colors.purple,
      Colors.blue,
      Colors.teal,
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
      PieSeries<MapEntry<String, num>, String>(
        dataSource: data.entries.toList(),
        xValueMapper: (MapEntry<String, num> entry, _) => entry.key,
        yValueMapper: (MapEntry<String, num> entry, _) =>
            entry.value.toDouble(),
        pointColorMapper: (MapEntry<String, num> entry, _) =>
            effectiveColorMapping[entry.key] ?? Colors.grey,
        radius: '80%', // Slightly smaller for better spacing
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          labelPosition: ChartDataLabelPosition.inside,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          // Use builder as a fallback for custom labels
          builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
              int seriesIndex) {
            final entry = data as MapEntry<String, num>;
            final percentage = (entry.value / total * 100).toStringAsFixed(0);
            return Text(
              '$percentage%',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        explode: true, // Slight explosion for all
        explodeOffset: '10%', // Distance for exploded segment
        explodeIndex: explodeCategory != null
            ? data.keys.toList().indexOf(explodeCategory!)
            : -1, // Explode specific category
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
                    Colors.brown.shade300,
                    Colors.pink,
                    Colors.purple,
                    Colors.blue,
                    Colors.teal,
                    Colors.cyan,
                    Colors.yellow,
                    Colors.lime,
                  ][entry.key % 8],
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
              width: 150,
              child: Text(
                entry.key,
                style: const TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
