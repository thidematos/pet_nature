import 'package:flutter/material.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';
import 'package:pet_nature/themes/ui_instances.dart';

class Input extends StatelessWidget {
  const Input({
    required this.placeholder,
    required this.label,
    this.useObscure = false,
    super.key,
  });

  final String placeholder;
  final String label;
  final bool useObscure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        Text(
          label,
          style: LetterTheme.secondaryTitle,
          textAlign: TextAlign.start,
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorTheme.light,
            boxShadow: [UiInstances.shadow],
          ),
          child: TextFormField(
            obscureText: useObscure,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: LetterTheme.placeholder,
            ),
          ),
        ),
      ],
    );
  }
}
