import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_nature/themes/ui_instances.dart';

final _instance = FirebaseAuth.instance;

class FirebaseAuthApi {
  static Future createUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      final createdUser = await _instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

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
      final loggedUser = await _instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return loggedUser;
    } on FirebaseAuthException catch (err) {
      UiInstances.showSnackbar(context, 'Usuário ou senha incorretos!');
      return null;
    }
  }
}
