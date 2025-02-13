import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:semester_app_deneme/tutorials/tutorial_renderer.dart';

class TutorialPathPage extends StatefulWidget {
  @override
  _TutorialPathPageState createState() => _TutorialPathPageState();
}

class _TutorialPathPageState extends State<TutorialPathPage> {
  final List<String> tutorialFiles = [
    'assets/lessons/tutorial1.json',
    'assets/lessons/tutorial2.json',
    'assets/lessons/tutorial3.json',
    'assets/lessons/tutorial4.json',
    'assets/lessons/tutorial5.json',
  ];

  List<String> tutorialTitles = [];

  @override
  void initState() {
    super.initState();
    _loadTutorialTitles();
  }

  Future<void> _loadTutorialTitles() async {
    List<String> titles = [];

    for (String filePath in tutorialFiles) {
      try {
        String jsonString = await rootBundle.loadString(filePath);
        Map<String, dynamic> jsonData = json.decode(jsonString);
        titles.add(jsonData['lessonTitle'] ?? 'Untitled Lesson');
      } catch (e) {
        titles.add('Error loading title');
      }
    }

    setState(() {
      tutorialTitles = titles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Renaissance Course Pathway')),
      body: tutorialTitles.isEmpty
          ? const Center(
              child: CircularProgressIndicator()) // Show loading indicator
          : ListView.builder(
              itemCount: tutorialFiles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tutorialTitles[index]), // ✅ Shows tutorial title
                  subtitle: const Text('Tap to start'),
                  onTap: () async {
                    String jsonString =
                        await rootBundle.loadString(tutorialFiles[index]);
                    final Map<String, dynamic> jsonData =
                        json.decode(jsonString);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TutorialRenderer(
                          lessonTitle: jsonData['lessonTitle'] ?? 'Untitled',
                          lessonChunks: (jsonData['lessonChunks'] as List)
                              .map((chunk) => chunk as Map<String, dynamic>)
                              .toList(),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
