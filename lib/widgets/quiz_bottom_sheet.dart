import 'package:flutter/material.dart';

class QuizBottomSheet extends StatelessWidget {
  const QuizBottomSheet({required this.allCorrect, super.key});

  final bool allCorrect;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      color: allCorrect ? Colors.green : Colors.red,
      width: double.infinity,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
                allCorrect
                    ? "Hurray 🥳, you are a true expert!"
                    : "😥 you can do better!",
                style: textTheme.headlineSmall),
          ])),
    );
  }
}
