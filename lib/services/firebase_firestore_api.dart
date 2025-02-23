import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_nature/themes/ui_instances.dart';

final _instance = FirebaseFirestore.instance;

class FirebaseFirestoreApi {
  const FirebaseFirestoreApi();

  static createUser(BuildContext context, Map<String, String> userData) async {
    try {
      final createdUser = await _instance
          .collection('users')
          .doc(userData['uid'])
          .set({
            'name': userData['name'],
            'role': 'leitor',
            'code': userData['code'],
            'email': userData['email'],
            'uid': userData['uid'],
            'created_at': DateTime.now().millisecondsSinceEpoch,
          });

      return createdUser;
    } on FirebaseException catch (err) {
      UiInstances.showSnackbar(context, err.message!);
      return null;
    }
  }
}
