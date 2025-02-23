import 'package:flutter/material.dart';
import 'package:pet_nature/screens/signup_screen.dart';
import 'package:pet_nature/widgets/ui/text_cta.dart';
import 'package:pet_nature/widgets/ui/button.dart';
import 'package:pet_nature/widgets/ui/input.dart';
import 'package:pet_nature/widgets/ui/input_password.dart';
import 'package:pet_nature/widgets/ui/page_title.dart';

class LoginContainer extends StatefulWidget {
  const LoginContainer({super.key});

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  bool useObscure = true;
  final TextEditingController passwordController = TextEditingController(
    text: '',
  );

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  void toggleVisibility() {
    setState(() {
      useObscure = !useObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PageTitle(
          'Login',
          subtitle: 'Faça login para continuar utilizando este aplicativo',
        ),
        Form(
          child: Column(
            spacing: 16,
            children: [
              Input(placeholder: 'toninho@asimov.com', label: 'Email'),
              InputPassword(controller: passwordController),
              SizedBox(height: 24),
              Button('Entrar', () {}),
              TextCta('Não possui conta?', 'Cadastrar', () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => SignupScreen()));
              }),
            ],
          ),
        ),
      ],
    );
  }
}
