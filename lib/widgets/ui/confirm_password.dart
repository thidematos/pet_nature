import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/services/firebase_auth_api.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/ui/button.dart';
import 'package:pet_nature/widgets/ui/input_password.dart';

class ConfirmPassword extends ConsumerStatefulWidget {
  const ConfirmPassword(this.buttonLabel, {super.key});

  final String buttonLabel;

  @override
  ConsumerState<ConfirmPassword> createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends ConsumerState<ConfirmPassword> {
  final passwordController = TextEditingController(text: '');

  bool isLoading = false;

  void confirmPassword() async {
    final user = FirebaseAuth.instance.currentUser!;

    setState(() {
      isLoading = true;
    });

    final isValidated = await FirebaseAuthApi.validatePassword(
      context,
      user.email!,
      passwordController.text,
    );

    if (!isValidated) {
      setState(() {
        isLoading = false;
      });
      UiInstances.showSnackbar(context, 'Senha incorreta');
      Navigator.of(context).pop();
      return;
    }

    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop(passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorTheme.light,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 24,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Confirme sua senha',
              style: LetterTheme.mainTitle,
              textAlign: TextAlign.left,
            ),
            InputPassword(controller: passwordController, label: 'Senha'),
            SizedBox(height: 16),
            Button(
              widget.buttonLabel,
              confirmPassword,
              isDanger: true,
              isLoading: isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
