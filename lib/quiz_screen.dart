import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/quiz_widgets.dart';

import 'quiz_model.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<QuizModel>();
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Quiz")),
      body: Column(
        children: [
          QuizProgress(),
          CurrentQuestionWidget(),
          OptionListWidget(),
        ],
      ),
      floatingActionButton: _buildActionButton(model),
    );
  }

  Widget? _buildActionButton(QuizModel model) {
    if (model.done || model.currentQuestion.answered == null) return null;
    if (!model.isLastQuestion) {
      return TextButton(
          onPressed: model.nextQuestion, child: const Text("Next"));
    } else {
      return TextButton(
        onPressed: () => _onDonePressed(context, model),
        child: const Text("Done"),
      );
    }
  }

  void _onDonePressed(BuildContext context, QuizModel model) {
    model.markAsDone();

    final controller = showModalBottomSheet(
      context: context,
      builder: (context) => CompletedBottomSheet(),
    );

    controller.whenComplete(() {
      model.resetQuiz();
    });
  }
}
