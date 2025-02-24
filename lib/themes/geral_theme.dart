import 'package:flutter/material.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';

final ThemeData theme = ThemeData().copyWith(
  scaffoldBackgroundColor: ColorTheme.light,
  inputDecorationTheme: InputDecorationTheme().copyWith(
    hintStyle: LetterTheme.placeholder,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: ColorTheme.secondary),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: ColorTheme.dark, width: 1),
    ),
  ),
);
