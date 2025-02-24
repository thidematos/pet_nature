import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_nature/themes/color_theme.dart';

class LetterTheme {
  const LetterTheme();

  static TextStyle mainTitle = GoogleFonts.sourceSans3(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: ColorTheme.darker,
  );

  static TextStyle logo = GoogleFonts.baloo2(
    fontSize: 36,
    color: ColorTheme.secondaryTwo,
    fontWeight: FontWeight.w900,
  );

  static TextStyle logoSubtitle = GoogleFonts.sourceSans3(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: ColorTheme.secondaryTwo,
  );

  static TextStyle secondaryTitle = GoogleFonts.sourceSans3(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: ColorTheme.darker,
  );

  static TextStyle button = GoogleFonts.sourceSans3(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: ColorTheme.light,
  );

  static TextStyle placeholder = GoogleFonts.sourceSans3(
    fontSize: 16,
    fontStyle: FontStyle.italic,
    color: Colors.grey.withAlpha(230),
  );

  static TextStyle textSemibold = GoogleFonts.sourceSans3(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: ColorTheme.darker,
  );

  static TextStyle text = GoogleFonts.sourceSans3(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}
