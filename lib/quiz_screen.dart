import 'package:flutter/material.dart';

import 'quiz_model.dart';

class QuizScreen extends StatefulWidget {
  final List<Question> quiz;
  const QuizScreen({required this.quiz, super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    model = QuizModel(widget.quiz);
  }

  late QuizModel model;

  void _onDonePressed(BuildContext context) {
    model.markAsDone();

    final controller = showModalBottomSheet(
        context: context, builder: (context) => _buildBottomSheet(context));

    controller.whenComplete(() {
      model.resetQuiz();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Quiz")),
      body: Column(
        children: [
          ..._buildProgress(model.number, model.total),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: _buildQuestion(context, model.currentQuestion),
          ),
          Expanded(
            child: Center(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _buildOptions(model.currentQuestion)),
            ),
          )
        ],
      ),
      floatingActionButton: _buildActionButton(model.currentQuestion),
    );
  }

  List<Widget> _buildProgress(int number, int total) {
    return [
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
    ];
  }

  List<Widget> _buildOptions(Question question) {
    return [
      for (final option in question.options)
        if (question.answered != option)
          OutlinedButton(
              onPressed: () => model.selectOption(option), child: Text(option))
        else
          FilledButton(
              onPressed: () => model.selectOption(option), child: Text(option))
    ];
  }

  Text _buildQuestion(BuildContext context, Question question) {
    return Text(question.text,
        style: Theme.of(context).textTheme.headlineLarge);
  }

  Widget? _buildActionButton(Question currentQuestion) {
    if (model.done || currentQuestion.answered == null) return null;
    if (model.isLastQuestion) {
      return TextButton(
          onPressed: model.nextQuestion, child: const Text("Next"));
    } else {
      return Builder(
        builder: (context) => TextButton(
            onPressed: () => _onDonePressed(context),
            child: const Text("Done")),
      );
    }
  }

  Widget _buildBottomSheet(BuildContext context) {
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
