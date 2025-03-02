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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: LetterTheme.textSemibold.copyWith(
            color: ColorTheme.secondaryTwo,
          ),
        ),
        Expanded(
          child: Text(
            content,
            style: LetterTheme.textSemibold,
            softWrap: true,
            maxLines: 3,
          ),
        ),
      ],
    );
  }
}
