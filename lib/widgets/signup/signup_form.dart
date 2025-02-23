import 'package:flutter/material.dart';
import 'package:pet_nature/screens/login_screen.dart';
import 'package:pet_nature/widgets/ui/button.dart';
import 'package:pet_nature/widgets/ui/input.dart';
import 'package:pet_nature/widgets/ui/input_password.dart';
import 'package:pet_nature/widgets/ui/page_title.dart';
import 'package:pet_nature/widgets/ui/text_cta.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        PageTitle(
          'Criar conta',
          subtitle: 'Insira suas informações pessoais abaixo',
        ),
        Input(placeholder: 'Toninho Asimov', label: 'Nome completo'),
        Input(placeholder: 'toninho@asimov.com', label: 'Email'),
        InputPassword(),
        InputPassword(label: 'Confirmar senha'),
        const SizedBox(height: 40),
        Button('Criar conta', () {}),
        TextCta('Já possui uma conta?', 'Entrar', () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }),
      ],
    );
  }
}
