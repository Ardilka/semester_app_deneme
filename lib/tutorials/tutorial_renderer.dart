import 'package:flutter/material.dart';
import 'package:semester_app_deneme/charts/bar_chart.dart';
import 'package:semester_app_deneme/charts/line_chart.dart';
import 'package:semester_app_deneme/charts/pie_chart.dart';

class TutorialRenderer extends StatelessWidget {
  final String lessonTitle;
  final List<Map<String, dynamic>> lessonChunks;

  const TutorialRenderer({
    super.key,
    required this.lessonTitle,
    required this.lessonChunks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lessonTitle),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: lessonChunks
                    .map((chunk) => _buildChunk(context, chunk))
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChunk(BuildContext context, Map<String, dynamic> chunk) {
    switch (chunk['type']) {
      case 'header':
        return _buildHeader(chunk['content'] ?? '');
      case 'text':
        return _buildText(chunk['content'] ?? '');
      case 'image':
        return _buildImage(context, chunk['url'] ?? '');
      case 'bullet_list':
        return _buildBulletList(chunk['items'] ?? []);
      case 'chart':
        return _buildChart(
            chunk['chartType'], chunk['data'], chunk['description'] ?? '');
      case 'side_by_side':
        return _buildSideBySide(
          context,
          chunk['leftChunk'] as Map<String, dynamic>?,
          chunk['rightChunk'] as Map<String, dynamic>?,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildHeader(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        content,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildText(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        content,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildImage(BuildContext context, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          // Fullscreen image on tap, or remove if not desired
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                body: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: InteractiveViewer(
                    child: Center(
                      child: Image.network(
                        url,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: Center(
                              child: Text(
                                'Error loading image\n$url',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            url,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200],
                height: 200,
                child: Center(
                  child: Text(
                    'Error loading image\n$url',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBulletList(List<dynamic> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('• ', style: TextStyle(fontSize: 16)),
              Expanded(
                child:
                    Text(item.toString(), style: const TextStyle(fontSize: 16)),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChart(
      String chartType, Map<String, dynamic> data, String description) {
    switch (chartType) {
      case 'line':
        return buildLineChart(data, description); // from line_chart.dart
      case 'bar':
        return buildBarChart(data, description); // from bar_chart.dart
      case 'pie':
        return buildPieChart(data, description); // from pie_chart.dart
      default:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text("Unknown chart type: $chartType"),
        );
    }
  }

  Widget _buildSideBySide(
    BuildContext context,
    Map<String, dynamic>? leftChunk,
    Map<String, dynamic>? rightChunk,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left chunk
        Expanded(
          child: leftChunk != null
              ? _buildChunk(context, leftChunk)
              : const SizedBox.shrink(),
        ),
        const SizedBox(width: 8),
        // Right chunk
        Expanded(
          child: rightChunk != null
              ? _buildChunk(context, rightChunk)
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
