import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/providers/signup_provider.dart';
import 'package:pet_nature/screens/login_screen.dart';
import 'package:pet_nature/services/firebase_auth_api.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/ui/button.dart';
import 'package:pet_nature/widgets/ui/input.dart';
import 'package:pet_nature/widgets/ui/input_password.dart';
import 'package:pet_nature/widgets/ui/page_title.dart';
import 'package:pet_nature/widgets/ui/text_cta.dart';

class SignupForm extends ConsumerStatefulWidget {
  const SignupForm({super.key});

  @override
  ConsumerState<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends ConsumerState<SignupForm> {
  final formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController(text: '');
  final passwordConfirmationController = TextEditingController(text: '');

  bool isLoading = false;

  @override
  void dispose() {
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }

  resetPasswords() {
    passwordController.clear();
    passwordConfirmationController.clear();
    ref.read(SignupProvider.notifier).resetOnlyPasswords();
  }

  toggleLoader({required bool state}) {
    setState(() {
      isLoading = state;
    });
  }

  submit() async {
    final bool isValidate = formKey.currentState!.validate();

    if (!isValidate) return;

    formKey.currentState!.save();

    final userData = ref.read(SignupProvider);

    if (userData['password']!.compareTo(userData['passwordConfirm']!) != 0) {
      UiInstances.showSnackbar(context, 'As senhas devem coincidir!');
      resetPasswords();
      return;
    }

    final String uniqueCode = ref.read(SignupProvider.notifier).generateCode();

    toggleLoader(state: true);

    final user = await FirebaseAuthApi.createUser(
      context,
      userData['email']!,
      userData['password']!,
    );

    toggleLoader(state: false);

    if (user == null) {
      resetPasswords();
    }

    ref.read(SignupProvider.notifier).reset();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        spacing: 16,
        children: [
          PageTitle(
            'Criar conta',
            subtitle: 'Insira suas informações pessoais abaixo',
          ),
          Input(
            placeholder: 'Toninho Asimov',
            label: 'Nome completo',
            useAutoCapitalization: true,
            onSave: ref.read(SignupProvider.notifier).saveValue,
            keyToSave: 'name',
            validator:
                (value) =>
                    ref.read(SignupProvider.notifier).nameValidator(value),
          ),
          Input(
            placeholder: 'toninho@petnature.com',
            label: 'Email',
            onSave: ref.read(SignupProvider.notifier).saveValue,
            keyToSave: 'email',
            validator:
                (value) =>
                    ref.read(SignupProvider.notifier).emailValidator(value),
          ),
          InputPassword(
            onSave: ref.read(SignupProvider.notifier).saveValue,
            keyToSave: 'password',
            controller: passwordController,
            validator:
                (value) =>
                    ref.read(SignupProvider.notifier).passwordValidator(value),
          ),
          InputPassword(
            label: 'Confirmar senha',
            onSave: ref.read(SignupProvider.notifier).saveValue,
            keyToSave: 'passwordConfirm',
            controller: passwordConfirmationController,
          ),
          const SizedBox(height: 40),
          Button('Criar conta', submit, isLoading: isLoading),
          TextCta('Já possui uma conta?', 'Entrar', () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          }),
        ],
      ),
    );
  }
}
