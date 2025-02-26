import 'package:flutter/material.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';

class DetailRow extends StatelessWidget {
  const DetailRow(this.label, this.content, {super.key});

  final String label;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: Text(
            label,
            softWrap: true,
            style: LetterTheme.textSemibold.copyWith(
              color: ColorTheme.secondaryTwo,
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
              child: Text(content, style: LetterTheme.textSemibold)),
        ),
      ],
    );
  }
}
