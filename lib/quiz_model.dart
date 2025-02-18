import 'package:flutter/material.dart';

/// Data class for a question.
class Question {
  /// The question text.
  ///
  /// Example: What is Dart?
  final String text;

  /// Options that can be chosen from to answer the question.
  ///
  /// Example: ["Programming language", "Airborne ranged weapon"]
  final List<String> options;

  /// Which of the options is the correct answer.
  final String correct;

  /// Which of the options the user picked as their answer.
  String? answered;

  Question(this.text,
      {required this.options, required this.correct, this.answered});
}

class QuizModel with ChangeNotifier {
  bool _done = false;
  bool get done => _done;
  int _index = 0;
  int get index => _index;

  final List<Question> questions;

  bool get allCorrect =>
      questions.every((question) => question.answered == question.correct);

  Question get currentQuestion => questions[index];
  int get number => index + 1;
  int get total => questions.length;
  bool get isLastQuestion => index < questions.length - 1;

  QuizModel(this.questions);

  void selectOption(String answer) {
    questions[index].answered = answer;
    notifyListeners();
  }

  void nextQuestion() {
    _index++;
    notifyListeners();
  }

  void markAsDone() {
    _done = true;
    notifyListeners();
  }

  void resetQuiz() {
    _index = 0;
    _done = false;
    notifyListeners();
  }
}
