import 'package:flutter/material.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/widgets/ui/loader.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.primary,
      body: Padding(
        padding: const EdgeInsets.only(top: 116, right: 24, left: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/logo-with-icon.png'),
            SizedBox(
              width: 75,
              height: 75,
              child: CircularProgressIndicator(color: ColorTheme.secondaryTwo),
            ),
            Image.asset('assets/ilustracao_estoque.png'),
          ],
        ),
      ),
    );
  }
}
