import 'package:flutter/material.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';

class NoProdutos extends StatelessWidget {
  const NoProdutos({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        'Não há produtos com esse nome!',
        style: LetterTheme.secondaryTitle.copyWith(color: ColorTheme.danger),
      ),
    );
  }
}
