import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/widgets/ui/input.dart';
import 'package:pet_nature/providers/auth_provider.dart';

class UserInformationProfile extends ConsumerStatefulWidget {
  const UserInformationProfile({super.key});

  @override
  _UserInformationProfileState createState() => _UserInformationProfileState();
}

class _UserInformationProfileState extends ConsumerState<UserInformationProfile> {
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

  @override
  Widget build(BuildContext context) {
    final userAsyncValue = ref.watch(AuthProvider);

    return userAsyncValue.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Erro ao carregar dados do usuário')),
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
          ],
        );
      },
    );
  }
}