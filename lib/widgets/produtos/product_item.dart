import 'package:flutter/material.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: LetterTheme.textSemibold.copyWith(
          color: ColorTheme.secondaryTwo,
        ),
      ),
    );
  }
}
