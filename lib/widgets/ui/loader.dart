import 'package:flutter/material.dart';
import 'package:pet_nature/themes/color_theme.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(color: ColorTheme.light, strokeWidth: 2),
    );
  }
}
