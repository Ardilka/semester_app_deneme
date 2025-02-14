import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:semester_app_deneme/tutorials/tutorial_renderer.dart';

class TeachingPage extends StatefulWidget {
  const TeachingPage({super.key});

  @override
  State<TeachingPage> createState() => _TeachingPageState();
}

class _TeachingPageState extends State<TeachingPage> {
  bool isLoading = true;
  String lessonTitle = 'Untitled';
  List<Map<String, dynamic>> lessonChunks = [];

  @override
  void initState() {
    super.initState();
    loadLesson();
  }

  Future<void> loadLesson() async {
    // If your JSON is on the web, you can use http.get(...) instead of rootBundle.loadString(...)
    final String jsonString =
        await rootBundle.loadString('assets/tutorial.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    setState(() {
      lessonTitle = jsonData['lessonTitle'] ?? 'Untitled';
      lessonChunks = (jsonData['lessonChunks'] as List)
          .map((chunk) => chunk as Map<String, dynamic>)
          .toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Loading')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return TutorialRenderer(
      lessonTitle: lessonTitle,
      lessonChunks: lessonChunks,
    );
  }
}
