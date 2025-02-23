import 'package:flutter/material.dart';
import 'package:pet_nature/themes/letter_theme.dart';

class PageTitle extends StatelessWidget {
  const PageTitle(this.title, {this.subtitle, super.key});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: LetterTheme.mainTitle),
        if (subtitle != null) SizedBox(height: 8),
        if (subtitle != null) Text(subtitle!, style: LetterTheme.text),
        const SizedBox(height: 24),
      ],
    );
  }
}
