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
      if (user == null) return;

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_avatars')
          .child('${user.uid}.jpg');
      ref.read(UserProvider.notifier).setLoading(true);

      await storageRef.putFile(File(pickedFile.path));
      final downloadUrl = await storageRef.getDownloadURL();

      // Atualiza a URL da foto no Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'photo': downloadUrl});

      // Atualiza a URL da foto no UserProvider
      ref.read(UserProvider.notifier).updatePhotoUrl(downloadUrl);
      ref.read(UserProvider.notifier).setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final url = ref.watch(UserProvider)['photo'];
    final isLoading = ref.watch(UserProvider)['isLoading'] ?? false;

    if (isLoading) {
      return Center(
          child: CircularProgressIndicator(color: ColorTheme.secondaryTwo));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: ColorTheme.primary,
                  radius: 50,
                  foregroundImage: url != null ? NetworkImage(url) : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: ColorTheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: _pickAndUploadImage,
                      icon: Icon(Icons.edit_rounded,
                          size: 15, color: ColorTheme.secondaryTwo),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}