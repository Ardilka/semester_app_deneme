import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget buildLineChart(Map<String, dynamic> data, String description) {
  List<FlSpot> spots = [];
  List<dynamic> labels = data['labels'];
  List<dynamic> values = data['values'];
  String unit =
      data['unit'] ?? ''; // Supports units like "Books Printed", "%", etc.

  double minY = (values.reduce((a, b) => a < b ? a : b) as num).toDouble();
  double maxY = (values.reduce((a, b) => a > b ? a : b) as num).toDouble();

  // ✅ Ensure the bottom value never goes below 0
  double margin = (maxY - minY) * 0.1;
  double adjustedMinY = minY > margin ? minY - margin : 0;
  double adjustedMaxY = maxY + margin; // ✅ Adds a top margin

  for (int i = 0; i < labels.length; i++) {
    spots.add(FlSpot(i.toDouble(), (values[i] as num).toDouble()));
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
    child: Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // ✅ Aligns "Books Printed" to the left
      children: [
        if (unit.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(
                bottom: 4.0, left: 10.0), // ✅ Moves unit to the left
            child: Text(
              unit,
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        SizedBox(
          height: 220,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval:
                      (maxY - adjustedMinY) / 3, // Keeps Y-axis labels limited
                  verticalInterval: 1,
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 20,
                      interval: (labels.length / 4).ceilToDouble(),
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        if (index >= 0 && index < labels.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(labels[index],
                                style: const TextStyle(fontSize: 12)),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        // ✅ Do NOT show the top value on the Y-axis
                        if (value == adjustedMaxY) {
                          return const SizedBox.shrink();
                        }
                        return Text(value.toInt().toString(),
                            style: const TextStyle(fontSize: 10));
                      },
                    ),
                  ),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.black12),
                ),
                minX: 0,
                maxX: labels.length.toDouble() - 1,
                minY: adjustedMinY, // ✅ Ensures we never go below 0
                maxY: adjustedMaxY, // ✅ Adds a top margin but doesn't label it
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 3,
                    belowBarData: BarAreaData(show: false),
                    dotData: FlDotData(show: true),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
