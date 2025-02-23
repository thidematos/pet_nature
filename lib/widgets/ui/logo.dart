import 'package:flutter/material.dart';
import 'package:pet_nature/themes/letter_theme.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(child: Text('PetNature', style: LetterTheme.logo)),
        Positioned(
          bottom: -6,
          right: 0,
          child: Text(
            'Controle de estoque',
            style: LetterTheme.logoSubtitle,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
