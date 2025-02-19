import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/quiz_model.dart';

import 'quiz_data.dart';
import 'quiz_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => QuizModel(quiz),
    child: MyApp(),
  ));
}

const themeColor = Colors.lightGreen;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: themeColor,
      theme:
          ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: themeColor)),
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: themeColor, brightness: Brightness.dark)),
      home: QuizScreen(),
    );
  }
}
