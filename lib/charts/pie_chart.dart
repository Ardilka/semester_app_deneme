import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget buildPieChart(Map<String, dynamic> data, String description) {
  List<dynamic> labels = data['labels'];
  List<dynamic> values = data['values'];

  List<PieChartSectionData> sections = List.generate(labels.length, (index) {
    return PieChartSectionData(
      value: (values[index] as num).toDouble(),
      title: labels[index].toString(),
      color: Colors.primaries[index % Colors.primaries.length],
      radius: 30, // Reduced size
      titleStyle: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
    );
  });

  return Column(
    children: [
      if (description.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(description,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      SizedBox(
        height: 150,
        child: PieChart(
          PieChartData(
            sectionsSpace: 2,
            centerSpaceRadius: 30,
            sections: sections,
          ),
        ),
      ),
    ],
  );
}
