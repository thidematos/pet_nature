import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/providers/auth_provider.dart';
import 'package:pet_nature/themes/color_theme.dart';

class UserAvatar extends ConsumerWidget {
  const UserAvatar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url = ref.read(UserProvider.notifier).photoUrl;

    print(url);

    return CircleAvatar(
      backgroundColor: ColorTheme.primary,
      radius: 25,
      foregroundImage: NetworkImage(url),
    );
  }
}
