import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hangman/utilities/app_utilities.dart';
import 'package:hangman/utilities/hidden_latters.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var characters = "abcdefghijklmnopqrstuvwxyz".toUpperCase();

  String word = AppWords.wordList[Random().nextInt(5)].toUpperCase();
  List<String> selectedChar = [];
  List<String> correctChar = [];

  int tries = 0;

  Future<void> _showMyDialog(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Start Again'),
              onPressed: () {
                setState(() {
                  tries = 0;
                  selectedChar.clear();
                  word = AppWords.wordList[Random().nextInt(5)].toUpperCase();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Set<String> actualWord = word.split("").toSet();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hangman: The Game'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  flex: 6,
                  child: Image.asset("images/$tries.png"),
                ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: word
                            .split("")
                            .map((e) => HiddenLetter(
                                e, !selectedChar.contains(e.toUpperCase())))
                            .toList(),
                      )),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 7,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: characters
                    .split("")
                    .map(
                      (e) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black54,
                        ),
                        onPressed: selectedChar.contains(e.toUpperCase())
                            ? null
                            : () {
                                setState(() {
                                  selectedChar.add(e.toUpperCase());
                                  if (!word
                                      .split("")
                                      .contains(e.toUpperCase())) {
                                    tries++;
                                  } else {
                                    correctChar.add(e.toUpperCase());
                                  }
                                });

                                print(actualWord.length);
                                print(actualWord);
                                print(correctChar.length);
                                print(correctChar);

                                if (actualWord.length == correctChar.length) {
                                  _showMyDialog("Congratulation",
                                      "Congratulation You Have Done It!");
                                } else if (tries >= 6) {
                                  _showMyDialog(
                                      "Gave Over", "Sorry to see you hanging!");
                                }
                              },
                        child: Text(
                          e,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
