import 'package:flutter/material.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';

class ProductStockItem extends StatelessWidget {
  final String title;
  final String lote;
  final int quantidade;

  const ProductStockItem({
    required this.title,
    required this.lote,
    required this.quantidade,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ListTile(
          title: Text(
            title,
            style: LetterTheme.textSemibold.copyWith(
              color: ColorTheme.secondaryTwo,
            ),
          ),
        ),
        ListTile(
          title: Text(
            lote,
            style: LetterTheme.textSemibold.copyWith(
              color: ColorTheme.secondaryTwo,
            ),
          ),
        ),
        ListTile(
          title: Text(
            quantidade.toString(),
            style: LetterTheme.textSemibold.copyWith(
              color: ColorTheme.secondaryTwo,
            ),
          ),
        ),
      ],
    );
  }
}
