import 'package:flutter/material.dart';

import '../data/quiz_model.dart';

class QuizProgress extends StatelessWidget {
  const QuizProgress({required this.number, required this.total, super.key});

  final int number;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      LinearProgressIndicator(value: number / total),
      const SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const Text('Question:'), Text('$number of $total')],
        ),
      ),
      const Divider(),
    ]);
  }
}

class QuestionText extends StatelessWidget {
  const QuestionText(this.question, {super.key});

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Text(question.text,
        style: Theme.of(context).textTheme.headlineLarge);
  }
}
