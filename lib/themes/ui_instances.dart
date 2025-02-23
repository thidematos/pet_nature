import 'package:flutter/material.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';

class UiInstances {
  const UiInstances();

  static BoxShadow shadow = BoxShadow(
    color: Colors.grey.withAlpha(15),
    blurRadius: 5,
    spreadRadius: 5,
    offset: Offset(2, 4),
  );

  static EdgeInsets screenPadding = const EdgeInsets.symmetric(
    vertical: 50,
    horizontal: 20,
  );

  static showSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 10,
        content: Center(child: Text(text, style: LetterTheme.button)),
        backgroundColor: ColorTheme.danger,
        padding: const EdgeInsets.symmetric(vertical: 24),
      ),
    );
  }

  static Widget logoToMainContentSpacer = const SizedBox(height: 116);
}
