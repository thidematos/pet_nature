import 'package:flutter/material.dart';
import 'package:pet_nature/screens/login_screen.dart';
import 'package:pet_nature/screens/signup_screen.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/ui/button.dart';
import 'package:pet_nature/widgets/ui/logo.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 116, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Image.asset('assets/logo-with-icon.png'),
            ),
            Column(
              spacing: 22,
              children: [
                Button('Fazer login', () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }),
                Button('Cadastrar', () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                }, isLight: true),
              ],
            ),
            Image.asset('assets/ilustracao_estoque.png'),
          ],
        ),
      ),
    );
  }
}
