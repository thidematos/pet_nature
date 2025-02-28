import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/geral_theme.dart';
import 'package:pet_nature/widgets/ui/button.dart';
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
  late TextEditingController _usertypecontroller;
  final loadingProvider = StateProvider<bool>((ref) => false);

  User? user;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _codeController = TextEditingController();
    _usertypecontroller = TextEditingController();

    user = FirebaseAuth.instance.currentUser;

    // Carregar os dados atuais do usuário
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userData = ref.read(UserProvider);
      _nameController.text = userData['name'] ?? '';
      _emailController.text = userData['email'] ?? '';
      _codeController.text = userData['code'] ?? '';
      _usertypecontroller.text = userData['usertype'] ?? '';
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _saveUserInfo() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Defina um nome!')),
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

    try {
      final credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: result,
      );

      // Reautenticação obrigatória para mudar o e-mail
      await user!.reauthenticateWithCredential(credential);

      // Atualiza no Firebase Authentication

      // Atualiza no Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        'name': name,
      });

      // Atualiza no Provider
      ref.read(UserProvider.notifier).updateUserInfo(context, {
        'name': name,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Informações salvas com sucesso')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar informações: ${e.toString()}')),
      );
    }finally {
      ref.read(loadingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loadingProvider);
    return Column(
      children: [
        Input(
          placeholder: 'Digite seu nome',
          label: 'Nome',
          controller: _nameController,
        ),
        SizedBox(height: 20),
        Input(
          placeholder: 'Seu email é...',
          label: 'Email',
          controller: _emailController,
          readOnly: true,
        ),
        SizedBox(height: 20),
        Input(
          placeholder: 'Seu código é...',
          label: 'Código',
          controller: _codeController,
          readOnly: true,
  
        ),
        SizedBox(height: 20),
        Button(
          'Salvar',
          _saveUserInfo,
          isLoading: isLoading,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: FirebaseAuth.instance.signOut,
                child: Text(
                  'Sair',
                  style: TextStyle(color: ColorTheme.secondaryTwo),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
