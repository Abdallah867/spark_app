import 'dart:convert'; // For jsonEncode and jsonDecode
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spark_app/quizz_model.dart';

class QuizScreen extends StatefulWidget {
  final String name;

  const QuizScreen({super.key, required this.name});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  List<QuizzModel> quizz = QuizzModel.get();
  int score = 0;

  // Function to retrieve leaderboard from SharedPreferences
  Future<List<Map<String, dynamic>>> _getLeaderboard() async {
    final prefs = await SharedPreferences.getInstance();
    String? leaderboardJson = prefs.getString('leaderboard');
    if (leaderboardJson != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(leaderboardJson));
    }
    return [];
  }

  // Function to save the updated leaderboard
  Future<void> _saveLeaderboard(String name, int score) async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> leaderboard = await _getLeaderboard();

    // Add the new score and name to the leaderboard
    leaderboard.add({'name': name, 'score': score});

    // Store the updated leaderboard in SharedPreferences
    prefs.setString('leaderboard', jsonEncode(leaderboard));

    // await prefs.clear();
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < quizz.length - 1) {
        _currentQuestionIndex++;
      } else {
        // Save the user's name and score in leaderboard
        _saveLeaderboard(widget.name, score);

        // If the quiz is over, show a message or handle accordingly
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: const Text("Quiz Complete",
                style: TextStyle(color: Colors.black)),
            content: Text(
              "Good job, ${widget.name}! \n Your Score: $score",
              style: const TextStyle(color: Colors.black),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context); // Pop to the first screen
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz for ${widget.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(width: double.infinity),
            Text(
              quizz[_currentQuestionIndex].question,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            ...quizz[_currentQuestionIndex].options.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (quizz[_currentQuestionIndex].answer == option) {
                      score += quizz[_currentQuestionIndex].score;
                    }
                    _nextQuestion();
                  },
                  child: Text(
                    option,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
