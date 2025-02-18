import 'package:flutter/material.dart';
import 'package:quiz/quiz_widgets.dart';

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

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: model,
      builder: (context, _) => Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("Quiz")),
        body: Column(
          children: [
            QuizProgress(model: model),
            CurrentQuestionWidget(model: model),
            OptionListWidget(model: model),
          ],
        ),
        floatingActionButton: _buildActionButton(),
      ),
    );
  }

  Widget? _buildActionButton() {
    if (model.done || model.currentQuestion.answered == null) return null;
    if (model.isLastQuestion) {
      return TextButton(
          onPressed: model.nextQuestion, child: const Text("Next"));
    } else {
      return TextButton(
        onPressed: () => _onDonePressed(context),
        child: const Text("Done"),
      );
    }
  }

  void _onDonePressed(BuildContext context) {
    model.markAsDone();

    final controller = showModalBottomSheet(
      context: context,
      builder: (context) => CompletedBottomSheet(model: model),
    );

    controller.whenComplete(() {
      model.resetQuiz();
    });
  }
}
