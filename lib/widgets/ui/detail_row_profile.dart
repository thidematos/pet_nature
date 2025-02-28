import 'package:flutter/material.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';

class DetailRowProfile extends StatelessWidget {
  const DetailRowProfile(this.label, this.content, {super.key});

  final String label;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          softWrap: true,
          style: LetterTheme.textSemibold.copyWith(
            color: ColorTheme.secondaryTwo,
          ),
        ),
        SizedBox(width: 7),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            content,
            style: LetterTheme.textSemibold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}