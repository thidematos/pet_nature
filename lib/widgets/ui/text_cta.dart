import 'package:flutter/material.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';

class TextCta extends StatelessWidget {
  const TextCta(this.text, this.ctaText, this.ctaHandler, {super.key});

  final String text;
  final String ctaText;
  final void Function() ctaHandler;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text, style: LetterTheme.textSemibold),
        TextButton(
          onPressed: ctaHandler,
          child: Text(
            ctaText,
            style: LetterTheme.textSemibold.copyWith(
              color: ColorTheme.secondaryTwo,
            ),
          ),
        ),
      ],
    );
  }
}
