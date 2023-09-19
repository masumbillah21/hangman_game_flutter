import 'package:flutter/material.dart';
import 'package:hangman/game_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hangman: The Game',
      theme: ThemeData.dark(),
      home: const GameScreen(),
    );
  }
}
