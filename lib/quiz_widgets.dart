import 'package:flutter/material.dart';

import 'quiz_model.dart';

class QuizProgress extends StatelessWidget {
  final QuizModel model;

  const QuizProgress({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(value: model.number / model.total),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Question:'),
              Text('${model.number} of ${model.total}')
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class CurrentQuestionWidget extends StatelessWidget {
  final QuizModel model;
  const CurrentQuestionWidget({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    final question = model.currentQuestion;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child:
          Text(question.text, style: Theme.of(context).textTheme.headlineLarge),
    );
  }
}

class OptionListWidget extends StatelessWidget {
  final QuizModel model;
  const OptionListWidget({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    final question = model.currentQuestion;
    return Expanded(
      child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          for (final option in question.options)
            if (question.answered != option)
              OutlinedButton(
                  onPressed: () => model.selectOption(option),
                  child: Text(option))
            else
              FilledButton(
                  onPressed: () => model.selectOption(option),
                  child: Text(option))
        ]),
      ),
    );
  }
}

class CompletedBottomSheet extends StatelessWidget {
  final QuizModel model;
  const CompletedBottomSheet({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      color: model.allCorrect ? Colors.green : Colors.red,
      width: double.infinity,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
                model.allCorrect
                    ? "Hurray 🥳, you are a true expert!"
                    : "😥 you can do better!",
                style: textTheme.headlineSmall),
          ])),
    );
  }
}
