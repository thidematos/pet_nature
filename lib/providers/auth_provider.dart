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
}

final UserProvider = StateNotifierProvider<userNotifier, Map>(
  (ref) => userNotifier(),
);

final AuthProvider = FutureProvider((ref) async {
  final user = await FirebaseFirestoreApi.verifyUser();

  ref.read(UserProvider.notifier).setUser(user);

  return user;
});
