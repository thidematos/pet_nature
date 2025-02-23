import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final formInitialValues = {
  'name': '',
  'email': '',
  'password': '',
  'passwordConfirm': '',
  'code': '',
};

final uuid = Uuid();

class SignupNotifier extends StateNotifier<Map<String, String>> {
  SignupNotifier() : super({});

  String generateCode() {
    final String code = uuid.v4().substring(0, 7).toUpperCase();

    return code;
  }

  void saveValue(String key, String value) {
    state = {...state, key: value};
  }

  nameValidator(String? value) {
    if (value == null || value.trim().length < 3) {
      return 'Adicione seu nome!';
    }

    return null;
  }

  emailValidator(String? value) {
    if (value == null || !value.contains('@petnature.com')) {
      return 'Email inválido!';
    }

    return null;
  }

  passwordValidator(String? value) {
    if (value == null || value.length < 6) {
      return 'Escolha uma senha elaborada!';
    }

    return null;
  }

  resetOnlyPasswords() {
    state = {...state, 'password': '', 'passwordConfirm': ''};
  }

  reset() {
    state = formInitialValues;
  }
}

final SignupProvider =
    StateNotifierProvider<SignupNotifier, Map<String, String>>(
      (ref) => SignupNotifier(),
    );
