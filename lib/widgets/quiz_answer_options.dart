
import 'package:flutter/material.dart';

import '../data/quiz_model.dart';

class QuizAnswerOptions extends StatelessWidget {
  const QuizAnswerOptions(this.question, {required this.onSelected, super.key});

  final Question question;
  final void Function(String option) onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      for (final option in question.options)
        if (question.answered != option)
          OutlinedButton(
              onPressed: () => onSelected(option), child: Text(option))
        else
          FilledButton(onPressed: () => onSelected(option), child: Text(option))
    ]);
  }
}

