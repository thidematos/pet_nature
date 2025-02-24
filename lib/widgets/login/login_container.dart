import 'package:flutter/material.dart';
import 'package:pet_nature/screens/signup_screen.dart';
import 'package:pet_nature/services/firebase_auth_api.dart';
import 'package:pet_nature/themes/ui_instances.dart';
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
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController = TextEditingController(
    text: '',
  );
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void toggleVisibility() {
    setState(() {
      useObscure = !useObscure;
    });
  }

  void login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      UiInstances.showSnackbar(context, 'Preencha com um email e senha!');
      return;
    }

    setState(() {
      isLoading = true;
    });

    final user = await FirebaseAuthApi.login(
      context,
      emailController.text,
      passwordController.text,
    );

    passwordController.clear();

    setState(() {
      isLoading = false;
    });

    if (user != null) {
      Navigator.of(context).pop();
    }
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
          key: formKey,
          child: Column(
            spacing: 16,
            children: [
              Input(
                placeholder: 'toninho@asimov.com',
                label: 'Email',
                controller: emailController,
              ),
              InputPassword(controller: passwordController),
              SizedBox(height: 24),
              Button('Entrar', login, isLoading: isLoading),
              TextCta('Não possui conta?', 'Cadastrar', () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
