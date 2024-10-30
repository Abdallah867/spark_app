import 'package:flutter/material.dart';
import 'package:spark_app/custom_text_form_field.dart';
import 'package:spark_app/quiz_screen.dart';

class NameScreen extends StatelessWidget {
  const NameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Spark Quizz App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 50),
              Image.asset('assets/SPARK-01.png', height: 170),
              const SizedBox(height: 50),
              CustomTextFormField(
                controller: nameController,
                name: 'Name',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(double.infinity, 60),
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  String name = nameController.text;
                  if (name.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(name: name),
                      ),
                    );
                  }
                },
                child: const Text('Start Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
