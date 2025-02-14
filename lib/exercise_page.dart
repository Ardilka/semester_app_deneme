import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  late List<dynamic> exercises; // Use 'late' since it's non-nullable
  int currentExerciseIndex = 0;
  final Map<int, dynamic> userAnswers = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadExercises();
  }

  Future<void> loadExercises() async {
    String jsonString = await rootBundle.loadString('assets/tutorial.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    setState(() {
      exercises = jsonData['exercises'] as List<dynamic>;
      isLoading = false;
    });
  }

  void nextExercise() {
    if (currentExerciseIndex < exercises.length - 1) {
      setState(() {
        currentExerciseIndex++;
      });
    } else {
      // All exercises completed
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Completed'),
          content: const Text('You have completed all exercises!'),
          actions: [
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    }
  }

  Widget buildExerciseWidget(Map<String, dynamic> exercise) {
    String type = exercise['type'];
    switch (type) {
      case 'multiple_choice':
        return buildMultipleChoice(exercise);
      case 'true_false':
        return buildTrueFalse(exercise);
      case 'fill_in_blank':
        return buildFillInBlank(exercise);
      default:
        return const Text('Unknown exercise type');
    }
  }

  Widget buildMultipleChoice(Map<String, dynamic> exercise) {
    List<dynamic> options = exercise['options'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(exercise['question'], style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        ...options.map((option) => RadioListTile(
              title: Text(option),
              value: option,
              groupValue: userAnswers[currentExerciseIndex],
              onChanged: (value) {
                setState(() {
                  userAnswers[currentExerciseIndex] = value;
                });
              },
            )),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: nextExercise,
          child: const Text('Next'),
        ),
      ],
    );
  }

  Widget buildTrueFalse(Map<String, dynamic> exercise) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(exercise['question'], style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        RadioListTile(
          title: const Text('True'),
          value: true,
          groupValue: userAnswers[currentExerciseIndex],
          onChanged: (value) {
            setState(() {
              userAnswers[currentExerciseIndex] = value;
            });
          },
        ),
        RadioListTile(
          title: const Text('False'),
          value: false,
          groupValue: userAnswers[currentExerciseIndex],
          onChanged: (value) {
            setState(() {
              userAnswers[currentExerciseIndex] = value;
            });
          },
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: nextExercise,
          child: const Text('Next'),
        ),
      ],
    );
  }

  Widget buildFillInBlank(Map<String, dynamic> exercise) {
    final TextEditingController controller = TextEditingController(
      text: userAnswers[currentExerciseIndex] ?? '',
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(exercise['question'], style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Your answer here',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            userAnswers[currentExerciseIndex] = value;
          },
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: nextExercise,
          child: const Text('Next'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Exercises')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    Map<String, dynamic> currentExercise =
        exercises[currentExerciseIndex] as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Exercise ${currentExerciseIndex + 1} of ${exercises.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: buildExerciseWidget(currentExercise),
      ),
    );
  }
}
