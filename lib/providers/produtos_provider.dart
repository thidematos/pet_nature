import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_nature/services/firebase_firestore_api.dart';

final ProdutosProvider = FutureProvider(
  (ref) async => await FirebaseFirestoreApi.getProdutos(),
);
