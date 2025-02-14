import 'package:flutter/material.dart';
import 'package:semester_app_deneme/tutors/tutorial_editor.dart';
import 'teaching_page.dart';
import 'exercise_page.dart';
import 'tutorial_path_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    TutorialPathPage(),
    TutorEditorPage(),
    TeachingPage(),
    ExercisePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Tutorial Path',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Teaching',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Exercises',
          ),
        ],
      ),
    );
  }
}
