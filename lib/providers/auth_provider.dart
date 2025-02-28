import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/services/firebase_firestore_api.dart';
import 'package:pet_nature/widgets/ui/confirm_password.dart';

class userNotifier extends StateNotifier<Map> {
  userNotifier() : super({});

  void setUser(Map<String, dynamic> user) {
    state = user;
  }

  String get role {
    final role = state['role'];
    return role;
  }

  String get usertype {
    final usertype = state['usertype'];
    return usertype;
  }

  String get photoUrl {
    final url = state['photo'];
    return url;
  }
  
  void setLoading(bool isLoading) {
    state = {...state, 'isLoading': isLoading};
  }

  Future<void> updateUserInfo(BuildContext context, Map<String, String> userInfo) async {
    setLoading(true);
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      if (userInfo.containsKey('name')) {
        await user.updateDisplayName(userInfo['name']);
        state = {...state, 'name': userInfo['name']};
      }
      if (userInfo.containsKey('usertype')) {
        await user.updateDisplayName(userInfo['usertype']);
        state = {...state, 'usertype': userInfo['usertype']};
      }
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(userInfo, SetOptions(merge: true));
    }

    state = {...state, ...userInfo, 'isLoading': false};
  }

  Future<void> updatePhotoUrl(String url) async {
    state = {...state, 'photo': url};
    await FirebaseAuth.instance.currentUser?.updatePhotoURL(url);
    state = {...state, 'photo': url, 'isLoading': false};
  }
}

final UserProvider = StateNotifierProvider<userNotifier, Map>(
  (ref) => userNotifier(),
);

final AuthProvider = FutureProvider((ref) async {
  final user = await FirebaseFirestoreApi.verifyUser();

  ref.read(UserProvider.notifier).setUser(user);

  return user;
});
