import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_nature/providers/auth_provider.dart';
import 'package:pet_nature/themes/color_theme.dart';

class UserAvatarProfile extends ConsumerStatefulWidget {
  const UserAvatarProfile({super.key});

  @override
  _UserAvatarProfileState createState() => _UserAvatarProfileState();
}

class _UserAvatarProfileState extends ConsumerState<UserAvatarProfile> {
  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    

    if (pickedFile != null) {
      final user = FirebaseAuth.instance.currentUser;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_avatars')
          .child('${user!.uid}.jpg');

      await storageRef.putFile(File(pickedFile.path));
      final downloadUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'photoUrl': downloadUrl});

      ref.read(UserProvider.notifier).updatePhotoUrl(downloadUrl);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url = ref.watch(UserProvider.notifier).photoUrl;

    return Column(
      children: [
        CircleAvatar(
          backgroundColor: ColorTheme.primary,
          radius: 45,
          foregroundImage: url != null ? NetworkImage(url) : null,
        ),
        TextButton(
          onPressed: _pickAndUploadImage,
          child: Text('Editar Imagem'),
        ),
      ],
    );
  }
}