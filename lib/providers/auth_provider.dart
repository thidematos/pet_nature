import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/services/firebase_firestore_api.dart';

class userNotifier extends StateNotifier<Map> {
  userNotifier() : super({});

  void setUser(user) {
    state = user;
  }

  String get role {
    final role = state['role'];

    return role;
  }

  String get photoUrl {
    final url = state['photo'];
    return url;
  }
  
  void setLoading(bool isLoading) {
    state = {...state, 'isLoading': isLoading};
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
