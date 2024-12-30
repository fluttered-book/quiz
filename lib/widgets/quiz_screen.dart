import 'package:flutter/material.dart';
import 'package:quiz/widgets/quiz_answer_options.dart';
import 'package:quiz/widgets/quiz_progress.dart';

import '../data/quiz_model.dart';
import 'quiz_bottom_sheet.dart';

class QuizScreen extends StatefulWidget {
  final Quiz quiz;

  const QuizScreen({required this.quiz, super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool done = false;
  int index = 0;

  Quiz get questions => widget.quiz;

  _onOptionPressed(String answer) {
    setState(() {
      questions[index].answered = answer;
    });
  }

  _onNextPressed() {
    if (index < questions.length - 1) {
      setState(() {
        index++;
      });
    }
  }

  _onDonePressed(BuildContext context) {
    setState(() {
      done = true;
    });
    final allCorrect =
    questions.every((element) => element.answered == element.correct);

    final controller = showModalBottomSheet(
      context: context,
      builder: (context) => QuizBottomSheet(allCorrect: allCorrect),
    );

    controller.whenComplete(() {
      setState(() {
        index = 0;
        done = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[index];
    final number = index + 1;
    final total = questions.length;
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Quiz")),
      body: Column(
        children: [
          QuizProgress(number: number, total: total),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: QuestionText(currentQuestion),
          ),
          Expanded(
            child: Center(
                child: QuizAnswerOptions(currentQuestion,
                    onSelected: _onOptionPressed)),
          )
        ],
      ),
      floatingActionButton: _buildActionButton(currentQuestion),
    );
  }

  Widget? _buildActionButton(Question currentQuestion) {
    if (done || currentQuestion.answered == null) return null;
    if (index < questions.length - 1) {
      return TextButton(onPressed: _onNextPressed, child: const Text("Next"));
    } else {
      return Builder(
        builder: (context) => TextButton(
            onPressed: () => _onDonePressed(context),
            child: const Text("Done")),
      );
    }
  }
}
