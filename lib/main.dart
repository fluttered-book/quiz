import 'package:flutter/material.dart';

import 'data/quiz_data.dart';
import 'widgets/quiz_screen.dart';

void main() {
  runApp(const MyApp());
}

const themeColor = Colors.lightGreen;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: themeColor,
      theme:
          ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: themeColor)),
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: themeColor, brightness: Brightness.dark)),
      home: QuizScreen(quiz: quiz),
    );
  }
}
