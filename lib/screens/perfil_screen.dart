import 'package:flutter/material.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/ui/page_title.dart';
import 'package:pet_nature/widgets/ui/user_avatar.dart';
import 'package:pet_nature/widgets/ui/user_avatar_profile.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UiInstances.logoToMainContentSpacer,
        PageTitle('Informações Pessoais'),
        UserAvatarProfile(),
      ],
    );
  }
}
