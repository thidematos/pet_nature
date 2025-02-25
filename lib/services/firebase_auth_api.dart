import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet_nature/themes/ui_instances.dart';

class FirebaseAuthApi {
  static Future createUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      final createdUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return createdUser.user;
    } on FirebaseAuthException catch (err) {
      UiInstances.showSnackbar(context, err.message ?? 'Algo deu errado!');
      return null;
    }
  }

  static Future login(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return user;
    } on FirebaseAuthException catch (err) {
      UiInstances.showSnackbar(context, 'Usuário ou senha incorretos!');
      return null;
    }
  }
}
