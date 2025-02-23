import 'package:flutter/material.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/login/login_container.dart';
import 'package:pet_nature/widgets/ui/logo.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              UiInstances.logoToMainContentSpacer,
              LoginContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
