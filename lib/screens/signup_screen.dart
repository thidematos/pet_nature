import 'package:flutter/material.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/signup/signup_form.dart';
import 'package:pet_nature/widgets/ui/logo.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: UiInstances.screenPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: Logo()),
              const SizedBox(height: 40),
              SignupForm(),
            ],
          ),
        ),
      ),
    );
  }
}
