import 'package:flutter/material.dart';
import 'package:hangman/utilities/app_utilities.dart';

Widget HiddenLetter(String char, bool visible) {
  return Container(
    alignment: Alignment.center,
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
    ),
    child: Visibility(
      visible: !visible,
      child: Text(
        char,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColors.bgColors),
      ),
    ),
  );
}
