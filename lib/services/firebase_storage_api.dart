import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

final _instance = FirebaseStorage.instance;

class FirebaseStorageApi {
  static uploadUserPhoto(File photo, String userUid) async {
    final storageRef = _instance
        .ref()
        .child('user_photo')
        .child('${userUid}.jpg');

    await storageRef.putFile(photo);

    final photoUrl = await storageRef.getDownloadURL();

    return photoUrl;
  }

  static uploadProdutoImage(File image, String produtoUid) async {
    final storageRef = _instance
        .ref()
        .child('produto_photo')
        .child('$produtoUid.jpg');

    await storageRef.putFile(image);

    final iamgeUrl = await storageRef.getDownloadURL();

    return iamgeUrl;
  }
}
