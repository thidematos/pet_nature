import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
            'photo': userData['photo'],
          });

      return createdUser;
    } on FirebaseException catch (err) {
      UiInstances.showSnackbar(context, err.message!);
      return null;
    }
  }

  static getUser(String userUid) async {
    try {
      final user = await _instance.collection('users').doc(userUid).get();

      return user.data();
    } on FirebaseException catch (err) {
      return err;
    }
  }

  static createProduto(BuildContext context, produto) async {
    try {
      await _instance.collection('produtos').doc(produto['uid']).set(produto);

      return true;
    } on FirebaseException catch (err) {
      UiInstances.showSnackbar(context, err.message!);
      return false;
    }
  }

  static updateProduto(
    BuildContext context,
    updateData,
    String produtoUid,
  ) async {
    try {
      await _instance.collection('produtos').doc(produtoUid).update(updateData);

      return true;
    } on FirebaseAuthException catch (err) {
      UiInstances.showSnackbar(context, err.message!);
      return false;
    }
  }

  static deleteProduto(BuildContext context, String produtoUid) async {
    try {
      await _instance.collection('produtos').doc(produtoUid).delete();
      return true;
    } on FirebaseException catch (err) {
      UiInstances.showSnackbar(context, 'Algo deu errado.');
      return false;
    }
  }

  static verifyUser() async {
    final user =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

    return user.data();
  }

  static getProdutos() async {
    try {
      final produtos = await _instance.collection('produtos').get();

      return produtos.docs.map((produto) => produto.data()).toList();
    } on FirebaseException catch (err) {
      //UiInstances.showSnackbar(context, err.message!);
      return err;
    }
  }
}
