import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget buildBarChart(Map<String, dynamic> data, String description) {
  List<dynamic> labels = data['labels'];
  List<dynamic> values = data['values'];

  return Column(
    children: [
      if (description.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(description,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      SizedBox(
        height: 180,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceEvenly,
            gridData: FlGridData(
                show: true, drawHorizontalLine: true, drawVerticalLine: false),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    int index = value.toInt();
                    return index >= 0 && index < labels.length
                        ? Text(labels[index],
                            style: const TextStyle(fontSize: 12))
                        : const SizedBox.shrink();
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30, // Ensure proper spacing
                  getTitlesWidget: (value, meta) {
                    return Text(value.toInt().toString(),
                        style: const TextStyle(fontSize: 10));
                  },
                ),
              ),
              rightTitles: AxisTitles(
                  sideTitles:
                      SideTitles(showTitles: false)), // Removed right axis
              topTitles: AxisTitles(
                  sideTitles:
                      SideTitles(showTitles: false)), // Removed top axis
            ),
            borderData: FlBorderData(
                show: true, border: Border.all(color: Colors.black12)),
            barGroups: List.generate(labels.length, (index) {
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: (values[index] as num).toDouble(),
                    color: Colors.blue,
                    width: 12,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    ],
  );
}
