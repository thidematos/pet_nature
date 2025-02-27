import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/widgets/ui/confirm_password.dart';
import 'package:pet_nature/widgets/ui/input.dart';
import 'package:pet_nature/providers/auth_provider.dart';

class UserInformationProfile extends ConsumerStatefulWidget {
  const UserInformationProfile({super.key});

  @override
  _UserInformationProfileState createState() => _UserInformationProfileState();
}

class _UserInformationProfileState
    extends ConsumerState<UserInformationProfile> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _codeController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _codeController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _saveUserInfo() async {
    final name = _nameController.text;
    final email = _emailController.text;

    if (name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Preencha todos os campos'),
        ),
      );
      return;
    }

    final result = await showDialog<String>(
      context: context,
      builder: (context) => ConfirmPassword('Confirmar'),
    );

    if (result == null || result.isEmpty) {
      return;
    }

        print('Senha retornada: $result');

    final userNotifier = ref.read(UserProvider.notifier);

    try {
      await userNotifier.updateUserInfo(context, {
        'name': name,
        'email': email,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Informações salvas com sucesso'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar informações: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsyncValue = ref.watch(AuthProvider);

    return userAsyncValue.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (err, stack) =>
          Center(child: Text('Erro ao carregar dados do usuário')),
      data: (user) {
        final userData = ref.watch(UserProvider);

        // Preenche os controladores com os dados do usuário
        _nameController.text = userData['name'] ?? '';
        _emailController.text = userData['email'] ?? '';
        _codeController.text = userData['code'] ?? '';

        return Column(
          children: [
            Input(
              placeholder: 'Digite seu nome',
              label: 'Nome',
              controller: _nameController,
            ),
            SizedBox(height: 20),
            Input(
              placeholder: 'Digite seu email',
              label: 'Email',
              controller: _emailController,
            ),
            SizedBox(height: 20),
            Input(
              placeholder: 'Código',
              label: 'Código',
              controller: _codeController,
              readOnly: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveUserInfo,
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}
