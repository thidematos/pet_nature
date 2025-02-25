import 'package:flutter/material.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';

class Dropdown extends StatelessWidget {
  const Dropdown(
    this.label, {
    required this.items,
    required this.defaultValue,
    required this.onChange,
    super.key,
  });
  final String label;
  final Map<String, String> items;
  final String defaultValue;
  final void Function(String value) onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: LetterTheme.secondaryTitle,
          textAlign: TextAlign.start,
        ),
        DropdownButtonFormField(
          icon: Icon(Icons.keyboard_arrow_down),
          dropdownColor: ColorTheme.light,
          style: LetterTheme.textSemibold.copyWith(fontSize: 16),
          value: defaultValue,
          items: [
            for (final category in items.entries)
              DropdownMenuItem(
                value: category.key,
                child: Text(
                  category.value,
                  style: LetterTheme.textSemibold.copyWith(fontSize: 16),
                ),
              ),
          ],
          onChanged: (value) => onChange(value!),
        ),
      ],
    );
  }
}
